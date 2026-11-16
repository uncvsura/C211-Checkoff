This code is copied over from another project of mine where I was trying to find all primes up to a certain N, using sieve methods, to do this you need an array that can store the primalities of all numbers up to N.

There are two different sieves, one that uses a bool array, and one that uses a uint_8 array. The former is not bitsetted, the latter is.

Open repo and run "make" in terminal to compile everything. Ignore warnings.

Run "./primeGen" to start the non-bitsetted prime generating algorithm.

Run "./bitSieve" to start the bitsetted prime generating algorithm.

Both will ask for a power of 10 as input and will generate all prime numbers up to this power of 10.

For example: inputting 9 will generate all primes up to 10^9 = 1 billion, and it will output pi(1 billion), which is the count of prime numbers under 1 billion.

It will also ask whether you want to print the list of primes, 1 for yes, 0 for no. Be warned that printing takes a while.

Rules of thumb: 

For the bitsieve you need N bits of RAM to generate primes up to N. Generating primes up to 10 billion will require approximately 1.25 GB of RAM.

For the non-bitsieve, you need N BYTES of RAM. 10 billion would require 10 GB of RAM. Proceed with caution.
