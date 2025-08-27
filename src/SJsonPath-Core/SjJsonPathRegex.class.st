Class {
	#name : 'SjJsonPathRegex',
	#superclass : 'Object',
	#instVars : [
		'pattern',
		'flags'
	],
	#category : 'SJsonPath-Core'
}

{ #category : 'instance creation' }
SjJsonPathRegex class >> pattern: aString [
	^ self new pattern: aString; yourself
]

{ #category : 'instance creation' }
SjJsonPathRegex class >> pattern: aString flags: aSet [
	^ self new pattern: aString; flags: aSet; yourself
]

{ #category : 'initialization' }
SjJsonPathRegex >> initialize [
	super initialize.
	pattern := ''.
	flags := Set new
]

{ #category : 'accessing' }
SjJsonPathRegex >> pattern [
	^ pattern
]

{ #category : 'accessing' }
SjJsonPathRegex >> pattern: aString [
	pattern := aString
]

{ #category : 'accessing' }
SjJsonPathRegex >> flags [
	^ flags
]

{ #category : 'accessing' }
SjJsonPathRegex >> flags: aSet [
	flags := aSet
]

{ #category : 'converting' }
SjJsonPathRegex >> asJsonPathTokenString [
	| sortedFlags |
	flags ifEmpty: [ ^ self pattern ].
	sortedFlags := flags asSortedCollection.
	^ '(?{1}){2}' format: {('' join: sortedFlags). self pattern}
]

{ #category : 'converting' }
SjJsonPathRegex >> asJsonPathRegex [
	^ self
]

{ #category : 'private' }
SjJsonPathRegex >> cloneWithFlagAdded: aFlag [
	^ self class pattern: self pattern flags: (self flags add: aFlag; yourself)
]

{ #category : 'utilities' }
SjJsonPathRegex >> ignoreCase [
	^ self cloneWithFlagAdded: 'i'
]

{ #category : 'utilities' }
SjJsonPathRegex >> multiLine [
	^ self cloneWithFlagAdded: 'm'
]

{ #category : 'utilities' }
SjJsonPathRegex >> dotMatchesNewline [
	^ self cloneWithFlagAdded: 's'
]

{ #category : 'utilities' }
SjJsonPathRegex >> crlfMode [
	^ self cloneWithFlagAdded: 'R'
]

{ #category : 'utilities' }
SjJsonPathRegex >> swapGreed [
	^ self cloneWithFlagAdded: 'U'
]

{ #category : 'utilities' }
SjJsonPathRegex >> unicode [
	^ self cloneWithFlagAdded: 'u'
]

{ #category : 'utilities' }
SjJsonPathRegex >> verbose [
	^ self cloneWithFlagAdded: 'x'
]
