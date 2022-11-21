Class {
	#name : #CaravanAlgorithmTestCase,
	#superclass : #MatterTestCase,
	#category : #'Matter-Client-Tests'
}

{ #category : #tests }
CaravanAlgorithmTestCase >> testMap3Nodes [

	| algo strings distribution mean min max |
	strings := (1 to: 1000) collect: [ :i | UUID new asString36 ].
	algo := MTCaravan from: { 'node1'. 'node2'. 'node3' }.
	distribution := Dictionary new.
	strings do: [ :str | 
		(distribution
			 at: (algo nodeFor: str)
			 ifAbsentPut: [ OrderedCollection new ]) add: str ].

	mean := 1000 / 3.
	min := mean - (mean * 0.1).
	max := mean + (mean * 0.1).
	self assert: (distribution at: 'node1') size > min.
	self assert: (distribution at: 'node1') size < max.

	self assert: (distribution at: 'node2') size > min.
	self assert: (distribution at: 'node2') size < max.

	self assert: (distribution at: 'node3') size > min.
	self assert: (distribution at: 'node3') size < max
]

{ #category : #tests }
CaravanAlgorithmTestCase >> testMap5Nodes [

	| algo strings distribution mean min max |
	strings := (1 to: 1000) collect: [ :i | UUID new asString36 ].
	algo := MTCaravan from:
		        { 'node1'. 'node2'. 'node3'. 'node4'. 'node5' }.

	distribution := Dictionary new.
	strings do: [ :str | 
		(distribution
			 at: (algo nodeFor: str)
			 ifAbsentPut: [ OrderedCollection new ]) add: str ].

	mean := 1000 / 5.
	min := mean - (mean * 0.1).
	max := mean + (mean * 0.1).
	self assert: (distribution at: 'node1') size > min.
	self assert: (distribution at: 'node1') size < max.

	self assert: (distribution at: 'node2') size > min.
	self assert: (distribution at: 'node2') size < max.

	self assert: (distribution at: 'node3') size > min.
	self assert: (distribution at: 'node3') size < max.
	
	self assert: (distribution at: 'node4') size > min.
	self assert: (distribution at: 'node4') size < max.

	self assert: (distribution at: 'node5') size > min.
	self assert: (distribution at: 'node5') size < max.

]
