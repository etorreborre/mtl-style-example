module RegistryExample.Arguments where

import           Protolude
import           Data.Text as T
import qualified Prelude ()
import qualified Protolude as P

data Arguments = Arguments {
    getArguments :: IO [Text]
  }

new :: Arguments
new = Arguments {
    getArguments = (fmap T.pack) <$> P.getArgs
  }
