Class {
	#name : #MTSizeMessage,
	#superclass : #MTMessage,
	#category : #'Matter-Core-API'
}

{ #category : #actions }
MTSizeMessage >> processOn: aMTServer over: aWebSocket [

	aMTServer
		answer: (MTSizeAnswer on: aMTServer store size)
		on: aWebSocket
]
