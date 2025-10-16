"CTAVLTree Graphviz DOT export"

CTAVLTree>>toDot
    | sb |
    sb := String streamContents: [:s |
        s nextPutAll: 'digraph AVL {'; cr.
        s nextPutAll: '  node [shape=record];'; cr.
        (self root ifNotNil: [ self root toDotOn: s ]).
        s nextPutAll: '}' ].
    ^ sb contents.

"Node method"
AVLNode>>toDotOn: stream
    | nodeName |
    nodeName := 'n', (self identityHash asString).
    stream nextPutAll: '  ', nodeName, ' [label="', (self value printString), '\n(h=', (self height printString), ' s=', (self subtreeSize printString), ')"];'; cr.
    (self left ifNotNil: [
        stream nextPutAll: '  ', nodeName, ' -> n', (self left identityHash asString), ';'; cr.
        self left toDotOn: stream ]).
    (self right ifNotNil: [
        stream nextPutAll: '  ', nodeName, ' -> n', (self right identityHash asString), ';'; cr.
        self right toDotOn: stream ]).
