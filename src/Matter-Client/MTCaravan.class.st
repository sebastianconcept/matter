"
I help to distribute the hasheable value so it ends up even among the nodes.

## Ploting the distributor
strings := (1 to: 900) collect:[:i| UUID new asString36 ].

algo := MTCaravan fromUrls: { 'node1'. 'node2'. 'node3' }.
algo := MTCaravan fromUrls: { 'node1'. 'node2'. 'node3'. 'node4'. 'node5'. 'node6'. 'node7'. 'node8'. 'node9'. 'node10'. 'node11'. 'node12'. 'node13'. 'node14'. 'node15' }.
algo := MTCaravan fromUrls: { 'node1'. 'node2'. 'node3'. 'node4'. 'node5' }.
map := [ :v | algo slotIndexFor: v ].
x := strings collect:[:s| s hash ]. 
y := strings collect:[:s| map value: s hash ]. 

chart := RSChart new.
plot := RSScatterPlot new x: x y: y.
chart
    addPlot: plot;
	addDecoration: (RSVerticalTick new);
    title: 'Hash distribution'.
chart open.
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
		        (self reduceHash: aHasheable hash).
	^ self slots indexOf: slot
]
