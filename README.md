# SJsonPath


## Features

SJsonPath is a simple JsonPath implementation. You can create JsonPath expression string by fluent message sends. 

Key features:
- Property access with dot notation (`$.store.book`)
- Array indexing with bracket notation (`$.users[0]`)
- Array slicing with interval notation (`$.book[0:2]`)
- Wildcard support for properties and arrays (`$.store.*`, `$.book[*]`)
- Recursive/descendant search (`$.store..title`)
- **Filter expressions with comparison and logical operators** (`$.book[?(@.price < 15)]`)
- **Regex matching in filter expressions** (`$.inventory[?(@.material =~ '(?i)al')]`) 


## Installation

```smalltalk
Metacello new
  baseline: 'SJsonPath';
  repository: 'github://mumez/SJsonPath:main/src';
  load.
```

## Example

### Basic Path Operations

```smalltalk
"Property access"
SjJsonPath root / 'store' / 'book' / 'title'
"=> '$.store.book.title'"

"Array indexing"
SjJsonPath root / 'store' / 'book' @ 0 / 'title'  
"=> '$.store.book[0].title'"

"Array slicing"
SjJsonPath root / 'store' / 'book' @ (0 to: 2) / 'title'
"=> '$.store.book[0:3].title'"

"First/Last slice notation"
SjJsonPath root / 'store' / 'book' @ (SjJsonPath first: 3) / 'title'
"=> '$.store.book[:3].title'"

SjJsonPath root / 'store' / 'book' @ (SjJsonPath last: 1) / 'title'
"=> '$.store.book[-1:].title'"
```

### Wildcard and Recursive Search

```smalltalk
"Property wildcard"
SjJsonPath root / 'store' / SjJsonPath all / 'price'
"=> '$.store.*.price'"

"Array wildcard"
SjJsonPath root / 'store' / 'book' @ SjJsonPath all / 'price'
"=> '$.store.book[*].price'"

"Recursive search"
SjJsonPath root / 'store' // 'title' 
"=> '$.store..title'"
```

### Filter Expressions

```smalltalk
"Basic comparison"
SjJsonPath root / 'store' / 'book' ? (SjJsonPath current / 'price' < 15) / 'title'
"=> '$.store.book[?(@.price < 15)].title'"

"String comparison"
SjJsonPath root / 'store' / 'book' ? (SjJsonPath current / 'category' = 'fiction') / 'title'
"=> '$.store.book[?(@.category == 'fiction')].title'"

"Multiple conditions with logical AND"
SjJsonPath root / 'store' / 'book' ? 
    ((SjJsonPath current / 'price' < 15) & (SjJsonPath current / 'category' = 'fiction')) / 'title'
"=> '$.store.book[?(@.price < 15 && @.category == 'fiction')].title'"
```

### Regex Matching

```smalltalk
"Basic regex matching"
SjJsonPath root / 'inventory' / 'mountain_bikes' ? 
    (SjJsonPath current / 'specs' / 'material' =~ 'al') / 'model'
"=> '$.inventory.mountain_bikes[?(@.specs.material =~ al)].model'"

"Case-insensitive regex matching"
SjJsonPath root / 'inventory' / 'mountain_bikes' ? 
    (SjJsonPath current / 'specs' / 'material' =~ 'al' asJsonPathRegex ignoreCase) / 'model'
"=> '$.inventory.mountain_bikes[?(@.specs.material =~ (?i)al)].model'"

"Multiple regex flags"
SjJsonPath root / 'logs' ? 
    (SjJsonPath current / 'message' =~ (SjJsonPathRegex pattern: '^error.*') ignoreCase multiLine) / 'timestamp'
"=> '$.logs[?(@.message =~ (?im)^error.*)].timestamp'"

"All available regex flags"
SjJsonPath root / 'data' ? 
    (SjJsonPath current / 'text' =~ (SjJsonPathRegex pattern: 'pattern')
        ignoreCase        "i - case insensitive"
        multiLine         "m - ^ and $ match line boundaries"
        dotMatchesNewline "s - . matches newlines"
        unicode           "u - unicode support"
        verbose)          "x - ignore whitespace and comments"
"=> '$.data[?(@.text =~ (?imsux)pattern)]'"

"Complex regex pattern with flags"
SjJsonPath root / 'users' ? 
    (SjJsonPath current / 'email' =~ (SjJsonPathRegex pattern: '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}') ignoreCase) / 'name'
"=> '$.users[?(@.email =~ (?i)[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})].name'"
```

#### Available Regex Flags

- `ignoreCase` (i) - Case-insensitive matching
- `multiLine` (m) - `^` and `$` match line boundaries
- `dotMatchesNewline` (s) - `.` matches newline characters  
- `crlfMode` (R) - Use CRLF as line terminator in multi-line mode
- `swapGreed` (U) - Swap greedy and non-greedy quantifiers
- `unicode` (u) - Unicode support (enabled by default)
- `verbose` (x) - Ignore whitespace and allow comments
