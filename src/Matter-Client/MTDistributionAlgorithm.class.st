"
I'm an abstract class with the commonalities of the different distribution algorithms.

"
Class {
	#name : #MTDistributionAlgorithm,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'size',
		'slots'
	],
	#category : #'Matter-Client-Algorithms'
}

{ #category : #'instance creation' }
MTDistributionAlgorithm class >> fromUrls: someUrls [

	^ self new initializeOn: someUrls
]

{ #category : #initialization }
MTDistributionAlgorithm >> initializeOn: someUrls [

	nodes := someUrls.
	self initializeSize 
]

{ #category : #initialization }
MTDistributionAlgorithm >> initializeSize [

	^ size := nodes size
]

{ #category : #initialization }
MTDistributionAlgorithm >> initializeSlots [

	"The hashed keys are going to be distributed in different 
	levels, one corresponding to each node.
	The 'slots' are the values at which the hash distribution 
	will 'snap' to and they are as many as configured nodes."

	^ slots := (1 to: self size) collect: [ :i | 
		           (100 / self size) asInteger * i ]
]

{ #category : #helpers }
MTDistributionAlgorithm >> nodeFor: aSelector [

	"Answers the node value that corresponds to the given selector."

	self subclassResponsibility
]

{ #category : #accessing }
MTDistributionAlgorithm >> nodes [

	^ nodes
]

{ #category : #accessing }
MTDistributionAlgorithm >> size [

	^ size ifNil: [ self initializeSize ]
]

{ #category : #accessing }
MTDistributionAlgorithm >> slots [

	^ slots ifNil: [ self initializeSlots ]
]
