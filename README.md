# WickedByte Coding Standard

Custom PHP_CodeSniffer rules for WickedByte projects based on
the [PER Coding Style 2.0](https://www.php-fig.org/per/coding-style/)
standard, and using customized rules from the [Slevomat Coding Standard](https://github.com/slevomat/coding-standard)
project.

## Installation and Contributing
This is a dockerized project, with a `Makefile` to help with common tasks. To get
started, clone the repository and run the following command to install the dependencies:

```bash
make
```

## Other Standards & Conventions Not Enforced by PHP_CodeSniffer:

1. Variables should be in `snake_case` unless they are shadowing parameters defined in function or method from a
   third-party library. This caveat is intended to prevent problems with named parameters, and vendor compatibility.)
2. Methods and functions, except for class `__construct` and `__destruct` methods, MUST have a defined return type.
3. Anonymous and arrow functions MUST have a defined parameter and return types.
4. Parameters MUST have defined types, unless they are extending/implementing a third-party library method or function
   that does not allow it.
5. Class properties MUST have defined types.
6. Enum cases must be in PascalCase, unless they are less than 4 characters long, and do not conflict with class
   constants.
