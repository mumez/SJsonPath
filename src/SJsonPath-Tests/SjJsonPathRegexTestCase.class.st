Class {
	#name : 'SjJsonPathRegexTestCase',
	#superclass : 'TestCase',
	#category : 'SJsonPath-Tests',
	#package : 'SJsonPath-Tests'
}

{ #category : 'testing - basic' }
SjJsonPathRegexTestCase >> testBasicRegexPattern [
	"Test basic SjJsonPathRegex pattern creation and conversion"
	| regex |
	regex := SjJsonPathRegex pattern: 'test'.
	self assert: regex asJsonPathTokenString equals: 'test'.
	self assert: regex pattern equals: 'test'.
	self assert: regex flags isEmpty
]

{ #category : 'testing - basic' }
SjJsonPathRegexTestCase >> testEmptyRegexPattern [
	"Test empty pattern handling"
	| regex |
	regex := SjJsonPathRegex pattern: ''.
	self assert: regex asJsonPathTokenString equals: ''.
	self assert: regex flags isEmpty
]

{ #category : 'testing - basic' }
SjJsonPathRegexTestCase >> testRegexFactoryMethod [
	"Test class-side factory method with flags"
	| regex |
	regex := SjJsonPathRegex pattern: 'test' flags: (Set with: 'i' with: 'm').
	self assert: regex asJsonPathTokenString equals: '(?im)test'.
	self assert: regex flags size equals: 2
]

{ #category : 'testing - single flags' }
SjJsonPathRegexTestCase >> testRegexIgnoreCaseFlag [
	"Test ignoreCase flag addition"
	| regex |
	regex := (SjJsonPathRegex pattern: 'test') ignoreCase.
	self assert: regex asJsonPathTokenString equals: '(?i)test'
]

{ #category : 'testing - single flags' }
SjJsonPathRegexTestCase >> testRegexMultiLineFlag [
	"Test multiLine flag addition"
	| regex |
	regex := (SjJsonPathRegex pattern: 'test') multiLine.
	self assert: regex asJsonPathTokenString equals: '(?m)test'
]

{ #category : 'testing - single flags' }
SjJsonPathRegexTestCase >> testRegexDotMatchesNewlineFlag [
	"Test dotMatchesNewline flag addition"
	| regex |
	regex := (SjJsonPathRegex pattern: 'test') dotMatchesNewline.
	self assert: regex asJsonPathTokenString equals: '(?s)test'
]

{ #category : 'testing - single flags' }
SjJsonPathRegexTestCase >> testRegexCrlfModeFlag [
	"Test crlfMode flag addition"
	| regex |
	regex := (SjJsonPathRegex pattern: 'test') crlfMode.
	self assert: regex asJsonPathTokenString equals: '(?R)test'
]

{ #category : 'testing - single flags' }
SjJsonPathRegexTestCase >> testRegexSwapGreedFlag [
	"Test swapGreed flag addition"
	| regex |
	regex := (SjJsonPathRegex pattern: 'test') swapGreed.
	self assert: regex asJsonPathTokenString equals: '(?U)test'
]

{ #category : 'testing - single flags' }
SjJsonPathRegexTestCase >> testRegexUnicodeFlag [
	"Test unicode flag addition"
	| regex |
	regex := (SjJsonPathRegex pattern: 'test') unicode.
	self assert: regex asJsonPathTokenString equals: '(?u)test'
]

{ #category : 'testing - single flags' }
SjJsonPathRegexTestCase >> testRegexVerboseFlag [
	"Test verbose flag addition"
	| regex |
	regex := (SjJsonPathRegex pattern: 'test') verbose.
	self assert: regex asJsonPathTokenString equals: '(?x)test'
]

{ #category : 'testing - multiple flags' }
SjJsonPathRegexTestCase >> testRegexMultipleFlagsOrdered [
	"Test multiple flags are properly sorted"
	| regex |
	regex := (SjJsonPathRegex pattern: 'test') 
		verbose 
		ignoreCase 
		multiLine.
	self assert: regex asJsonPathTokenString equals: '(?imx)test'
]

{ #category : 'testing - multiple flags' }
SjJsonPathRegexTestCase >> testRegexAllFlags [
	"Test all available flags together"
	| regex |
	regex := (SjJsonPathRegex pattern: 'test')
		crlfMode
		ignoreCase
		multiLine
		dotMatchesNewline
		swapGreed
		unicode
		verbose.
	self assert: regex asJsonPathTokenString equals: '(?RUimsux)test'
]

{ #category : 'testing - multiple flags' }
SjJsonPathRegexTestCase >> testRegexFlagConsistency [
	"Test that same flags produce same results"
	| regex1 regex2 |
	regex1 := (SjJsonPathRegex pattern: 'test') ignoreCase multiLine.
	regex2 := (SjJsonPathRegex pattern: 'test') multiLine ignoreCase.
	self assert: regex1 asJsonPathTokenString equals: regex2 asJsonPathTokenString.
	self assert: regex1 asJsonPathTokenString equals: '(?im)test'
]

{ #category : 'testing - in filter expressions' }
SjJsonPathRegexTestCase >> testComplexRegexInFilter [
	"Test complex regex pattern in filter expression"
	| path |
	path := SjJsonPath root / 'products' ? (SjJsonPath current / 'code' =~ (SjJsonPathRegex pattern: '\d{3}-[A-Z]{2}') ignoreCase).
	self assert: path asString equals: '$.products[?(@.code =~ (?i)\d{3}-[A-Z]{2})]'
]

{ #category : 'testing - in filter expressions' }
SjJsonPathRegexTestCase >> testMultiFlagRegexInFilter [
	"Test multi-flag regex in filter expression"
	| path |
	path := SjJsonPath root / 'logs' ? (SjJsonPath current / 'message' =~ (SjJsonPathRegex pattern: '^error.*') ignoreCase multiLine).
	self assert: path asString equals: '$.logs[?(@.message =~ (?im)^error.*)]'
]