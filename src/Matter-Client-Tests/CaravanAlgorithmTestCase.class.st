Class {
	#name : #CaravanAlgorithmTestCase,
	#superclass : #MatterTestCase,
	#category : #'Matter-Client-Tests'
}

{ #category : #tests }
CaravanAlgorithmTestCase >> testMap3Nodes [

	| algo strings distribution mean min max |
	strings := (1 to: 1000) collect: [ :i | UUID new asString36 ].
	algo := MTCaravan fromUrls: { 'node1'. 'node2'. 'node3' }.
	distribution := Dictionary new.
	strings do: [ :str | 
		(distribution
			 at: (algo nodeFor: str)
			 ifAbsentPut: [ OrderedCollection new ]) add: str ].

	mean := 1000 / 3.
	min := mean - (mean * 0.15).
	max := mean + (mean * 0.15).
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
	algo := MTCaravan fromUrls:
		        { 'node1'. 'node2'. 'node3'. 'node4'. 'node5' }.

	distribution := Dictionary new.
	strings do: [ :str | 
		(distribution
			 at: (algo nodeFor: str)
			 ifAbsentPut: [ OrderedCollection new ]) add: str ].

	mean := 1000 / 5.
	min := mean - (mean * 0.15).
	max := mean + (mean * 0.15).
	self assert: (distribution at: 'node1') size > min.
	self assert: (distribution at: 'node1') size <= max.

	self assert: (distribution at: 'node2') size > min.
	self assert: (distribution at: 'node2') size <= max.

	self assert: (distribution at: 'node3') size > min.
	self assert: (distribution at: 'node3') size <= max.

	self assert: (distribution at: 'node4') size > min.
	self assert: (distribution at: 'node4') size <= max.

	self assert: (distribution at: 'node5') size > min.
	self assert: (distribution at: 'node5') size <= max
]

{ #category : #tests }
CaravanAlgorithmTestCase >> testSameNodeForSameString [

	| algo str1 str2 str3 n1 n2 n3 |
	str1 := UUID new asString36.
	str2 := UUID new asString36.
	str3 := UUID new asString36.
	algo := MTCaravan fromUrls:
		        { 'node1'. 'node2'. 'node3'. 'node4'. 'node5' }.

	n1 := algo nodeFor: str1.
	n2 := algo nodeFor: str2.
	n3 := algo nodeFor: str3.

	1000 timesRepeat: [ self assert: n1 equals: (algo nodeFor: str1) ].
	1000 timesRepeat: [ self assert: n2 equals: (algo nodeFor: str2) ].
	1000 timesRepeat: [ self assert: n3 equals: (algo nodeFor: str3) ].
	
]
