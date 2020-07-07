module URI.Encoder (enc, dec) where

import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as BC
import Numeric (showHex, readHex)
import Data.Word
import Data.Char

enc :: BS.ByteString -> BS.ByteString
enc b = BS.concatMap escape b
  where escape a
          | unreserved a = BS.pack [a]
          | otherwise    = BS.concat [(BS.pack $ [fromIntegral 37]), BC.pack $ (\x -> replicate (2 - length x) '0' ++ x) $ showHex a ""]

unreserved :: Word8 -> Bool
unreserved a = a == 45 || a == 46 || a == 95 || a == 126 || (a >= 65 && a <= 90) || (a >= 97 && a <= 122)

dec :: BS.ByteString -> BS.ByteString
dec b = BS.concat $ [head s] ++ (unescape $ tail s)
  where s = (BS.split 37 b) ++ [BC.pack ""]
        unescape (a:as)
          | (BS.length $ BS.take 2 a) == 2 = [BC.pack [chr $ fst $ head $ readHex $ BC.unpack $ BS.take 2 a]]
                                            ++ [BS.drop 2 a] ++ unescape as
          | otherwise = unescape as
        unescape []     = []
