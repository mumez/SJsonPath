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
SjJsonPath class >> root [
	^ self token: '$'
]

{ #category : 'instance creation' }
SjJsonPath class >> all [
	^ self token: '*'
]

{ #category : 'instance creation' }
SjJsonPath class >> tokens: pathTokens [
	^ self new
		  tokens: pathTokens;
		  yourself
]

{ #category : 'instance creation' }
SjJsonPath class >> token: pathToken [
	^ self tokens: { pathToken }
]

{ #category : 'utilities' }
SjJsonPath class >> first: index [
	^ ':{1}' format: { index }
]

{ #category : 'utilities' }
SjJsonPath class >> last: index [
	^ '-{1}:' format: { index }
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

{ #category : 'converting' }
SjJsonPath >> asString [
	^ String streamContents: [:strm | 
		self tokens do: [:each | strm nextPutAll: each asJsonPathTokenString ]
	]
]

{ #category : 'actions' }
SjJsonPath >> / otherPath [
	^ self class tokens: (self tokens, {self dot. otherPath})
]

{ #category : 'actions' }
SjJsonPath >> @ index [
	^ self class tokens: (self tokens, (self arrayEnclosed: index))
]

{ #category : 'actions' }
SjJsonPath >> // otherPath [
	^ self class tokens: (self tokens, {self doubleDot. otherPath})
]

{ #category : 'private' }
SjJsonPath >> arrayEnclosed: index [
	^ {'['. index asJsonPathTokenString. ']'}
]

{ #category : 'constants' }
SjJsonPath >> dot [
	^ '.'
]

{ #category : 'constants' }
SjJsonPath >> doubleDot [
	^ '..'
]