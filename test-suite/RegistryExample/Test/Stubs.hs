{-# OPTIONS_GHC -fno-warn-missing-signatures #-}
module RegistryExample.Test.Stubs where

import           Data.IORef
import           Data.Time.Clock            (addUTCTime, NominalDiffTime)
import qualified Data.Time.Clock            as Clock (getCurrentTime)
import qualified Prelude                    as Prelude
import           Protolude                  hiding (readFile)
import           RegistryExample.Arguments
import           RegistryExample.FileSystem
import           RegistryExample.Logger
import           RegistryExample.Time

newArguments :: [Text] -> Arguments
newArguments ts = Arguments { getArguments = pure ts }

newFileSystem :: [(Text, Text)] -> FileSystem
newFileSystem files = FileSystem {
    readFile = \path -> do
      case Prelude.lookup path files of
        Nothing ->
          Prelude.error $ "readFile: no such file ‘" <> show path <> "’"

        Just content -> pure content
  }

newLogger :: IORef [Text] -> Logger
newLogger ref = Logger {
     info = \t -> modifyIORef ref (t:)
  }

newTickingTime :: IO Time
newTickingTime = do
   ticks <- newIORef (0 :: NominalDiffTime)
   current <- Clock.getCurrentTime
   pure $ Time {
     getCurrentTime = do
       tick <- readIORef ticks
       modifyIORef ticks (+1)
       pure (addUTCTime tick current)
   }
