# SJsonPath


## Features

SJsonPath is a simple JsonPath implementation. You can create JsonPath expression string by fluent messege sends. 


## Installation

```smalltalk
Metacello new
  baseline: 'SJsonPath';
  repository: 'github://mumez/SJsonPath/src';
  load.
```

## Example

```smalltalk

JsonPath root / 'store' / 'book' > #all / 'price'
"=> '$.store.book[*].price'"

JsonPath root / 'store' / 'book' > 0 / 'title'  
"=> '$.store.book[0].title'"

JsonPath root / 'store' / 'book' > (0 to: 2) / 'title'
"=> '$.store.book[0:3].title'"

JsonPath root / 'store' / 'book' > [:item | item price < 15] / 'title'
"=> '$.store.book[?(@.price < 15)].title'"

JsonPath root / 'store' // 'title' 
"=> '$.store..title'"

JsonPath root / 'store' / 'book' / #all / 'price'
"=> '$.store.book[*].price'"
```