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

SjJsonPath root / 'store' / 'book' @ SjJsonPath all / 'price'
"=> '$.store.book[*].price'"

SjJsonPath root / 'store' / 'book' @ 0 / 'title'  
"=> '$.store.book[0].title'"

SjJsonPath root / 'store' / 'book' @ (0 to: 2) / 'title'
"=> '$.store.book[0:3].title'"

SjJsonPath root / 'store' / 'book' @ (SjJsonPath current / 'price' < 15) / 'title'
"=> '$.store.book[?(@.price < 15)].title'"

SjJsonPath root / 'store' // 'title' 
"=> '$.store..title'"

SjJsonPath root / 'store' / 'book' @ SjJsonPath all / 'price'
"=> '$.store.book[*].price'"
```