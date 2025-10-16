"CTAVLNode - count, subtreeSize accessor and helpers
Place this file into src/Container-AVL/ as CTAVLNode-CountsAndSizes.st

NOTE: If CTAVLNode does not have instance variables 'count' and 'subtreeSizeVar'
you must add them in the class browser (instance variable names: ... count subtreeSizeVar).
"

"Accessors"
CTAVLNode>>count
    "Return number of equal keys stored in this node (default 1)."
    (self respondsTo: #countVar) ifTrue: [ ^ countVar ].
    ^ 1.

CTAVLNode>>count: aNumber
    "Set count for this node."
    countVar := aNumber.

CTAVLNode>>subtreeSizeVar
    ^ (subtreeSizeVar ifNil: [ 1 + ((self left ifNotNil: [ self left subtreeSizeVar ]) ifNil: [ 0 ]) + ((self right ifNotNil: [ self right subtreeSizeVar ]) ifNil: [ 0 ]) ]).

CTAVLNode>>subtreeSizeVar: anInteger
    subtreeSizeVar := anInteger.

"Helpers"
CTAVLNode>>recomputeSubtreeSize
    "Recompute subtree size from children's subtreeSizeVar and this node's count."
    | ls rs |
    ls := (self left ifNotNil: [ self left subtreeSizeVar ]) ifNil: [ 0 ].
    rs := (self right ifNotNil: [ self right subtreeSizeVar ]) ifNil: [ 0 ].
    self subtreeSizeVar: (ls + rs + (self count)).
    ^ self subtreeSizeVar.

CTAVLNode>>updateSubtreeSizeUpwards
    "Walk up parents updating subtree sizes (and heights if desired)."
    | cur |
    cur := self.
    [ cur notNil ] whileTrue: [
        cur recomputeSubtreeSize.
        "if nodes have updateHeight: call it too - many AVL implementations use updateHeight"
        (cur respondsTo: #updateHeight) ifTrue: [ cur updateHeight ].
        cur := cur parent ].
    ^ self.
