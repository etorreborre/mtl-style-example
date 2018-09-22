module RegistryExample.Logger where

import Control.Monad.Logger (logInfoN, runStderrLoggingT)
import Protolude

data Logger = Logger {
    info :: Text -> IO ()
  }

new :: Logger
new = Logger {
    info = runStderrLoggingT . logInfoN
  }
