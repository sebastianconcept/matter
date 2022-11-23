"
I use many MTClients to access multiple MTServers where values are stored.
"
Class {
	#name : #Matter,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'distributor'
	],
	#category : #'Matter-Client-Core'
}

{ #category : #'instance creation' }
Matter class >> fromUrls: urls [

	^ self new initializeOn: (MTCaravan fromUrls: urls)
]

{ #category : #actions }
Matter >> at: key put: aSerializable [

	| url |
	url := distributor nodeFor: key.
	^ (nodes at: url ifAbsent: [ 
		   MTMissingNode signal:
			   ('Expected node missing at {1}' format: { url }) ])
		  at: key
		  put: aSerializable
]

{ #category : #initialization }
Matter >> initializeOn: aDistributionAlgorithm [

	distributor := aDistributionAlgorithm.
	nodes := Dictionary new.
	distributor nodes do: [ :selector | 
		nodes at: selector put: (self newClientOn: selector) ].
]

{ #category : #actions }
Matter >> newClientOn: selector [

	| url |
	url := selector asUrl.
	^ MTClient host: url host port: url port
]

{ #category : #accessing }
Matter >> nodes [

	^ nodes
]
