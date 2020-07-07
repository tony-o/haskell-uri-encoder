{-# LANGUAGE OverloadedStrings #-}
import Control.DeepSeq
import Control.Exception
import Formatting
import Formatting.Clock
import System.Clock
import Test.QuickCheck
import Test.QuickCheck.Instances.ByteString()
import qualified Data.ByteString as BS
import qualified Network.URI.Encode as NUE
import qualified URI.Encoder as U

arbitraryByteStringVector :: Int -> IO [BS.ByteString]
arbitraryByteStringVector n = generate (vectorOf n arbitrary)

-- https://www.stackbuilders.com/news/obverse-versus-reverse-benchmarking-in-haskell-with-criterion
clockIt :: a -> IO ()
clockIt it = do
  start <- getTime Monotonic
  _ <- evaluate it
  end <- getTime Monotonic
  fprint (timeSpecs % "\n") start end

strictify :: (BS.ByteString -> BS.ByteString) -> [BS.ByteString] -> [BS.ByteString]
strictify f xs = xs `deepseq` map f xs

main :: IO ()
main = do
  al <- arbitraryByteStringVector 10000000
  putStr "Warmup: "
  (clockIt . (strictify U.enc)) al
  putStr "URI.Encoder.enc: "
  (clockIt . (strictify U.enc)) al
  putStr "Network.URI.Encode.encodeByteString: "
  (clockIt . (strictify NUE.encodeByteString)) al
  putStr "URI.Encoder.decode: "
  (clockIt . (strictify U.dec)) al
  putStr "Network.URI.Encode.decodeByteString: "
  (clockIt . (strictify NUE.decodeByteString)) al
