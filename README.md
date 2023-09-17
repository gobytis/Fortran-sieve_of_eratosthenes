# sieve_of_eratosthenes

## Summary

This is a Fortran class to apply sieve of Eratosthenes.

## Usage

A following command shows prime numbers in the range of [0, 10]  and the number of output prime numbers.

```
> sieve_of_eratosthenes.exe 10
```

A following command write prime numbers  in the range of [0, 10]  to `primes.txt`. 

```
> sieve_of_eratosthenes.exe 10 primes.txt
```

Use `class_sieve_of_eratosthenes` module to use sieve_of_eratosthenes in your project.

```fortran
use class_sieve_of_eratosthenes

! Upper limit of prime numbers detection.
integer upper_limit
! Class performing sieve of eratosthenes.
type(sieve_of_eratosthenes) sieve

! Get prime numbers array as int32 
! whose range is [2, upper_limit].
prime_numbers = sieve%sieve(upper_limit)
```

