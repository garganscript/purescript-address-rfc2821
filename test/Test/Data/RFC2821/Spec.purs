module Test.Data.RFC2821.Spec where

import Data.Either (Either(..), isLeft, isRight)
import Data.RFC2821 as RFC2821
import Debug (spy)
import Prelude
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)


spec :: Spec Unit
spec =
  describe "RFC2821" do
    it "works for simple email" do
      let address = RFC2821.makeAddress "admin@localhost.localdomain"
      let original = (\a -> RFC2821.original a) <$> address
      let host = (\a -> RFC2821.host a) <$> address
      let user = (\a -> RFC2821.user a) <$> address
      original `shouldEqual` (Right "admin@localhost.localdomain")
      host `shouldEqual` (Right "localhost.localdomain")
      user `shouldEqual` (Right "admin")

    it "works for incorrect email" do
      let address = RFC2821.makeAddress "admin"
      -- shouldSatisfy requires a Show instance for the underlying type
      isLeft address `shouldEqual` true
    
    it "shouldn't parse email with symbols surrounding it" $ do
      let address = RFC2821.makeAddress "'admin@localhost.localdomain'"
      isLeft address `shouldEqual` true

    it "parses email with <>" $ do
      let address = RFC2821.makeAddress "<admin@localhost.localdomain>"
      isRight address `shouldEqual` true

    it "reformatting address as string works" $ do
      let address = RFC2821.makeAddress "<admin@localhost.localdomain>"
      let addressStr = (\a -> RFC2821.address a) <$> address
      addressStr `shouldEqual` (Right "admin@localhost.localdomain")

    it "reformatting address as envelope works" $ do
      let address = RFC2821.makeAddress "admin@localhost.localdomain"
      let envelopeStr = (\a -> RFC2821.toString a) <$> address
      envelopeStr `shouldEqual` (Right "<admin@localhost.localdomain>")
