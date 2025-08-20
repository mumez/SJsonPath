Class {
	#name : 'BaselineOfSJsonPath',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfSJsonPath',
	#package : 'BaselineOfSJsonPath'
}

{ #category : 'baseline' }
BaselineOfSJsonPath >> baseline: spec [
	<baseline>
	spec for: #common do: [ spec
		package: 'SJsonPath-Core';
		package: 'SJsonPath-Tests' with: [ spec requires: #('SJsonPath-Core') ];
		
		group: 'default' with: #('Core' 'Tests');
		group: 'Core' with: #('SJsonPath-Core');
		group: 'Tests' with: #('SJsonPath-Tests')]
]
