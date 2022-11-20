"
Matter client, API to use the Matter servers
"
Class {
	#name : #MTClient,
	#superclass : #Object,
	#instVars : [
		'serializer',
		'webSocket',
		'hasher'
	],
	#category : #'Matter-Client-Core'
}

{ #category : #'as yet unclassified' }
MTClient class >> defaultHasher [

	^ MTPoliteKnight new
]

{ #category : #'instance creation' }
MTClient class >> host: aHostnameOrIpAddressString port: anInteger [

	^ self new initializeOn: (ZnWebSocket to: ('ws://{1}:{2}' format: { 
					    aHostnameOrIpAddressString.
					    anInteger asString }))
]

{ #category : #'instance creation' }
MTClient class >> url: aWebSocketURL [

	^ self new initializeOn:
		  (ZnWebSocket to: aWebSocketURL)
]

{ #category : #actions }
MTClient >> at: key [

	| message answer |
	message := MTAtMessage at: key.
	answer := (self sendMessage: message) readMessage.
	^ (self materialize: answer) payload
]

{ #category : #actions }
MTClient >> at: key put: aSerializable [

	| message answer |
	message := MTAtPutMessage at: key put: aSerializable.
	answer := (self sendMessage: message) readMessage.
	^ (self materialize: answer) payload
]

{ #category : #actions }
MTClient >> close [

	webSocket ifNotNil: [ webSocket close ]
]

{ #category : #accessing }
MTClient >> hasher [

	^ hasher ifNil: [ self initializeHasher ]
]

{ #category : #accessing }
MTClient >> hasher: anObject [

	hasher := anObject
]

{ #category : #initialization }
MTClient >> initialize [

	super initialize.
	
	serializer := MTSerializer new
]

{ #category : #initialization }
MTClient >> initializeHasher [

	^ hasher := self class defaultHasher
]

{ #category : #initialization }
MTClient >> initializeOn: aWebSocket [

	webSocket := aWebSocket
]

{ #category : #actions }
MTClient >> materialize: aByteArray [

	^ serializer materialize: aByteArray
]

{ #category : #actions }
MTClient >> sendMessage: message [

	^ self webSocket sendMessage: (self serialize: message)
]

{ #category : #actions }
MTClient >> serialize: anObject [

	^ serializer serialize: anObject
]

{ #category : #actions }
MTClient >> size [

	| message answer |
	message := MTSizeMessage new.
	answer := (self sendMessage: message) readMessage.
	^ (self materialize: answer) payload
]

{ #category : #accessing }
MTClient >> webSocket [

	^ webSocket
]
