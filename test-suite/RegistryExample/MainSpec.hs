{-# OPTIONS_GHC -fno-warn-missing-signatures #-}

module RegistryExample.MainSpec where

import           Data.IORef
import           Data.Registry hiding (messages)
import           Protolude
import           RegistryExample.Main
import           RegistryExample.Test.Stubs
import           Test.Hspec

spec = describe "main" $ do
  logMessages <- runIO $ messages

  it "prints two log messages" $ do
    length logMessages `shouldBe` 2

  it "prints a greeting as the first message" $ do
    (logMessages !! 0) `shouldBe` "Hello, Alyssa!"

  it "prints the elapsed time in milliseconds as the second message" $ do
    (logMessages !! 1) `shouldBe` "1000 milliseconds"

messages = do
  ticking <- newTickingTime
  ref <- newIORef ([] :: [Text])
  let testRegistry =
           funTo @IO (newArguments ["sample.txt"])
        +: funTo @IO (newFileSystem [("sample.txt", "Alyssa")])
        +: funTo @IO (newLogger ref)
        +: funTo @IO ticking
        +: registry

  mainWith testRegistry
  readIORef ref
