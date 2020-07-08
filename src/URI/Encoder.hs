module URI.Encoder (enc, dec) where

import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as BC
import qualified Data.Vector as DomesticViolence
import Data.Word

enc :: BS.ByteString -> BS.ByteString
enc b = BS.concatMap enc' b

enc' :: Word8 -> BS.ByteString
enc' f = DomesticViolence.unsafeIndex th'' (fromIntegral f)

unreserved :: Word8 -> Bool
unreserved a = a == 45 || a == 46 ||a == 95 || a == 126 || (a >= 65 && a <= 90) || (a >= 97 && a <= 122)

dec :: BS.ByteString -> BS.ByteString
dec b
  | BS.null b = b
  | otherwise = BS.concat $ [head b'] ++ [(fx $ tail b')]
    where b' = BS.split 37 b
          fx :: [BS.ByteString] -> BS.ByteString
          fx (ff:fz) = BS.concat $ [BS.pack $ [
              (x' * 16) + y'
            ], z] ++ [fx fz]
            where x = BS.head ff
                  y = BS.head $ BS.drop 1 ff
                  x' = if x > 57 then (if x > 70 then x - 87 else x - 55) else x - 48
                  y' = if y > 57 then (if y > 70 then y - 87 else y - 55) else y - 48
                  z = BS.drop 2 ff
          fx [] = BS.pack []

f'' = foldr (\c a -> BS.pack (if unreserved c then [c] else (37 : (if c < 16 then [48] else []) ++ th [c])) : a) [] [0..255]
th' = DomesticViolence.fromList [48,49,50,51,52,53,54,55,56,57,65,66,67,68,69,70];
th'' = DomesticViolence.fromList f''
th :: [Word8] -> [Word8]
th [] = []
th (f:fs)
  | f >= 16   = [th' DomesticViolence.! (fromIntegral r')] ++ th [f - (16 * r')] ++ th fs
  | otherwise = [th' DomesticViolence.! (fromIntegral f)] ++ th fs
    where r' = f `div` 16
