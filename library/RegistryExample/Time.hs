module RegistryExample.Time where

import qualified Control.Monad.Time  as Time (MonadTime (..), currentTime)
import           Data.Time.Clock    (UTCTime)

data Time = Time {
    getCurrentTime :: IO UTCTime
  }

new :: Time
new = Time {
    getCurrentTime = Time.currentTime
  }
