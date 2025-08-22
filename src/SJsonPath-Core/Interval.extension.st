Extension { #name : 'Interval' }

{ #category : '*SJsonPath-Core' }
Interval >> asJsonPathTokenString [
	^ self first asString, ':', self last asString
]