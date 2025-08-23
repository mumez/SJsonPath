Class {
	#name : 'SjJsonPathFilterExpression',
	#superclass : 'SjJsonPathExpression',
	#instVars : [
	],
	#category : 'SJsonPath-Core',
	#package : 'SJsonPath-Core'
}

{ #category : 'instance creation' }
SjJsonPathFilterExpression class >> expression: expression [
	^ self new
		type: #prefix;
    	operator: '?';
		expressions: { expression enclosed };
		yourself
]

{ #category : 'accessing' }
SjJsonPathFilterExpression >> expression [
	"Return the first (and only) expression from the expressions array"
	^ self expressions ifNotEmpty: [ self expressions first ]
]

{ #category : 'accessing' }
SjJsonPathFilterExpression >> expression: anObject [
	"Set the expression by wrapping it in the expressions array"
	self expressions: { anObject }
]

