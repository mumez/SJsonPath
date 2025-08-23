# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

SJsonPath is a Smalltalk library that provides a fluent API for creating JsonPath expression strings with support for property access, array indexing, slicing, wildcards, and recursive search. The project is structured as a Pharo/Smalltalk package using the Tonel format with Metacello baseline configuration.

## Architecture

The project consists of three main packages:

- **SJsonPath-Core**: Contains the main `SjJsonPath` class that implements the fluent API for building JsonPath expressions
- **SJsonPath-Tests**: Contains test cases in `SjJsonPathTestCase` class
- **BaselineOfSJsonPath**: Metacello baseline configuration for package management and dependencies

The core architecture is built around:
- `SjJsonPath` class with a `tokens` instance variable that stores path components
- Fluent API design allowing method chaining to build JsonPath expressions
- Class-side factory methods `root` for creating root JsonPath instances and `all` for wildcard expressions

## Key Components

- `src/SJsonPath-Core/SjJsonPath.class.st`: Main implementation with fluent API methods
- `src/SJsonPath-Tests/SjJsonPathTestCase.class.st`: Test suite with basic path creation tests and array slice tests
- `src/SJsonPath-Core/Object.extension.st`: Extension providing default `asJsonPathTokenString` implementation
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
- `asString`: Converts the JsonPath to its string representation

### Helper Methods

- `dot`: Returns '.' for property separation
- `doubleDot`: Returns '..' for recursive search
- `arrayEnclosed: index`: Returns array notation using `asJsonPathTokenString` for proper formatting
- `Object >> asJsonPathTokenString`: Default implementation returning `self asString`
- `Interval >> asJsonPathTokenString`: Specialized implementation for array slices (e.g., `'0:2'`)

### Class-side Utility Methods

- `SjJsonPath class >> first: n`: Returns slice notation for first n elements (e.g., `':3'`)
- `SjJsonPath class >> last: n`: Returns slice notation for last n elements (e.g., `'-1:'`)

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
```

## Current State

The project has implemented the core fluent API:
- Core `SjJsonPath` class with working fluent API methods (`/`, `@`, `//`)
- Test class with `testCreateBasicPath`, `testCreateArraySlicePath`, `testCreateWildcardPath`, and `testCreateArraySlicePathWithFirstAndLast` methods covering basic functionality, array slice support, wildcard expressions, and first/last slice notation
- Token-based architecture for building JsonPath expressions
- String conversion via `asString` method that concatenates all tokens
- Array slice support through Interval objects with proper JsonPath slice notation (e.g., `[0:2]`)
- Advanced slice support with `first:` and `last:` class methods for common slice patterns (e.g., `[:3]`, `[-1:]`)
- Wildcard support for both property access (`$.store.*`) and array indexing (`$.store.book[*].author`) via `SjJsonPath all`
- Extensible token string conversion system via `asJsonPathTokenString` protocol

## Package Structure

The project uses Pharo's Tonel format (.st files) organized in package directories. Each package contains:
- `package.st`: Package declaration
- `*.class.st`: Class definitions in Tonel format