# URI.Encoder

URI.Encoder aims to be a fast uri component encoder/decoder.  It encodes any `word8` not specified as unreserved in [RFC3986](https://tools.ietf.org/html/rfc3986#section-2.2)

This module assumes you are feeding it a valid escape sequence in the decoder.

# Usage

```haskell
λ> :set -XOverloadedStrings
λ> import URI.Encoder
λ> enc "hello world!"
"hello%20world%21"
λ> dec "%79%6F%75%20%61%72%65%20%6E%6F%77%20%69%6D%6D%6F%72%74%61%6C"
"you are now immortal"
```

# Benchmark

This is mostly an exercise inspired by [dnmfarrell](https://github.com/dnmfarrell/Percent-Encoder)

```
benchmarking ENCODE/Network.URI
time                 1.650 μs   (1.644 μs .. 1.657 μs)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 1.657 μs   (1.647 μs .. 1.674 μs)
std dev              41.29 ns   (23.83 ns .. 81.24 ns)
variance introduced by outliers: 31% (moderately inflated)

benchmarking ENCODE/URI.Encoder
time                 998.0 ns   (993.7 ns .. 1.003 μs)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 995.6 ns   (992.1 ns .. 1.004 μs)
std dev              15.96 ns   (9.476 ns .. 29.48 ns)
variance introduced by outliers: 17% (moderately inflated)

benchmarking DECODE/Network.URI
time                 521.0 ns   (519.2 ns .. 523.6 ns)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 520.5 ns   (518.8 ns .. 523.6 ns)
std dev              7.745 ns   (5.378 ns .. 12.66 ns)
variance introduced by outliers: 15% (moderately inflated)

benchmarking DECODE/URI.Encoder
time                 435.1 ns   (432.0 ns .. 438.6 ns)
                     1.000 R²   (0.999 R² .. 1.000 R²)
mean                 434.7 ns   (432.0 ns .. 438.4 ns)
std dev              10.63 ns   (8.417 ns .. 13.68 ns)
variance introduced by outliers: 33% (moderately inflated)
```

# Build Status

[![Build Status](https://travis-ci.org/tony-o/haskell-uri-encoder.svg?branch=master)](https://travis-ci.org/tony-o/haskell-uri-encoder)
