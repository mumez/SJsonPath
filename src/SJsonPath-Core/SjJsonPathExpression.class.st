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
SjJsonPathExpression class >> le: leftExpression with: rightExpression [
	"Create less than or equal comparison expression"
	^ self new
		type: #infix;
		operator: '<=';
		expressions: { leftExpression. rightExpression };
		yourself
]

{ #category : 'instance creation' }
SjJsonPathExpression class >> ge: leftExpression with: rightExpression [
	"Create greater than or equal comparison expression"
	^ self new
		type: #infix;
		operator: '>=';
		expressions: { leftExpression. rightExpression };
		yourself
]

{ #category : 'instance creation' }
SjJsonPathExpression class >> ne: leftExpression with: rightExpression [
	"Create not equal comparison expression"
	^ self new
		type: #infix;
		operator: '!=';
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

{ #category : 'instance creation' }
SjJsonPathExpression class >> not: expression [
	"Create logical NOT expression"
	^ self new
		type: #prefix;
		operator: '!';
		expressions: { expression beEnclosed };
		yourself
]

{ #category : 'instance creation' }
SjJsonPathExpression class >> regexMatch: leftExpression with: rightExpression [
	"Create regex match expression"
	^ self new
		type: #infix;
		operator: '=~';
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
	^ enclosed ifNil: [ false ]
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

{ #category : 'actions' }
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
SjJsonPathExpression >> <= otherExpression [
	"Create a less than or equal comparison expression"
	^ self class le: self with: otherExpression
]

{ #category : 'operators' }
SjJsonPathExpression >> >= otherExpression [
	"Create a greater than or equal comparison expression"
	^ self class ge: self with: otherExpression
]

{ #category : 'operators' }
SjJsonPathExpression >> ~= otherExpression [
	"Create a not equal comparison expression"
	^ self class ne: self with: otherExpression
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

{ #category : 'operators' }
SjJsonPathExpression >> not [
	"Create a logical NOT expression"
	^ self class not: self
]

{ #category : 'printing' }
SjJsonPathExpression >> asString [
	^ self asJsonPathTokenString
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
		stream nextPutAll: each asJsonPathExpressionString
	] separatedBy: [ stream nextPut: Character space ]
]

{ #category : 'printing' }
SjJsonPathExpression >> tokensInfixTypeOn: stream [
	self expressions 
		do: [ :each | stream nextPutAll: each asJsonPathExpressionString ]
		separatedBy: [ 
			stream nextPut: Character space.
			stream nextPutAll: self operator asString.
			stream nextPut: Character space
		]
]

{ #category : 'printing' }
SjJsonPathExpression >> tokensPostfixTypeOn: stream [
	self expressions do: [ :each |
		stream nextPutAll: each asJsonPathExpressionString
	] separatedBy: [ stream nextPut: Character space ].
	stream nextPut: Character space.
	stream nextPutAll: self operator asString
]