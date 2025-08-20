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
	
	path := SjJsonPath root / 'users' > 0.
	self assert: path asString equals: '$.users[0]'
]


