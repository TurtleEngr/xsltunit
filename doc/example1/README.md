# Example 1

## Testing with Makefile

**make test** - this is the top test. Two report files are
created. One that lists all passed and failed tests, and another that
only lists failed tests.

**make run-test** and **make report** targets can be refactored to run
multiple test suites.

**make validate** uses xmllint to verify the xml files are valid and
that DTD is being followed.

**make reformat** uses xmllint to reformat the xml and xsl code so
they have a constant format. Blank lines are added (with an awk
script) after "template" and "when" elements.

**make clean** will remove all of the generated files.

## TDD Flow

## First time:

    make test
    Point browser at *.fail.result.html file. For example:
    firefox tst_update_quality.xsl.fail.result.html &>/dev/null &

## A. Test Iteration

1. Create new test (that fail) for a new feature.
1. make test
1. Refreash the browser page
1. Edit your application *.xsl file(s) (or tests) to make test pass.
1. Repeat Test Iteration until the tests pass.
1. Do Refactor Iteration

## B. Refactor Iteration

1. When tests pass.
1. "Clean" the code and the tests.
1. Repeat Refactor Iteration until the tests pass.
1. Do Test Iteration
