"AVLNode: subtree size getter/setter and maintenance helper"

AVLNode>>subtreeSize
    "Return cached subtree size (assumes maintenance done on updates)."
    (self respondsTo: #subtreeSizeVar) ifTrue: [ ^ self subtreeSizeVar ].
    ^ 1 + ((self left ifNotNil: [ self left subtreeSize ]) ifNil: [ 0 ]) + ((self right ifNotNil: [ self right subtreeSize ]) ifNil: [ 0 ]).

AVLNode>>updateSubtreeSize
    "Update cached subtree size from children."
    | ls rs |
    ls := (self left ifNotNil: [ self left subtreeSize ]) ifNil: [ 0 ].
    rs := (self right ifNotNil: [ self right subtreeSize ]) ifNil: [ 0 ].
    self subtreeSizeVar: (1 + ls + rs).
    ^ self.

"Small helper to set the ivar (implementor: choose your preferred ivar/setter style)"
AVLNode>>subtreeSizeVar: anInteger
    "Store subtree size in a private ivar named 'subtreeSizeVar'."
    subtreeSizeVar := anInteger.
