"
Matter client, API to use the Matter servers
"
Class {
	#name : #MTClient,
	#superclass : #Object,
	#instVars : [
		'serializer',
		'webSocket'
	],
	#category : #'Matter-Client-Core'
}

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
MTClient >> close [

	webSocket ifNotNil: [ webSocket close ]
]

{ #category : #initialization }
MTClient >> initialize [

	super initialize.
	
	serializer := MTSerializer new
]

{ #category : #initialization }
MTClient >> initializeOn: aWebSocketURL [

	webSocket := aWebSocketURL
]

{ #category : #actions }
MTClient >> materialize: aByteArray [

	^ serializer materialize: aByteArray
]

{ #category : #actions }
MTClient >> serialize: anObject [

	^ serializer serialize: anObject
]

{ #category : #accessing }
MTClient >> webSocket [

	^ webSocket
]
