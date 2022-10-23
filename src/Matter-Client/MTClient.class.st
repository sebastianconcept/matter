"
Matter client, API to use the Matter servers
"
Class {
	#name : #MTClient,
	#superclass : #Object,
	#instVars : [
		'serializer'
	],
	#category : #'Matter-Client-Core'
}

{ #category : #initialization }
MTClient >> initialize [

	super initialize.
	
	serializer := MTSerializer new
]

{ #category : #actions }
MTClient >> materialize: aByteArray [

	^ serializer materialize: aByteArray
]

{ #category : #actions }
MTClient >> serialize: anObject [

	^ serializer serialize: anObject
]
