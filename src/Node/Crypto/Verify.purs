module Node.Crypto.Verify
  ( StringOrBuffer
  , Data
  , Signature
  , verify
  , verify2
  ) where

import Prelude
import Data.Newtype (class Newtype, unwrap)
import Effect (Effect)
import Node.Crypto (KeyObject)
import Node.Crypto.Hash (Algorithm)

foreign import data Verify ∷ Type

derive instance ntData ∷ Newtype Data _
newtype Data = Data StringOrBuffer

derive instance ntSignature ∷ Newtype Signature _
newtype Signature = Signature StringOrBuffer

data StringOrBuffer
  = String
  | Buffer

verify2 ∷ Algorithm -> KeyObject -> StringOrBuffer -> StringOrBuffer -> Effect Boolean
verify2 alg object dat signature = do
  createVerify alg >>= flip _update dat >>= flip (flip _verify object) signature

verify ∷ Algorithm -> KeyObject -> Data -> Signature -> Effect Boolean
verify alg object dat signature = do
  let
    dataBuf = unwrap $ dat
    signBuf = unwrap $ signature
  createVerify alg >>= flip _update dataBuf >>= flip (flip _verify object) signBuf

createVerify ∷ Algorithm -> Effect Verify
createVerify alg = _createVerify (show alg)

foreign import _createVerify ∷ String -> Effect Verify

foreign import _update ∷ Verify -> StringOrBuffer -> Effect Verify

foreign import _verify ∷ Verify -> KeyObject -> StringOrBuffer -> Effect Boolean
