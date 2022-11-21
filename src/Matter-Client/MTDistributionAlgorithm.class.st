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
MTDistributionAlgorithm class >> from: anArray [

	^ self new initializeOn: anArray
]

{ #category : #initialization }
MTDistributionAlgorithm >> initializeOn: anArray [

	nodes := anArray.
	self initializeSize 
]

{ #category : #initialization }
MTDistributionAlgorithm >> initializeSize [

	^ size := nodes size
]

{ #category : #initialization }
MTDistributionAlgorithm >> initializeSlots [

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
