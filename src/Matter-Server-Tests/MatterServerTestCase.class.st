Class {
	#name : #MatterServerTestCase,
	#superclass : #MatterTestCase,
	#category : #'Matter-Server-Tests'
}

{ #category : #tests }
MatterServerTestCase >> testAtAnswer [

	| api answer |
	Matter server start.
	api := MTClient host: 'localhost' port: MTServer port.

	api at: #stored42 put: 42.
	answer := api at: #stored42.
	self assert: answer value equals: 42.

	Matter reset
]

{ #category : #tests }
MatterServerTestCase >> testAtPutAnswer [

	| api answer |
	Matter server start.
	api := MTClient host: 'localhost' port: MTServer port.

	answer := api at: #stored42 put: 42.
	self assert: answer value equals: 'stored42'.

	Matter reset
]

{ #category : #tests }
MatterServerTestCase >> testSizeAnswer [

	| api answer |
	Matter server start.
	api := MTClient host: 'localhost' port: MTServer port.

	api at: #stored40 put: 40.
	api at: #stored41 put: 41.
	api at: #stored42 put: 42.

	answer := api size.
	self assert: answer value equals: 3.

	Matter reset
]
