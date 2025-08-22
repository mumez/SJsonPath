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
SjJsonPath class >> tokens: pathTokens [
	^ self new
		  tokens: pathTokens;
		  yourself
]

{ #category : 'instance creation' }
SjJsonPath class >> token: pathToken [
	^ self tokens: { pathToken }
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
		self tokens do: [:each | strm nextPutAll: each asString ]
	]
]

{ #category : 'actions' }
SjJsonPath >> / otherPath [
	^ self class tokens: (self tokens, {self dot. otherPath asString})
]

{ #category : 'actions' }
SjJsonPath >> > index [
	^ self class tokens: (self tokens, (self arrayEnclosed: index))
]

{ #category : 'actions' }
SjJsonPath >> // otherPath [
	^ self class tokens: (self tokens, {self doubleDot. otherPath asString})
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