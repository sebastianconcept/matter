"
Facade to use Fuel at this point
"
Class {
	#name : #MTSerializer,
	#superclass : #Object,
	#category : #'Matter-Core-Helpers'
}

{ #category : #actions }
MTSerializer >> materialize: aByteArray [

	^ (MCDataStream on: aByteArray readStream) next
]

{ #category : #actions }
MTSerializer >> serialize: anObject [

	^ MCDataStream streamedRepresentationOf: anObject
]
