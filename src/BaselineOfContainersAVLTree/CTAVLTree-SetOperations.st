"CTAVLTree - Set operations implemented via sorted arrays
File: CTAVLTree-SetOperations.st

We implement class-side operations that take two CTAVLTree instances and return a new CTAVLTree
that is balanced. The implementation uses asArray (inorder) and then merges / filters arrays.
"

"Helpers: convert tree to sorted array of values (respecting counts)"
CTAVLTree>>asSortedArrayWithCounts
    "Return an OrderedCollection of values where duplicates appear count times (in-order)."
    | out |
    out := OrderedCollection new.
    (self root ifNotNil: [ self root appendValuesTo: out ]).
    ^ out.

CTAVLNode>>appendValuesTo: collection
    (self left ifNotNil: [ self left appendValuesTo: collection ]).
    1 to: self count do: [ collection add: self value ].
    (self right ifNotNil: [ self right appendValuesTo: collection ]).

"Balanced builder from sorted array (median recursion)"
CTAVLTree class>>fromSortedArrayBalanced: sortedArray
    | tree |
    tree := self new.
    (self buildRecursive: sortedArray from: 1 to: sortedArray size into: tree).
    ^ tree.

CTAVLTree class>>buildRecursive: arr from: lo to: hi into: tree
    (lo > hi) ifTrue: [ ^ nil ].
    | mid |
    mid := (lo + hi) // 2.
    tree addAllowDuplicates: (arr at: mid).
    self buildRecursive: arr from: lo to: mid - 1 into: tree.
    self buildRecursive: arr from: mid + 1 to: hi into: tree.
    ^ tree.

"Set operation: union (multiset-aware: keeps multiplicity = max counts from both trees)"
CTAVLTree class>>unionOf: treeA and: treeB
    | aMap bMap keys mergedArr |
    "Strategy: produce a sorted collection where multiplicity for each key is max(countA,countB). We'll build from sorted list of keys repeating multiplicity times."
    aMap := IdentityDictionary new.
    bMap := IdentityDictionary new.
    treeA root ifNotNil: [ treeA root collectCountsInto: aMap ].
    treeB root ifNotNil: [ treeB root collectCountsInto: bMap ].
    "build merged array"
    keys := (aMap keys asArray , bMap keys asArray) asSet asSortedCollection.
    mergedArr := OrderedCollection new.
    keys do: [:k |
        | ca cb m |
        ca := (aMap includesKey: k) ifTrue: [ aMap at: k ] ifFalse: [ 0 ].
        cb := (bMap includesKey: k) ifTrue: [ bMap at: k ] ifFalse: [ 0 ].
        m := ca max: cb.
        1 to: m do: [ mergedArr add: k ] ].
    ^ self fromSortedArrayBalanced: mergedArr.

"Set operation: intersection (multiplicity = min counts)"
CTAVLTree class>>intersectionOf: treeA and: treeB
    | aMap bMap keys mergedArr |
    aMap := IdentityDictionary new.
    bMap := IdentityDictionary new.
    treeA root ifNotNil: [ treeA root collectCountsInto: aMap ].
    treeB root ifNotNil: [ treeB root collectCountsInto: bMap ].
    keys := aMap keys asSet intersection: (bMap keys asSet) asSortedCollection.
    mergedArr := OrderedCollection new.
    keys do: [:k |
        | ca cb m |
        ca := aMap at: k.
        cb := bMap at: k.
        m := ca min: cb.
        1 to: m do: [ mergedArr add: k ] ].
    ^ self fromSortedArrayBalanced: mergedArr.

"Set operation: difference (treeA \ treeB) multiplicity = max(0, countA - countB)"
CTAVLTree class>>differenceOf: treeA minus: treeB
    | aMap bMap keys mergedArr |
    aMap := IdentityDictionary new.
    bMap := IdentityDictionary new.
    treeA root ifNotNil: [ treeA root collectCountsInto: aMap ].
    treeB root ifNotNil: [ treeB root collectCountsInto: bMap ].
    keys := aMap keys asSortedCollection.
    mergedArr := OrderedCollection new.
    keys do: [:k |
        | ca cb m |
        ca := aMap at: k.
        cb := (bMap includesKey: k) ifTrue: [ bMap at: k ] ifFalse: [ 0 ].
        m := (ca - cb) max: 0.
        1 to: m do: [ mergedArr add: k ] ].
    ^ self fromSortedArrayBalanced: mergedArr.

"Node helper: collect counts into a dictionary"
CTAVLNode>>collectCountsInto: dict
    self left ifNotNil: [ self left collectCountsInto: dict ].
    dict at: self value put: (dict includesKey: self value ifTrue: [ (dict at: self value) + self count ] ifFalse: [ self count ]).
    self right ifNotNil: [ self right collectCountsInto: dict ].
