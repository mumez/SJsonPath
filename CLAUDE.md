# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

SJsonPath is a Smalltalk library that provides a fluent API for creating JsonPath expression strings with support for property access, array indexing, slicing, wildcards, and recursive search. The project is structured as a Pharo/Smalltalk package using the Tonel format with Metacello baseline configuration.

## Architecture

The project consists of three main packages:

- **SJsonPath-Core**: Contains the main `SjJsonPath` class that implements the fluent API for building JsonPath expressions
- **SJsonPath-Tests**: Contains test cases in `SjJsonPathTestCase` and `SjJsonPathFilterExpressionTestCase` classes
- **BaselineOfSJsonPath**: Metacello baseline configuration for package management and dependencies

The core architecture is built around:
- `SjJsonPath` class with a `tokens` instance variable that stores path components
- Fluent API design allowing method chaining to build JsonPath expressions
- Class-side factory methods `root` for creating root JsonPath instances and `all` for wildcard expressions

## Key Components

- `src/SJsonPath-Core/SjJsonPath.class.st`: Main implementation with fluent API methods
- `src/SJsonPath-Tests/SjJsonPathTestCase.class.st`: Test suite with basic path creation tests and array slice tests
- `src/SJsonPath-Tests/SjJsonPathFilterExpressionTestCase.class.st`: Test suite for filter expression functionality
- `src/SJsonPath-Core/SjJsonPathFilterExpression.class.st`: Filter expression implementation for JsonPath conditions
- `src/SJsonPath-Core/SjJsonPathRegex.class.st`: Regex pattern implementation for JsonPath regex matching
- `src/SJsonPath-Core/Object.extension.st`: Extension providing default `asJsonPathTokenString` and `asJsonPathRegex` implementations
- `src/SJsonPath-Core/String.extension.st`: Extension providing string comparison support for filter expressions
- `src/SJsonPath-Core/Interval.extension.st`: Extension providing array slice formatting for Interval objects
- `src/BaselineOfSJsonPath/BaselineOfSJsonPath.class.st`: Metacello baseline defining package structure and dependencies

## Implemented API Methods

The `SjJsonPath` class implements the following fluent API methods:

- `/ otherPath`: Property access using dot notation (e.g., `$.store.book`)
- `@ index`: Array index access using bracket notation (e.g., `$.users[0]`)
- `@ interval`: Array slice access using interval notation (e.g., `$.book[0:2]` for `'book' @ (0 to: 2)`)
- `@ (SjJsonPath first: n)`: First n elements slice notation (e.g., `$.book[:3]` for `'book' @ (SjJsonPath first: 3)`)
- `@ (SjJsonPath last: n)`: Last n elements slice notation (e.g., `$.book[-1:]` for `'book' @ (SjJsonPath last: 1)`)
- `@ SjJsonPath all`: Array wildcard access using bracket notation (e.g., `$.store.book[*].author`)
- `/ SjJsonPath all`: Property wildcard access using dot notation (e.g., `$.store.*`)
- `// otherPath`: Recursive/descendant search using double dot (e.g., `$.store..title`)
- `? filterExpression`: Filter expression using conditions (e.g., `$.store.book[?(@.price < 15)]`)
- `=~ pattern`: Regex matching in filter expressions (e.g., `$.inventory.mountain_bikes[?(@.specs.material =~ 'al')]`)
- `asString`: Converts the JsonPath to its string representation

### Helper Methods

- `dot`: Returns '.' for property separation
- `doubleDot`: Returns '..' for recursive search
- `arrayEnclosed: index`: Returns array notation using `asJsonPathTokenString` for proper formatting
- `Object >> asJsonPathTokenString`: Default implementation returning `self asString`
- `Object >> asJsonPathRegex`: Default implementation creating `SjJsonPathRegex` instance
- `Interval >> asJsonPathTokenString`: Specialized implementation for array slices (e.g., `'0:2'`)
- `SjJsonPathRegex >> asJsonPathTokenString`: Returns the regex pattern string

### Class-side Utility Methods

- `SjJsonPath class >> first: n`: Returns slice notation for first n elements (e.g., `':3'`)
- `SjJsonPath class >> last: n`: Returns slice notation for last n elements (e.g., `'-1:'`)
- `SjJsonPath class >> current`: Returns current context '@' for filter expressions
- `SjJsonPathRegex class >> pattern: aString`: Creates regex pattern instance

### Filter Expression Methods

