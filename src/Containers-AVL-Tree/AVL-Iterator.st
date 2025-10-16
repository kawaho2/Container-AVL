"AVL in-order iterator"

Object subclass: #AVLInOrderIterator
    instanceVariableNames: 'stack'
    classVariableNames: ''
    package: 'Container-AVL-Iteration'.

AVLInOrderIterator>>initializeFrom: root
    stack := OrderedCollection new.
    self pushLefts: root.
    ^ self.

AVLInOrderIterator>>pushLefts: node
    [ node notNil ] whileTrue: [ stack add: node. node := node left ].

AVLInOrderIterator>>hasNext
    ^ stack notEmpty.

AVLInOrderIterator>>next
    | node result |
    self hasNext ifFalse: [ self error: 'No next element' ].
    node := stack removeLast.
    result := node value.
    (node right notNil) ifTrue: [ self pushLefts: node right ].
    ^ result.

"Factory on CTAVLTree"
CTAVLTree>>iterator
    ^ (AVLInOrderIterator new initializeFrom: self root).
