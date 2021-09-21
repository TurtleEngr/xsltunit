# xsltunit

## Branch: develop

The "develop" branch is for actively developed code. The initial code
in the archive branch has been reorganize and refactored. The examples
have also been cleaned up. Hopefully the refactored examples and code
make this library easier to use.

## Branch: main

Stable code and examples will be copied to the "main' branch. Usually
the "develop" branch will be merged to the "main" branch. The "main"
branch should never be used for development.

----

## Branch: archive

The "archive" branch documents the original source for xsltunit and example2.

### src/xsltunit Source

The initial code came from [xsltunit.org](http://xsltunit.org/0/)
See src/xsltunit.org/0/index.html for the 

    mkdir src
    cd src
    wget -mk -np mSrc=http://xsltunit.org/0/

### doc/example1/ Source

This example initially came from src/xsltunit.org/0/

    mkdir -p doc/example1/
    cd doc/example1/
    cp ../../src/xsltunit.org/0/* .

### doc/example2/ Source

This example code comes from this Kata:
[kata-log.rocks/gilded-rose-kata](https://kata-log.rocks/gilded-rose-kata)

The xslt code was copied from repo:
[github](https://github.com/emilybache/GildedRose-Refactoring-Kata/tree/main/xslt)

    mkdir -p doc/example2
    cd doc/example2
    git clone git@github.com:emilybache/GildedRose-Refactoring-Kata.git
    mv GildedRose-Refactoring-Kata/xslt/* .
    rm -rf GildedRose-Refactoring-Kata
