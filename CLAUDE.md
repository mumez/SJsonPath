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

- `src/SState-Core/SjJsonPath.class.st`: Main implementation with token management and path building (currently incomplete with TODO markers)
- `src/SState-Tests/SjJsonPathTestCase.class.st`: Test suite (currently empty with TODO placeholders)
- `src/BaselineOfSJsonPath/BaselineOfSJsonPath.class.st`: Metacello baseline defining package structure and dependencies

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

The project appears to be in early development stage:
- Core `SjJsonPath` class has basic structure but `asString` method returns empty string with TODO comment
- Test class exists but contains only placeholder methods with TODO comments
- The fluent API examples in README suggest intended functionality like `JsonPath root / 'store' / 'book' > #all / 'price'` but implementation is incomplete

## Package Structure

The project uses Pharo's Tonel format (.st files) organized in package directories. Each package contains:
- `package.st`: Package declaration
- `*.class.st`: Class definitions in Tonel format