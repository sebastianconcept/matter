Class {
	#name : #BaselineOfMatter,
	#superclass : #BaselineOf,
	#category : #BaselineOfMatter
}

{ #category : #baselines }
BaselineOfMatter >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ self setUpBaseDependencies: spec.
			self setUpPackages: spec.
			spec
				group: 'Core' with: #('Matter-Core');
				group: 'Client' with: #('Matter-Client-Tests');
				group: 'Server' with: #('Matter-Server-Tests');
				group: 'default' with: #('Client') ]
]

{ #category : #baselines }
BaselineOfMatter >> setUpBaseDependencies: spec [
	self zinc: spec.

]

{ #category : #baselines }
BaselineOfMatter >> setUpBasePackages: spec [
	spec
		package: 'Matter-Base-Core'
		with: [ spec requires: 'ZincHTTPComponents' ].
	spec
		package: 'Matter-Tests-Base'
		with: [ spec requires: 'Matter-Base-Core' ].

]

{ #category : #baselines }
BaselineOfMatter >> setUpPackages: spec [
	self setUpBaseDependencies: spec.
	self setUpBasePackages: spec.
]

{ #category : #baselines }
BaselineOfMatter >> zinc: spec [
	spec
		baseline: 'ZincHTTPComponents'
		with: [ spec
				repository: 'github://svenvc/zinc/repository';
				loads: #('default' 'WebSocket') ]
]
