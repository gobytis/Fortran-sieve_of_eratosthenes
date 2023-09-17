# sieve_of_eratosthenes

## Summary

This is a Fortran class to apply sieve of Eratosthenes.

## Usage

A following command shows prime numbers in the range of [0, `upper_limit`]  and the number of output prime numbers.

```
> sieve_of_eratosthenes.exe <upper_limit>
```

A following command write prime numbers  in the range of [0, `upper_limit`]  to <`output_file`>. 

```
> sieve_of_eratosthenes.exe <upper_limit> <output_file>
```

When getting no prime number, it returns an array with the size 0. 

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

