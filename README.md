ANTLR4 GraphQL Grammar
======================

A simple [ANTLR4](https://www.antlr.org/) grammar that can parse [GraphQL language (October 2021 Edition)](https://spec.graphql.org/October2021/).

This project provides a plain grammar file, also unit tests suite for the grammar.

Usage
-----

The grammar file is at [`/src/main/antlr4/GraphQL.g4`](src/main/antlr4/GraphQL.g4).
Use ANTLR4 to generate parser from it.

For example, to generate Swift implementation, use following command.
```
antlr -Dlanguage=Swift -o output -Xexact-output-dir -message-format gnu src/main/antlr4/GraphQL.g4 
```
The parser is generated at `output`.

Unit tests
----------

It contains [GraphQL Compatibility Acceptance Tests (graphql-cats)](https://github.com/graphql-cats/graphql-cats) schema parser test cases.
Test suite is written in Scala, so use [sbt](https://www.scala-sbt.org/) to run it.

```
sbt test
```

It generates Java implementation and run unit tests on it.

Grammar implementation
----------------------

The grammar implements GraphQL language October 2021 Edition syntax.

It only contains lexer and parser, therefore it can be used for generating any language implementation.
However, because of that, each application has a responsibility to materialize such as literal values from parse result.
