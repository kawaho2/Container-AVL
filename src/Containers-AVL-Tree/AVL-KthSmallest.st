"CTAVLTree - order statistic"

CTAVLTree>>kthSmallest: k
    "Return the kth smallest value (1-based). Return nil if out of range."
    (k isKindOf: Integer) ifFalse: [ ^ nil ].
    (k <= 0) ifTrue: [ ^ nil ].
    (self root ifNil: [ ^ nil ]).
    | node |
    node := self root.
    [ node notNil ] whileTrue: [
        | leftSize |
        leftSize := (node left ifNotNil: [ node left subtreeSize ]) ifNil: [ 0 ].
        (leftSize + 1 = k) ifTrue: [ ^ node value ].
        (k <= leftSize) ifTrue: [ node := node left ] ifFalse: [ k := k - (leftSize + 1). node := node right ] ].
    ^ nil.
