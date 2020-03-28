Class {
	#name : #ConstructorPlugin,
	#superclass : #OCCompilerASTPlugin,
	#category : #ConstructorPlugin
}

{ #category : #private }
ConstructorPlugin class >> priority [
	^ 1
]

{ #category : #api }
ConstructorPlugin >> transform [
	
	"Do nothing..."
]

{ #category : #api }
ConstructorPlugin >> transformPreSemanticAnalysis [

	| classToCompileIn hiddenInstanceSideMethod |
	classToCompileIn := ast methodClass.
	((ast hasPragmaNamed: #constructor) not or: [ classToCompileIn isInstanceSide ])
		ifTrue: [ ^ ast ].
	
	hiddenInstanceSideMethod := classToCompileIn instanceSide compiler compile: ast sourceCode.
	ast := RBMethodNode
		selector: ast selector
		arguments: ast arguments
		body: (RBSequenceNode statements: { 
			RBReturnNode value: (RBMessageNode
				receiver: (RBMessageNode receiver: RBSelfNode new selector: #new)
				selector: #'withArgs:executeMethod:'
				arguments: { 
					RBArrayNode statements: ast arguments.
					(RBLiteralValueNode value: hiddenInstanceSideMethod) })
		 })
]
