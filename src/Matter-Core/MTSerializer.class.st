"
Facade to use Fuel at this point
"
Class {
	#name : #MTSerializer,
	#superclass : #Object,
	#instVars : [
		'serializer',
		'materializer'
	],
	#category : #'Matter-Core-Helpers'
}

{ #category : #initialization }
MTSerializer >> initialize [

	super initialize.

	serializer := FLSerializer newDefault.
	materializer := FLMaterializer newDefault
]

{ #category : #actions }
MTSerializer >> materialize: aByteArray [

	^ (materializer materializeFrom: aByteArray readStream) root
]

{ #category : #actions }
MTSerializer >> serialize: anObject [

	| aStream |
	aStream := WriteStream on: (ByteArray new: 100).
	serializer serialize: anObject on: aStream.
	^ aStream contents
]
