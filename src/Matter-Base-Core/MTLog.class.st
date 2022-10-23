"
Logging helper
"
Class {
	#name : #MTLog,
	#superclass : #Object,
	#category : #'Matter-Base-Core-Helpers'
}

{ #category : #logging }
MTLog class >> log: aString [
	Stdio stdout
		lf;
		<< ('[ ' , DateAndTime now asString , '] ');
		<< aString;
		flush
]
