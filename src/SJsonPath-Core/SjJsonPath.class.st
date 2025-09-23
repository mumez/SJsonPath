Class {
	#name : 'SjJsonPath',
	#superclass : 'Object',
	#instVars : [
		'tokens'
	],
	#category : 'SJsonPath-Core',
	#package : 'SJsonPath-Core'
}

{ #category : 'instance creation' }
SjJsonPath class >> all [
	^ self token: '*'
]

{ #category : 'factory' }
SjJsonPath class >> current [
	^ self token: '@'
]

{ #category : 'utilities' }
SjJsonPath class >> first: index [
	^ ':{1}' format: { index }
]

{ #category : 'utilities' }
SjJsonPath class >> last: index [
	^ '-{1}:' format: { index }
]

{ #category : 'instance creation' }
SjJsonPath class >> root [
	^ self token: '$'
]

{ #category : 'instance creation' }
SjJsonPath class >> token: pathToken [
	^ self tokens: { pathToken }
]

{ #category : 'instance creation' }
SjJsonPath class >> tokens: pathTokens [
	^ self new
		  tokens: pathTokens;
		  yourself
]

{ #category : 'actions' }
SjJsonPath >> / otherPath [
	^ self class tokens: (self tokens, {self dot. otherPath})
]

{ #category : 'actions' }
SjJsonPath >> // otherPath [
	^ self class tokens: (self tokens, {self doubleDot. otherPath})
]

{ #category : 'filter support' }
SjJsonPath >> < rightExpression [
	^ SjJsonPathExpression lt: self with: rightExpression
]

{ #category : 'filter support' }
SjJsonPath >> <= rightExpression [
	^ SjJsonPathExpression le: self with: rightExpression
]

{ #category : 'filter support' }
SjJsonPath >> = rightExpression [
	^ SjJsonPathExpression eq: self with: rightExpression
]

{ #category : 'filter support' }
SjJsonPath >> =~ pattern [
	^ SjJsonPathExpression regexMatch: self with: pattern asJsonPathRegex
]

{ #category : 'filter support' }
SjJsonPath >> > rightExpression [
	^ SjJsonPathExpression gt: self with: rightExpression
]

{ #category : 'filter support' }
SjJsonPath >> >= rightExpression [
	^ SjJsonPathExpression ge: self with: rightExpression
]

{ #category : 'actions' }
SjJsonPath >> ? filterExpression [
	^ self class tokens: (self tokens, (self arrayEnclosed: (SjJsonPathFilterExpression expression: filterExpression)))
]

{ #category : 'actions' }
SjJsonPath >> @ index [
	^ self class tokens: (self tokens, (self arrayEnclosed: index))
]

{ #category : 'private' }
SjJsonPath >> arrayEnclosed: index [
	^ {'['. index. ']'}
]

{ #category : 'converting' }
SjJsonPath >> asString [
	^ String streamContents: [:strm | 
		self tokens do: [:each | strm nextPutAll: each asJsonPathTokenString ]
	]
]

{ #category : 'constants' }
SjJsonPath >> dot [
	^ '.'
]

{ #category : 'constants' }
SjJsonPath >> doubleDot [
	^ '..'
]

{ #category : 'accessing' }
SjJsonPath >> tokens [
	tokens ifNil: [ tokens := OrderedCollection new ].
	^ tokens
]

{ #category : 'accessing' }
SjJsonPath >> tokens: anObject [ 
	tokens := anObject
]

{ #category : 'filter support' }
SjJsonPath >> ~= rightExpression [
	^ SjJsonPathExpression ne: self with: rightExpression
]
