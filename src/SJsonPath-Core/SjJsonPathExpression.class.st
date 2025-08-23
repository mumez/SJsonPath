Class {
	#name : 'SjJsonPathExpression',
	#superclass : 'Object',
	#instVars : [
		'type',
		'operator',
		'expressions',
		'enclosed'
	],
	#category : 'SJsonPath-Core',
	#package : 'SJsonPath-Core'
}

{ #category : 'instance creation' }
SjJsonPathExpression class >> eq: leftExpression with: rightExpression [
	"Create equality comparison expression"
	^ self new
		type: #infix;
		operator: '==';
		expressions: { leftExpression. rightExpression };
		yourself
]

{ #category : 'instance creation' }
SjJsonPathExpression class >> lt: leftExpression with: rightExpression [
	"Create less than comparison expression"
	^ self new
		type: #infix;
		operator: '<';
		expressions: { leftExpression. rightExpression };
		yourself
]

{ #category : 'instance creation' }
SjJsonPathExpression class >> gt: leftExpression with: rightExpression [
	"Create greater than comparison expression"
	^ self new
		type: #infix;
		operator: '>';
		expressions: { leftExpression. rightExpression };
		yourself
]

{ #category : 'instance creation' }
SjJsonPathExpression class >> and: leftExpression with: rightExpression [
	"Create logical AND expression"
	^ self new
		type: #infix;
		operator: '&&';
		expressions: { leftExpression. rightExpression };
		yourself
]

{ #category : 'instance creation' }
SjJsonPathExpression class >> or: leftExpression with: rightExpression [
	"Create logical OR expression"
	^ self new
		type: #infix;
		operator: '||';
		expressions: { leftExpression. rightExpression };
		yourself
]

{ #category : 'accessing' }
SjJsonPathExpression >> type [
	^ type
]

{ #category : 'accessing' }
SjJsonPathExpression >> type: anObject [
	type := anObject
]

{ #category : 'accessing' }
SjJsonPathExpression >> operator [
	^ operator
]

{ #category : 'accessing' }
SjJsonPathExpression >> operator: anObject [
	operator := anObject
]

{ #category : 'accessing' }
SjJsonPathExpression >> expressions [
	^ expressions
]

{ #category : 'accessing' }
SjJsonPathExpression >> expressions: anObject [
	expressions := anObject
]

{ #category : 'accessing' }
SjJsonPathExpression >> enclosed [
	^ enclosed
]

{ #category : 'accessing' }
SjJsonPathExpression >> enclosed: anObject [
	enclosed := anObject
]

{ #category : 'testing' }
SjJsonPathExpression >> isPrefix [
	^ self type = #prefix
]

{ #category : 'testing' }
SjJsonPathExpression >> isInfix [
	^ self type = #infix
]

{ #category : 'testing' }
SjJsonPathExpression >> isPostfix [
	^ self type = #postfix
]

{ #category : 'api' }
SjJsonPathExpression >> beEnclosed [
	"Mark this expression to be enclosed in parentheses"
	self enclosed: true
]

{ #category : 'operators' }
SjJsonPathExpression >> < otherExpression [
	"Create a less than comparison expression"
	^ self class lt: self with: otherExpression
]

{ #category : 'operators' }
SjJsonPathExpression >> > otherExpression [
	"Create a greater than comparison expression"
	^ self class gt: self with: otherExpression
]

{ #category : 'operators' }
SjJsonPathExpression >> = otherExpression [
	"Create an equality comparison expression"
	^ self class eq: self with: otherExpression
]

{ #category : 'operators' }
SjJsonPathExpression >> & otherExpression [
	"Create a logical AND expression"
	^ self class and: self with: otherExpression
]

{ #category : 'operators' }
SjJsonPathExpression >> | otherExpression [
	"Create a logical OR expression"
	^ self class or: self with: otherExpression
]

{ #category : 'printing' }
SjJsonPathExpression >> asJsonPathTokenString [
	"Convert expression to JsonPath token string representation"
	^ String streamContents: [ :stream |
		self enclosed ifTrue: [ stream nextPut: $( ].
		self tokensOn: stream.
		self enclosed ifTrue: [ stream nextPut: $) ]
	]
]

{ #category : 'printing' }
SjJsonPathExpression >> tokensOn: stream [
	self isPrefix ifTrue: [ ^self tokensPrefixTypeOn: stream ].
	self isInfix ifTrue: [ ^self tokensInfixTypeOn: stream ].
	self isPostfix ifTrue: [ ^self tokensPostfixTypeOn: stream ].
]

{ #category : 'printing' }
SjJsonPathExpression >> tokensPrefixTypeOn: stream [
	stream nextPutAll: self operator asString.
	self expressions do: [ :each |
		stream nextPutAll: each asJsonPathTokenString
	] separatedBy: [ stream nextPut: Character space ]
]

{ #category : 'printing' }
SjJsonPathExpression >> tokensInfixTypeOn: stream [
	self expressions 
		do: [ :each | stream nextPutAll: each asJsonPathTokenString ]
		separatedBy: [ 
			stream nextPut: Character space.
			stream nextPutAll: self operator asString.
			stream nextPut: Character space
		]
]

{ #category : 'printing' }
SjJsonPathExpression >> tokensPostfixTypeOn: stream [
	self expressions do: [ :each |
		stream nextPutAll: each asJsonPathTokenString
	] separatedBy: [ stream nextPut: Character space ].
	stream nextPut: Character space.
	stream nextPutAll: self operator asString
]