Class {
	#name : #BaselineOfMatter,
	#superclass : #BaselineOf,
	#category : #BaselineOfMatter
}

{ #category : #baselines }
BaselineOfMatter >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		self setUpCoreDependencies: spec.
		self setUpPackages: spec.
		spec
			group: 'Core' with: #( 'Matter-Core' );
			group: 'Tests' with: #( 'Matter-Core-Tests' );
			group: 'Client' with: #( 'Matter-Client' );
			group: 'Client-Tests' with: #( 'Matter-Client-Tests' );
			group: 'Server' with: #( 'Matter-Server' );
			group: 'Server-Tests' with: #( 'Matter-Server-Tests' );
			group: 'default' with: #( 'Client' ) ]
]

{ #category : #baselines }
BaselineOfMatter >> setUpClientDependencies: spec [

	"no-dependencies so far"
]

{ #category : #baselines }
BaselineOfMatter >> setUpClientPackages: spec [

	spec
		package: 'Matter-Client'
		with: [ spec requires: #( 'Matter-Core' ) ].
	spec
		package: 'Matter-Client-Tests'
		with: [ spec requires: #( 'Matter-Client' 'Matter-Core-Tests' ) ]
]

{ #category : #baselines }
BaselineOfMatter >> setUpCoreDependencies: spec [
	self zinc: spec.

]

{ #category : #baselines }
BaselineOfMatter >> setUpCorePackages: spec [
	spec
		package: 'Matter-Core'
		with: [ spec requires: 'ZincHTTPComponents' ].
	spec
		package: 'Matter-Core-Tests'
		with: [ spec requires: 'Matter-Core' ].

]

{ #category : #baselines }
BaselineOfMatter >> setUpPackages: spec [
	self setUpCoreDependencies: spec.
	self setUpCorePackages: spec.
	
	self setUpClientDependencies: spec.
	self setUpClientPackages: spec.
	
	self setUpServerDependencies: spec.
	self setUpServerPackages: spec.

]

{ #category : #baselines }
BaselineOfMatter >> setUpServerDependencies: spec [

	"no-dependencies so far"
]

{ #category : #baselines }
BaselineOfMatter >> setUpServerPackages: spec [

	spec
		package: 'Matter-Server'
		with: [ spec requires: #( 'Matter-Core' ) ].
	spec package: 'Matter-Server-Tests' with: [ 
		spec requires:
			#( 'Matter-Server' 'Matter-Core-Tests' 'Matter-Client-Tests' ) ]
]

{ #category : #baselines }
BaselineOfMatter >> zinc: spec [
	spec
		baseline: 'ZincHTTPComponents'
		with: [ spec
				repository: 'github://svenvc/zinc/repository';
				loads: #('default' 'WebSocket') ]
]
