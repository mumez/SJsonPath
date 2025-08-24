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