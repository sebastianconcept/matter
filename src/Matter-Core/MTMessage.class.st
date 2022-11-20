Class {
	#name : #MTMessage,
	#superclass : #Object,
	#category : #'Matter-Core-API'
}

{ #category : #actions }
MTMessage >> processOn: aMTServer over: aWebSocket [

	Transcript crShow: aMTServer 
]
