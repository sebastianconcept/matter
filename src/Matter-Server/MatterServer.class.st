"
I hold the WebSocket connections opened to serve clients and the service main API.

"
Class {
	#name : #MatterServer,
	#superclass : #Object,
	#classInstVars : [
		'instance'
	],
	#category : #'Matter-Server'
}

{ #category : #accessing }
MatterServer class >> instance [

	^ instance ifNil: [ instance := self new ]
]

{ #category : #accessing }
MatterServer class >> port [

	| value |
	value := OSEnvironment current at: 'MATTER_PORT' ifAbsent: [ nil ].
	^ value ifNil: [ 1901 ] ifNotNil: [ value asInteger ]
]

{ #category : #actions }
MatterServer class >> reset [

	instance ifNotNil: [ 
		instance stop.
		instance := nil ]
]

{ #category : #'system startup' }
MatterServer class >> shutDown: quiting [
	quiting
		ifTrue: [ self reset ]
]

{ #category : #'system startup' }
MatterServer class >> startUp: resuming [

	resuming ifTrue: [ 
		self environment
			at: #SessionManager
			ifPresent: [ :manager | 
				manager default currentSession addDeferredStartupAction: [ 
					self restart ] ]
			ifAbsent: [ Smalltalk addDeferredStartupAction: [ self restart ] ] ]
]

{ #category : #accessing }
MatterServer class >> token [

	^ OSEnvironment current at: 'MATTER_TOKEN' ifAbsent: [ 
		  self error:
			  'The Matter server requires the MATTER_TOKEN env var value to be set' ]
]

{ #category : #'system startup' }
MatterServer >> restart [

	self
		stop;
		start
]

{ #category : #accessing }
MatterServer >> start [

	MTLog log: 'Starting Matter server'
]

{ #category : #accessing }
MatterServer >> stop [

	MTLog log: 'Stopping Matter server'
]
