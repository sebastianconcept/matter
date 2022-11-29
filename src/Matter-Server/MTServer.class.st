"
I hold the WebSocket connections opened to serve clients and the service main API.

"
Class {
	#name : #MTServer,
	#superclass : #Object,
	#instVars : [
		'port',
		'zinc',
		'serializer',
		'store'
	],
	#category : #'Matter-Server-Core'
}

{ #category : #'instance creation' }
MTServer class >> new [

	^ self on: self port
]

{ #category : #'instance creation' }
MTServer class >> on: port [

	^ super new port: port
]

{ #category : #accessing }
MTServer class >> port [

	| value |
	value := OSEnvironment current at: 'MATTER_PORT' ifAbsent: [ nil ].
	^ value ifNil: [ 1901 ] ifNotNil: [ value asInteger ]
]

{ #category : #'instance creation' }
MTServer class >> startOn: port [

	^ (self on: port) start
]

{ #category : #actions }
MTServer >> answer: aMTAnswer on: aWebSocket [

	aWebSocket sendMessage: (self serialize: aMTAnswer)
]

{ #category : #initialization }
MTServer >> initialize [

	super initialize.

	serializer := MTSerializer new.
	store := self newStore
]

{ #category : #initialization }
MTServer >> initializePort [

	^ port := self class port
]

{ #category : #initialization }
MTServer >> initializeZinc [

	^ zinc := (ZnServer startOn: self port)
		          delegate: (ZnWebSocketDelegate handler: [ :webSocket | 
					           self onWebSocketConnected: webSocket ]);
		          yourself
]

{ #category : #actions }
MTServer >> materialize: aByteArray [

	^ serializer materialize: aByteArray
]

{ #category : #actions }
MTServer >> newStore [

	^ Dictionary new
]

{ #category : #reactions }
MTServer >> onMessage: aMessageByteArray from: aWebSocket [

	"Receives aMessage from the connection with aWebSocket.
	Interprets the message and sends a response."

	| message |
	message := self materialize: aMessageByteArray.
	message processOn: self over: aWebSocket
]

{ #category : #reactions }
MTServer >> onSocketClosed: aWebSocket [

	
]

{ #category : #reactions }
MTServer >> onWebSocketConnected: aWebSocket [

	^ self
		  run: aWebSocket
		  with: [ :message | self onMessage: message from: aWebSocket ]
]

{ #category : #accessing }
MTServer >> port [

	^ port ifNil: [ self initializePort ]
]

{ #category : #accessing }
MTServer >> port: anObject [

	port := anObject
]

{ #category : #'system startup' }
MTServer >> restart [

	self
		stop;
		start
]

{ #category : #actions }
MTServer >> run: aWebSocket with: aBlock [

	^ [ 
	  [ 
	  | message |
	  message := nil.
	  [ 
	  aWebSocket isConnected
		  ifTrue: [ message := aWebSocket readMessage ]
		  ifFalse: [ ConnectionClosed signal ] ]
		  on: ConnectionTimedOut
		  do: [ "Ignore & continue" aWebSocket ping ].
	  message ifNotNil: [ aBlock value: message ] ] repeat ]
		  on: ConnectionClosed
		  do: [ :x | self onSocketClosed: aWebSocket ]
]

{ #category : #actions }
MTServer >> serialize: anObject [

	^ serializer serialize: anObject
]

{ #category : #actions }
MTServer >> start [

	MTLog log: 'Starting Matter server'.
	self zinc
]

{ #category : #actions }
MTServer >> stop [

	MTLog log: 'Stopping Matter server'.
	zinc ifNotNil: [ 
		zinc stop.
		zinc := nil ]
]

{ #category : #accessing }
MTServer >> store [

	^ store
]

{ #category : #accessing }
MTServer >> zinc [

	^ zinc ifNil: [ zinc := self initializeZinc ]
]
