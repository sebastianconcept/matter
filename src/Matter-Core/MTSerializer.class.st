"
Facade to use Fuel at this point
"
Class {
	#name : #MTSerializer,
	#superclass : #Object,
	#category : #'Matter-Core-Helpers'
}

{ #category : #actions }
MTSerializer >> materialize: aString [

	^ STON fromString: aString
]

{ #category : #actions }
MTSerializer >> serialize: anObject [

	^ STON toString: anObject
]
