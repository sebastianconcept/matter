Class {
	#name : #MatterClientTestCase,
	#superclass : #MatterTestCase,
	#category : #'Matter-Client-Tests'
}

{ #category : #tests }
MatterClientTestCase >> testSimpleSerializeDeserialize [

	| api string bytes |
	api := MTClient new.

	string := 'this is what is about to be stored'.

	bytes := api serialize: string.
	self
		assert: (api materialize: bytes)
		equals: 'this is what is about to be stored'.

	bytes := api serialize: { (#answer -> 42) } asDictionary.
	self
		assert: (api materialize: bytes)
		equals: { (#answer -> 42) } asDictionary.
]
