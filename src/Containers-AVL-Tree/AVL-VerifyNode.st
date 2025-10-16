"CTAVLTree - detailed verification helpers"

CTAVLTree>>verifyDetailed
    "Return an OrderedCollection of error strings describing any AVL invariant violations.
    Empty collection => tree OK."
    | errors |
    errors := OrderedCollection new.
    (self root ifNotNil: [ self root verifyNode: errors ]).
    ^ errors.

"Node method"
AVLNode>>verifyNode: errors
    "Check height correctness and balanceFactor in [-1,1]. Append messages to errors."
    | lh rh expectedHeight bf |
    lh := (self left ifNil: [ 0 ]) ifNotNil: [ self left height ].
    rh := (self right ifNil: [ 0 ]) ifNotNil: [ self right height ].
    expectedHeight := 1 + (lh max: rh).
    (self height = expectedHeight) ifFalse: [
        errors add: 'Height mismatch at node ', (self value printString), ' - has ', (self height printString), ' expected ', (expectedHeight printString) ].
    bf := lh - rh.
    ((bf abs) > 1) ifTrue: [
        errors add: 'Balance factor violation at node ', (self value printString), ' bf=', bf printString ].
    (self left ifNotNil: [ self left verifyNode: errors ]).
    (self right ifNotNil: [ self right verifyNode: errors ]).
    ^ self.
