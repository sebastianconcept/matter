Class {
	#name : #MTAtMessage,
	#superclass : #MTMessage,
	#instVars : [
		'key'
	],
	#category : #'Matter-Core-API'
}

{ #category : #accessing }
MTAtMessage class >> at: key [

	^ self new key: key
]

{ #category : #accessing }
MTAtMessage >> key [

	^ key
]

{ #category : #accessing }
MTAtMessage >> key: anObject [

	key := anObject
]

{ #category : #actions }
MTAtMessage >> processOn: aMTServer over: aWebSocket [

	| value |
	value := aMTServer store at: key.
	aMTServer answer: (MTAtAnswer on: value) on: aWebSocket
]
