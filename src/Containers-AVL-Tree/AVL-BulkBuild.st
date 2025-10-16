"CTAVLTree class-side bulk builder"

CTAVLTree class>>fromSortedArrayBalanced: sortedArray
    "Build a balanced AVL tree from sortedArray (assumes unique elements or keep duplicates as needed)."
    | tree |
    tree := self new.
    self buildRecursive: sortedArray from: 1 to: sortedArray size into: tree.
    ^ tree.

CTAVLTree class>>buildRecursive: arr from: lo to: hi into: tree
    (lo > hi) ifTrue: [ ^ nil ].
    | mid |
    mid := (lo + hi) // 2.
    tree add: (arr at: mid).
    self buildRecursive: arr from: lo to: mid - 1 into: tree.
    self buildRecursive: arr from: mid + 1 to: hi into: tree.
