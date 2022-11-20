Class {
	#name : #MTAnswer,
	#superclass : #Object,
	#instVars : [
		'payload'
	],
	#category : #'Matter-Core-API'
}

{ #category : #'instance creation' }
MTAnswer class >> on: anObject [

	^ self new initializeOn: anObject
]

{ #category : #initialization }
MTAnswer >> initializeOn: anObject [

	payload := anObject
]

{ #category : #accessing }
MTAnswer >> payload [

	^ payload
]

{ #category : #accessing }
MTAnswer >> payload: anObject [

	payload := anObject
]
