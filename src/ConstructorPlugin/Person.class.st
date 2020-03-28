Class {
	#name : #Person,
	#superclass : #Object,
	#instVars : [
		'name',
		'age'
	],
	#category : #ConstructorPlugin
}

{ #category : #compiler }
Person class >> classSideCompiler [
	"the example plugin is active for this class"
	^super classSideCompiler addPlugin: ConstructorPlugin
]

{ #category : #'instance creation' }
Person class >> new2WithName: aName age: anAge [

	^ self new initializeWithName: aName age: anAge
]

{ #category : #'instance creation' }
Person class >> newWithName: aName age: anAge [
	<constructor>

	name := aName.
	age := anAge
]

{ #category : #'instance creation' }
Person class >> noConstructorWithName: aName age: anAge [

	^ self new initializeWithName: aName age: anAge
]

{ #category : #initialization }
Person >> initializeWithName: aName age: anAge [
	name := aName.
	age := anAge
]
