module RegistryExample.FileSystem where

import Protolude hiding (readFile)
import qualified Prelude ()
import qualified Protolude as P

data FileSystem = FileSystem {
    readFile :: Text -> IO Text
  }

new :: FileSystem
new = FileSystem {
    readFile = P.readFile . toS
  }
