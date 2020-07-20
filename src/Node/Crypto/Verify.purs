module Node.Crypto.Verify
  ( Object
  , Data
  , Signature
  , verify
  , verify2
  ) where

import Prelude
import Data.Newtype (class Newtype, unwrap)
import Effect (Effect)
import Node.Buffer (Buffer)
import Node.Crypto.Hash (Algorithm)

foreign import data Verify ∷ Type

newtype Object = Object Buffer

derive instance ntObject ∷ Newtype Object _
newtype Data = Data Buffer

derive instance ntData ∷ Newtype Data _
newtype Signature = Signature Buffer

derive instance ntSignature ∷ Newtype Signature _
verify2 ∷ Algorithm -> Buffer -> Buffer -> Buffer -> Effect Boolean
verify2 alg object dat signature = do
  createVerify alg >>= flip _update dat >>= flip (flip _verify object) signature

verify ∷ Algorithm -> Object -> Data -> Signature -> Effect Boolean
verify alg object dat signature = do
  let
    objBuff = unwrap $ object
    dataBuf = unwrap $ dat
    signBuf = unwrap $ signature
  createVerify alg >>= flip _update dataBuf >>= flip (flip _verify objBuff) signBuf

createVerify ∷ Algorithm -> Effect Verify
createVerify alg = _createVerify (show alg)

foreign import _createVerify ∷ String -> Effect Verify

foreign import _update ∷ Verify -> Buffer -> Effect Verify

foreign import _verify ∷ Verify -> Buffer -> Buffer -> Effect Boolean
