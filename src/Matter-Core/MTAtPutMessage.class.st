Class {
	#name : #MTAtPutMessage,
	#superclass : #MTMessage,
	#instVars : [
		'key',
		'value'
	],
	#category : #'Matter-Core-API'
}

{ #category : #accessing }
MTAtPutMessage class >> at: key put: value [

	^ self new
		  key: key;
		  value: value
]

{ #category : #accessing }
MTAtPutMessage >> key [

	^ key
]

{ #category : #accessing }
MTAtPutMessage >> key: anObject [

	key := anObject
]

{ #category : #actions }
MTAtPutMessage >> processOn: aMTServer over: aWebSocket [

	aMTServer store at: key put: value.
	aMTServer answer: (MTAtPutAnswer on: key) on: aWebSocket
]

{ #category : #accessing }
MTAtPutMessage >> value [

	^ value
]

{ #category : #accessing }
MTAtPutMessage >> value: anObject [

	value := anObject
]
