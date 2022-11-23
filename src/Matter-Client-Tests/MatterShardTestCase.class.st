Class {
	#name : #MatterShardTestCase,
	#superclass : #MatterTestCase,
	#category : #'Matter-Client-Tests'
}

{ #category : #tests }
MatterShardTestCase >> test3Nodes [

	| server1 server2 server3 urls client |
	server1 := MTServer startOn: 1901.
	server2 := MTServer startOn: 1902.
	server3 := MTServer startOn: 1903.
	urls := { 
		'ws://localhost:1901'.
		'ws://localhost:1902'.
		'ws://localhost:1903'.
	 }.
	client := Matter fromUrls: urls. 
	self assert: (client at: #store40 put: 40) equals: #store40.
	self assert: (client at: #store41 put: 41) equals: #store41.
	self assert: (client at: #store42 put: 42) equals: #store42.

	self assert: (client nodes at: 'ws://localhost:1901') size equals: 2.
	self assert: (client nodes at: 'ws://localhost:1902') size equals: 0.
	self assert: (client nodes at: 'ws://localhost:1903') size equals: 1.

	server1 stop.
	server2 stop.
	server3 stop.
	
]
