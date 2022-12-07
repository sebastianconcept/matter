Class {
	#name : #MatterShardTestCase,
	#superclass : #MatterTestCase,
	#category : #'Matter-Client-Tests'
}

{ #category : #tests }
MatterShardTestCase >> test3Nodes [

	| server1 server2 server3 urls client |
	server1 := MTServer startOn: 1801.
	server2 := MTServer startOn: 1802.
	server3 := MTServer startOn: 1803.
	urls := { 
		'ws://localhost:1801'.
		'ws://localhost:1802'.
		'ws://localhost:1803'.
	 }.
	client := Matter fromUrls: urls. 
	self assert: (client at: #store40 put: 40) equals: #store40.
	self assert: (client at: #store41 put: 41) equals: #store41.
	self assert: (client at: #store42 put: 42) equals: #store42.

	self assert: (client nodes at: 'ws://localhost:1801') size equals: 1.
	self assert: (client nodes at: 'ws://localhost:1802') size equals: 1.
	self assert: (client nodes at: 'ws://localhost:1803') size equals: 1.

	server1 stop.
	server2 stop.
	server3 stop.
	
]
