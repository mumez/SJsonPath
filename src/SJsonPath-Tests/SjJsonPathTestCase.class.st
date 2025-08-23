Class {
	#name : 'SjJsonPathTestCase',
	#superclass : 'TestCase',
	#instVars : [
		'counter'
	],
	#category : 'SJsonPath-Tests',
	#package : 'SJsonPath-Tests'
}

{ #category : 'testing' }
SjJsonPathTestCase >> testCreateBasicPath [
	| path |
	path := SjJsonPath root / 'store' / 'book'.
	self assert: path asString equals: '$.store.book'.
	
	path := SjJsonPath root / 'users' @ 0.
	self assert: path asString equals: '$.users[0]'
]

{ #category : 'testing' }
SjJsonPathTestCase >> testCreateArraySlicePath [
	| path |
	path := SjJsonPath root / 'book' @ (0 to: 2).
	self assert: path asString equals: '$.book[0:2]'
]

{ #category : 'testing' }
SjJsonPathTestCase >> testCreateWildcardPath [
	| path |
	path := SjJsonPath root / 'store' / SjJsonPath all.
	self assert: path asString equals: '$.store.*'.
	
	path := SjJsonPath root / 'store' / 'book' @ SjJsonPath all / 'author'.
	self assert: path asString equals: '$.store.book[*].author'
]

{ #category : 'testing' }
SjJsonPathTestCase >> testCreateArraySlicePathWithFirstAndLast [
	| path |
	path := SjJsonPath root / 'book' @ (SjJsonPath first: 3).
	self assert: path asString equals: '$.book[:3]'.
	
	path := SjJsonPath root / 'book' @ (SjJsonPath last: 1).
	self assert: path asString equals: '$.book[-1:]'
]


