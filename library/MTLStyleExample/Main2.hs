{-# OPTIONS_GHC -fno-warn-missing-signatures #-}
module MTLStyleExample.Main2 where

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
main = do
  let time       = make @Time registry
  let logger     = make @Logger registry
  let fileSystem = make @FileSystem registry
  let arguments  = make @Arguments registry

  startTime  <- time & getCurrentTime
  [fileName] <- arguments & getArguments
  target     <- fileSystem & readFile $ fileName
  logger & info $ "Hello, " <> target <> "!"

  endTime <- time & getCurrentTime
  let duration = endTime `diffUTCTime` startTime
  logger & info $ T.pack (show (round (duration * 1000) :: Integer)) <> " milliseconds"

registry =
     fun Time.new
  +: fun FileSystem.new
  +: fun Logger.new
  +: fun Arguments.new
  +: end
