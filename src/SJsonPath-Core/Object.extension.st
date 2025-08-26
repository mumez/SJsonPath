Extension { #name : 'Object' }

{ #category : '*SJsonPath-Core' }
Object >> asJsonPathTokenString [
	^ self asString
]

{ #category : '*SJsonPath-Core' }
Object >> asJsonPathExpressionString [
	^ self asJsonPathTokenString
]

{ #category : '*SJsonPath-Core' }
Object >> asJsonPathRegex [
	^ SjJsonPathRegex pattern: self asString
]