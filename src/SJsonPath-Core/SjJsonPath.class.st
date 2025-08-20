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
	^ self tokens: #('$')
]

{ #category : 'instance creation' }
SjJsonPath class >> tokens: pathTokens [
	^ self new
		  tokens: pathTokens;
		  yourself
]

{ #category : 'accessing' }
SjJsonPath >> tokens [
	tokens
	tokens ifNil: [ tokens := OrderedCollection new ].
	^ tokens
]

{ #category : 'accessing' }
SjJsonPath >> tokens: anObject [ 
	tokens := anObject
]

{ #category : 'converting' }
SjJsonPath >> asString [
	"TODO: return JsonPath string"
	^ ''
]