- `SjJsonPathFilterExpression >> < otherExpression`: Less than comparison
- `SjJsonPathFilterExpression >> > otherExpression`: Greater than comparison
- `SjJsonPathFilterExpression >> = otherExpression`: Equality comparison (becomes '==' in JsonPath)
- `SjJsonPathFilterExpression >> & otherExpression`: Logical AND operation (becomes '&&' in JsonPath)
- `SjJsonPath >> =~ pattern`: Regex matching operation (becomes '=~' in JsonPath)
- `String >> asJsonPathTokenString`: For filter expressions, wraps strings in single quotes

### Regex Expression Methods

- `SjJsonPathRegex >> ignoreCase`: Returns case-insensitive regex pattern with '(?i)' flag
- `SjJsonPathRegex >> pattern`: Returns the regex pattern string
- `SjJsonPathRegex >> asJsonPathRegex`: Returns self (identity method)

## Development Commands

### Installation
```smalltalk
Metacello new
  baseline: 'SJsonPath';
  repository: 'github://mumez/SJsonPath/src';
  load.
```

### Running Tests
Since this uses Pharo/Smalltalk testing framework, tests can be run using:
```smalltalk
SjJsonPathTestCase suite run
SjJsonPathFilterExpressionTestCase suite run
```

Or run all SJsonPath tests:
```smalltalk
TestSuite named: 'SJsonPath-Tests' do: [ :suite | suite run ]
```

## Current State

The project has implemented the complete fluent API:
- Core `SjJsonPath` class with working fluent API methods (`/`, `@`, `//`, `?`)
- Main test class `SjJsonPathTestCase` with methods covering basic functionality, array slice support, wildcard expressions, and first/last slice notation
- Filter expression test class `SjJsonPathFilterExpressionTestCase` with tests for basic filter expressions, string comparisons, multiple conditions, and regex matching
- Token-based architecture for building JsonPath expressions
- String conversion via `asString` method that concatenates all tokens
- Array slice support through Interval objects with proper JsonPath slice notation (e.g., `[0:2]`)
- Advanced slice support with `first:` and `last:` class methods for common slice patterns (e.g., `[:3]`, `[-1:]`)
- Wildcard support for both property access (`$.store.*`) and array indexing (`$.store.book[*].author`) via `SjJsonPath all`
- **Filter expression support** with `SjJsonPathFilterExpression` class implementing comparison operators (`<`, `>`, `=`) and logical operators (`&`)
- **Regex matching support** with `SjJsonPathRegex` class implementing regex patterns (`=~`) with case-insensitive option (`ignoreCase`)
- String extension for proper quote wrapping in filter expressions
- Object extension for regex pattern creation via `asJsonPathRegex` protocol
- Extensible token string conversion system via `asJsonPathTokenString` protocol

## Package Structure

The project uses Pharo's Tonel format (.st files) organized in package directories. Each package contains:
- `package.st`: Package declaration
- `*.class.st`: Class definitions in Tonel format

## Examples

### Basic JsonPath Construction
```smalltalk
"Simple property access"
SjJsonPath root / 'store' / 'book' asString "=> '$.store.book'"

"Array indexing"
SjJsonPath root / 'users' @ 0 asString "=> '$.users[0]'"

"Wildcard access"
SjJsonPath root / 'store' / SjJsonPath all asString "=> '$.store.*'"
```

### Filter Expressions
```smalltalk
"Comparison filters"
SjJsonPath root / 'store' / 'book' ? (SjJsonPath current / 'price' < 15) asString
"=> '$.store.book[?(@.price < 15)]'"

"String comparison"
SjJsonPath root / 'store' / 'book' ? (SjJsonPath current / 'category' = 'fiction') asString
"=> '$.store.book[?(@.category == 'fiction')]'"
```

### Regex Matching
```smalltalk
"Basic regex matching"
SjJsonPath root / 'inventory' / 'mountain_bikes' ? (SjJsonPath current / 'specs' / 'material' =~ 'al') asString
"=> '$.inventory.mountain_bikes[?(@.specs.material =~ al)]'"

"Case-insensitive regex matching"
SjJsonPath root / 'inventory' / 'mountain_bikes' ? (SjJsonPath current / 'specs' / 'material' =~ 'al' asJsonPathRegex ignoreCase) asString
"=> '$.inventory.mountain_bikes[?(@.specs.material =~ (?i)al)]'"

"Complex regex pattern"
SjJsonPath root / 'users' ? (SjJsonPath current / 'name' =~ (SjJsonPathRegex pattern: '[a-zA-Z]+')) asString
"=> '$.users[?(@.name =~ [a-zA-Z]+)]'"
```
