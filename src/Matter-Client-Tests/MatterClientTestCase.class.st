Class {
	#name : #MatterClientTestCase,
	#superclass : #MatterTestCase,
	#category : #'Matter-Client-Tests'
}

{ #category : #tests }
MatterClientTestCase >> testAtPutSerialization [

	| api target bytes reified |
	api := MTClient new.

	target := MTAtPutMessage at: #store put: 42.

	bytes := api serialize: target.
	reified := api materialize: bytes.
	self assert: reified key equals: #store.
	self assert: reified value equals: 42.

	target := MTAtPutMessage
		          at: #doc
		          put: { (#answer -> 42) } asDictionary.
	bytes := api serialize: target.
	reified := api materialize: bytes.
	self assert: reified value equals: { (#answer -> 42) } asDictionary
]

{ #category : #tests }
MatterClientTestCase >> testSimpleSerializeDeserialize [

	| api string bytes |
	api := MTClient new.

	string := 'this is what is about to be stored'.

	bytes := api serialize: string.
	self
		assert: (api materialize: bytes)
		equals: 'this is what is about to be stored'.

	bytes := api serialize: { (#answer -> 42) } asDictionary.
	self
		assert: (api materialize: bytes)
		equals: { (#answer -> 42) } asDictionary.
]

{ #category : #tests }
MatterClientTestCase >> testWebSocketEcho [

	| message client |
	ZnServer startDefaultOn: 1701.
	ZnServer default delegate:
		(ZnWebSocketDelegate map: 'ws-echo' to: ZnWebSocketEchoHandler new).
	client := MTClient url:
		          (ZnUrl fromString: 'ws://localhost:1701/ws-echo').
	message := 'Greetings from Pharo Smalltalk @ '
	           , DateAndTime now printString.
	client webSocket sendMessage: message.
	self assert: client webSocket readMessage equals: message.
	client close.
	ZnServer stopDefault
]
