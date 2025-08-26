Class {
	#name : 'SjJsonPathFilterExpressionTestCase',
	#superclass : 'TestCase',
	#category : 'SJsonPath-Tests',
	#package : 'SJsonPath-Tests'
}

{ #category : 'testing' }
SjJsonPathFilterExpressionTestCase >> testBasicFilterExpression [
	"Test basic filter expression like ?(@.price < 15)"
	| path |
	
	path := SjJsonPath root / 'store' / 'book' ? (SjJsonPath current / 'price' < 15).
	self assert: path asString equals: '$.store.book[?(@.price < 15)]'
]

{ #category : 'testing' }
SjJsonPathFilterExpressionTestCase >> testFilterExpressionWithGreaterThan [
	| path |
	path := SjJsonPath root / 'store' / 'book' ? (SjJsonPath current / 'price' > 25).
	self assert: path asString equals: '$.store.book[?(@.price > 25)]'
]

{ #category : 'testing' }
SjJsonPathFilterExpressionTestCase >> testFilterExpressionWithStringComparison [
	| path |
	path := SjJsonPath root / 'store' / 'book' ? (SjJsonPath current / 'category' = 'fiction').
	self assert: path asString equals: '$.store.book[?(@.category == ''fiction'')]'
]

{ #category : 'testing' }
SjJsonPathFilterExpressionTestCase >> testFilterExpressionWithMultipleConditions [
	| path |
	path := SjJsonPath root / 'store' / 'book' ? ((SjJsonPath current / 'price' < 15) & (SjJsonPath current / 'category' = 'fiction')).
	self assert: path asString equals: '$.store.book[?(@.price < 15 && @.category == ''fiction'')]'
]

{ #category : 'testing' }
SjJsonPathFilterExpressionTestCase >> testFilterExpressionWithNullComparison [
	| path |
	path := SjJsonPath root / 'bicycle' ? (SjJsonPath current / 'color' = nil).
	self assert: path asString equals: '$.bicycle[?(@.color == null)]'
]

{ #category : 'testing' }
SjJsonPathFilterExpressionTestCase >> testFilterExpressionWithGreaterThanOrEqual [
	| path |
	path := SjJsonPath root / 'store' / 'book' ? (SjJsonPath current / 'price' >= 20).
	self assert: path asString equals: '$.store.book[?(@.price >= 20)]'
]

{ #category : 'testing' }
SjJsonPathFilterExpressionTestCase >> testFilterExpressionWithLessThanOrEqual [
	| path |
	path := SjJsonPath root / 'store' / 'book' ? (SjJsonPath current / 'price' <= 10).
	self assert: path asString equals: '$.store.book[?(@.price <= 10)]'
]

{ #category : 'testing' }
SjJsonPathFilterExpressionTestCase >> testFilterExpressionWithNotEqual [
	| path |
	path := SjJsonPath root / 'store' / 'book' ? (SjJsonPath current / 'category' ~= 'reference').
	self assert: path asString equals: '$.store.book[?(@.category != ''reference'')]'
]

{ #category : 'testing' }
SjJsonPathFilterExpressionTestCase >> testFilterExpressionWithNot [
	| path |
	path := SjJsonPath root / 'bicycle' ? (SjJsonPath current / 'color' = nil) not.
	self assert: path asString equals: '$.bicycle[?(!(@.color == null))]'
]

{ #category : 'testing' }
SjJsonPathFilterExpressionTestCase >> testFilterExpressionWithNotComparison [
	| path |
	path := SjJsonPath root / 'store' / 'book' ? (SjJsonPath current / 'price' >= 20) not.
	self assert: path asString equals: '$.store.book[?(!(@.price >= 20))]'
]

{ #category : 'testing' }
SjJsonPathFilterExpressionTestCase >> testFilterExpressionWithNotMultipleConditions [
	| path |
	path := SjJsonPath root / 'store' / 'book' ? ((SjJsonPath current / 'price' < 15) & (SjJsonPath current / 'category' = 'fiction')) not.
	self assert: path asString equals: '$.store.book[?(!(@.price < 15 && @.category == ''fiction''))]'
]

{ #category : 'testing' }
SjJsonPathFilterExpressionTestCase >> testFilterExpressionWithRegexMatch [
	"Test basic regex matching like ?(@.material =~ 'al')"
	| path |
	path := SjJsonPath root / 'inventory' / 'mountain_bikes' ? (SjJsonPath current / 'specs' / 'material' =~ 'al').
	self assert: path asString equals: '$.inventory.mountain_bikes[?(@.specs.material =~ al)]'
]

{ #category : 'testing' }
SjJsonPathFilterExpressionTestCase >> testFilterExpressionWithRegexIgnoreCase [
	"Test case-insensitive regex matching like ?(@.material =~ '(?i)al')"
	| path |
	path := SjJsonPath root / 'inventory' / 'mountain_bikes' ? (SjJsonPath current / 'specs' / 'material' =~ 'al' asJsonPathRegex ignoreCase).
	self assert: path asString equals: '$.inventory.mountain_bikes[?(@.specs.material =~ (?i)al)]'
]

{ #category : 'testing' }
SjJsonPathFilterExpressionTestCase >> testFilterExpressionWithRegexPattern [
	"Test regex pattern creation"
	| regex path |
	regex := SjJsonPathRegex pattern: '[a-zA-Z]+'.
	path := SjJsonPath root / 'users' ? (SjJsonPath current / 'name' =~ regex).
	self assert: path asString equals: '$.users[?(@.name =~ [a-zA-Z]+)]'
]