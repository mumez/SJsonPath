# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

SJsonPath is a Smalltalk library that provides a fluent API for creating JsonPath expression strings. The project is structured as a Pharo/Smalltalk package using the Tonel format with Metacello baseline configuration.

## Architecture

The project consists of three main packages:

- **SJsonPath-Core**: Contains the main `SjJsonPath` class that implements the fluent API for building JsonPath expressions
- **SJsonPath-Tests**: Contains test cases in `SjJsonPathTestCase` class
- **BaselineOfSJsonPath**: Metacello baseline configuration for package management and dependencies

The core architecture is built around:
- `SjJsonPath` class with a `tokens` instance variable that stores path components
- Fluent API design allowing method chaining to build JsonPath expressions
- Class-side factory method `root` for creating root JsonPath instances

## Key Components

- `src/SJsonPath-Core/SjJsonPath.class.st`: Main implementation with fluent API methods
- `src/SJsonPath-Tests/SjJsonPathTestCase.class.st`: Test suite with basic path creation tests
- `src/BaselineOfSJsonPath/BaselineOfSJsonPath.class.st`: Metacello baseline defining package structure and dependencies

## Implemented API Methods

The `SjJsonPath` class implements the following fluent API methods:

- `/ otherPath`: Property access using dot notation (e.g., `$.store.book`)
- `> index`: Array index access using bracket notation (e.g., `$.users[0]`)
- `// otherPath`: Recursive/descendant search using double dot (e.g., `$.store..title`)
- `asString`: Converts the JsonPath to its string representation

### Helper Methods

- `dot`: Returns '.' for property separation
- `doubleDot`: Returns '..' for recursive search
- `arrayEnclosed: index`: Returns array notation `{'[', index asString, ']'}`

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
- Core `SjJsonPath` class with working fluent API methods (`/`, `>`, `//`)
- Test class with `testCreateBasicPath` method covering basic functionality
- Token-based architecture for building JsonPath expressions
- String conversion via `asString` method that concatenates all tokens

## Package Structure

The project uses Pharo's Tonel format (.st files) organized in package directories. Each package contains:
- `package.st`: Package declaration
- `*.class.st`: Class definitions in Tonel format