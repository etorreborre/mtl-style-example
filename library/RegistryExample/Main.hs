{-# LANGUAGE RecordWildCards #-}
{-# OPTIONS_GHC -fno-warn-missing-signatures #-}

module RegistryExample.Main where

import qualified Data.Text                  as T

import           Data.Registry
import           Data.Time.Clock            (diffUTCTime)
import qualified Prelude                    ()
import           Protolude                  hiding (readFile)
import           RegistryExample.Arguments  as Arguments
import           RegistryExample.FileSystem as FileSystem
import           RegistryExample.Logger     as Logger
import           RegistryExample.Time       as Time

main :: IO ()
main = mainWith registry

mainWith r = do
  let Arguments {..}  = make @Arguments r
  let FileSystem {..} = make @FileSystem r
  let Logger {..}     = make @Logger r
  let Time  {..}      = make @Time r
  startTime  <- getCurrentTime
  [fileName] <- getArguments
  target     <- readFile $ fileName
  info $ "Hello, " <> target <> "!"

  endTime <- getCurrentTime
  let duration = endTime `diffUTCTime` startTime
  info $ T.pack (show (round (duration * 1000) :: Integer)) <> " milliseconds"

registry =
     fun Time.new
  +: fun FileSystem.new
  +: fun Logger.new
  +: fun Arguments.new
  +: end
