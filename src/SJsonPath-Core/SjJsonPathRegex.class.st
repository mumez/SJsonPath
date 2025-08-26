Class {
	#name : 'SjJsonPathRegex',
	#superclass : 'Object',
	#instVars : [
		'pattern'
	],
	#category : 'SJsonPath-Core'
}

{ #category : 'instance creation' }
SjJsonPathRegex class >> pattern: aString [
	^ self new pattern: aString; yourself
]

{ #category : 'accessing' }
SjJsonPathRegex >> pattern [
	^ pattern
]

{ #category : 'accessing' }
SjJsonPathRegex >> pattern: aString [
	pattern := aString
]

{ #category : 'converting' }
SjJsonPathRegex >> asJsonPathTokenString [
	^ pattern
]

{ #category : 'converting' }
SjJsonPathRegex >> asJsonPathRegex [
	^ self
]

{ #category : 'utilities' }
SjJsonPathRegex >> ignoreCase [
	^ self class pattern: '(?i)' , pattern
]
