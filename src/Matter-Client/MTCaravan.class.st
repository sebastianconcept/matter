"
I help to distribute the hasheable value so it ends up even among the nodes 
"
Class {
	#name : #MTCaravan,
	#superclass : #MTDistributionAlgorithm,
	#category : #'Matter-Client-Algorithms'
}

{ #category : #accessing }
MTCaravan >> closestSlotFor: anInteger [

	self slots withIndexDo: [ :e :i | 
		i = size ifTrue: [ ^ e ].
		anInteger < e ifTrue: [ ^ e ] ]
]

{ #category : #accessing }
MTCaravan >> nodeFor: aHasheable [

	"Answers the node value that corresponds to the given hasheable object."

	^ self nodes at: (self slotIndexFor: aHasheable)
]

{ #category : #accessing }
MTCaravan >> reduceHash: aSmallInteger [

	^ (aSmallInteger asString last: 2) asInteger
]

{ #category : #accessing }
MTCaravan >> slotIndexFor: aHasheable [

	"Answers the slot index value that corresponds to the given hasheable object."

	| slot |
	slot := self closestSlotFor:
		        (self reduceHash: aHasheable identityHash).
	^ self slots indexOf: slot
]
