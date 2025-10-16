"CTAVLTree - simple rotation logging facility"

CTAVLTree classVariableNames: 'RotationLoggerEnabled'

CTAVLTree class>>enableRotationLogging
    RotationLoggerEnabled := true.

CTAVLTree class>>disableRotationLogging
    RotationLoggerEnabled := false.

"Wrap rotation helpers to emit logs (example for left rotation)"
CTAVLTree>>rotateLeft: node
    | r |
    r := node right.
    (r isNil) ifTrue: [ ^ node ].
    (RotationLoggerEnabled ifTrue: [ Transcript show: 'rotateLeft at ', (node value printString); cr ]).
    "existing rotation logic here (similar to rotateLeft in base impl)"
    " ... perform rotation, update parents, update heights/subtreeSizes ... "
    ^ newRoot "return new root after rotation"
