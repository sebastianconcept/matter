"
I hold the WebSocket connections opened to serve clients and the service main API.

"
Class {
	#name : #MTServer,
	#superclass : #Object,
	#instVars : [
		'zinc'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'Matter-Server-Core'
}

{ #category : #accessing }
MTServer class >> instance [

	^ instance ifNil: [ instance := self new ]
]

{ #category : #accessing }
MTServer class >> port [

	| value |
	value := OSEnvironment current at: 'MATTER_PORT' ifAbsent: [ nil ].
	^ value ifNil: [ 1901 ] ifNotNil: [ value asInteger ]
]

{ #category : #actions }
MTServer class >> reset [

	instance ifNotNil: [ 
		instance stop.
		instance := nil ]
]

{ #category : #'system startup' }
MTServer class >> shutDown: quiting [
	quiting
		ifTrue: [ self reset ]
]

{ #category : #'system startup' }
MTServer class >> startUp: resuming [

	resuming ifTrue: [ 
		self environment
			at: #SessionManager
			ifPresent: [ :manager | 
				manager default currentSession addDeferredStartupAction: [ 
					self restart ] ]
			ifAbsent: [ Smalltalk addDeferredStartupAction: [ self restart ] ] ]
]

{ #category : #accessing }
MTServer class >> token [

	^ OSEnvironment current at: 'MATTER_TOKEN' ifAbsent: [ 
		  self error:
			  'The Matter server requires the MATTER_TOKEN env var value to be set' ]
]

{ #category : #initialization }
MTServer >> initializeZinc [

	^ zinc := (ZnServer startOn: self class port)
		          delegate: (ZnWebSocketDelegate handler: [ :webSocket | 
					           self onWebSocketConnected: webSocket ]);
		          yourself
]

{ #category : #reactions }
MTServer >> onMessage: aMessageString from: aWebSocket [
	"Receives aMessage from the connection with aWebSocket.
	Interprets the message and sends a response."
	Transcript crShow: aMessageString 
	"| view message newViewModel |
	message := MTMessage for: aMessageString.
	view := self views
		at: aWebSocket
		ifAbsentPut: [ newViewModel := LBViewModel
				fromMessage: message
				on: aWebSocket
				for: self.
			self triggerEvent: #viewModelOpened: with: newViewModel.
			newViewModel ].
	message sentTo: view"
]

{ #category : #reactions }
MTServer >> onSocketClosed: aWebSocket [
	"views ifNotNil: [ views removeKey: aWebSocket ifAbsent: [ nil ] ]"
]

{ #category : #reactions }
MTServer >> onWebSocketConnected: aWebSocket [

	^ self
		  run: aWebSocket
		  with: [ :message | self onMessage: message from: aWebSocket ]
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

{ #category : #accessing }
MTServer >> start [

	MTLog log: 'Starting Matter server'.
	self zinc 	
]

{ #category : #accessing }
MTServer >> stop [

	MTLog log: 'Stopping Matter server'.
	zinc ifNotNil: [ 
		zinc stop.
		zinc := nil ]
]

{ #category : #accessing }
MTServer >> zinc [

	^ zinc ifNil: [ zinc := self initializeZinc ]
]
