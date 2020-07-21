module Node.Crypto.Verify where

import Prelude
import Effect (Effect)
import Node.Buffer (Buffer)
import Node.Crypto.Hash (Algorithm)

foreign import data Verify ∷ Type

verify ∷ Algorithm -> String -> String -> Buffer -> Effect Boolean
verify alg object dat signature = do
  createVerify alg >>= flip _update dat >>= flip (flip _verify object) signature

createVerify ∷ Algorithm -> Effect Verify
createVerify alg = _createVerify (show alg)

foreign import _createVerify ∷ String -> Effect Verify

foreign import _update ∷ Verify -> String -> Effect Verify

foreign import _verify ∷ Verify -> String -> Buffer -> Effect Boolean
