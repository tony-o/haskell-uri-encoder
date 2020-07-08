{-# LANGUAGE OverloadedStrings #-}
import Criterion.Main
import Data.ByteString()
import Network.URI
import qualified URI.Encoder as UE

escape :: String -> String
escape = escapeURIString isUnreserved

main :: IO ()
main = defaultMain [bgroup "" [
  bgroup "ENCODE" [
    bench "Network.URI" $ nf escape "/package/criterion-1.5.6.2/docs/Criterion-Main.html",
    bench "URI.Encoder" $ nf UE.enc "/package/criterion-1.5.6.2/docs/Criterion-Main.html"
  ],
  bgroup "DECODE" [
    bench "Network.URI" $ nf unEscapeString "%2Fpackage%2Fcriterion-1.5.6.2%2Fdocs%2FCriterion-Main.html",
    bench "URI.Encoder" $ nf UE.dec "%2Fpackage%2Fcriterion-1.5.6.2%2Fdocs%2FCriterion-Main.html"
  ]]]
