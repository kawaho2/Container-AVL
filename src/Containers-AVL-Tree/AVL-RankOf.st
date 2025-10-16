"CTAVLTree - position/rank query"

CTAVLTree>>rankOf: anElement
    "Return 1-based rank of anElement, or nil if not present."
    | node rank cmp |
    node := self root.
    rank := 0.
    [ node notNil ] whileTrue: [
        cmp := anElement compare: node value. "assumes values respond to #compare:"
        (cmp = 0) ifTrue: [
            rank := rank + ((node left ifNotNil: [ node left subtreeSize ]) ifNil: [ 0 ]) + 1.
            ^ rank ].
        (cmp < 0) ifTrue: [ node := node left ] ifFalse: [
            rank := rank + ((node left ifNotNil: [ node left subtreeSize ]) ifNil: [ 0 ]) + 1.
            node := node right ] ].
    ^ nil.
