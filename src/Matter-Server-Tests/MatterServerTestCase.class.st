Class {
	#name : #MatterServerTestCase,
	#superclass : #MatterTestCase,
	#category : #'Matter-Server-Tests'
}

{ #category : #tests }
MatterServerTestCase >> testAtAnswer [

	| api answer server |
	server := MTServer startOn: 1901.
	api := MTClient host: 'localhost' port: 1901.

	api at: #stored42 put: 42.
	answer := api at: #stored42.
	self assert: answer value equals: 42.

	server stop
]

{ #category : #tests }
MatterServerTestCase >> testAtPutAnswer [

	| api answer server |
	server := MTServer startOn: 1901.
	api := MTClient host: 'localhost' port: 1901.

	answer := api at: #stored42 put: 42.
	self assert: answer value equals: 'stored42'.

	server stop
]

{ #category : #tests }
MatterServerTestCase >> testSizeAnswer [

	| api answer server |
	server := MTServer startOn: 1801.
	api := MTClient host: 'localhost' port: 1801.

	api at: #stored40 put: 40.
	api at: #stored41 put: 41.
	api at: #stored42 put: 42.

	answer := api size.
	self assert: answer equals: 3.

	server stop
]
