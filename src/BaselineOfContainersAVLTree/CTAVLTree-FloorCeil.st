"CTAVLTree - Floor/Ceil/Successor/Predecessor helpers
File: CTAVLTree-FloorCeil.st
Adds: floor:, ceil:, successorOf:, predecessorOf:
"

CTAVLTree>>floor: aKey
    "Return the greatest element <= aKey or nil if none."
    | cur candidate cmp |
    cur := self root.
    candidate := nil.
    [ cur notNil ] whileTrue: [
        cmp := (aKey compare: cur value) ifAbsent: [ (aKey = cur value) ifTrue: [ 0 ] ifFalse: [ (aKey asString compare: cur value asString) ] ].
        (cmp = 0) ifTrue: [ ^ cur value ].
        (cmp < 0) ifTrue: [ cur := cur left ] ifFalse: [ candidate := cur value. cur := cur right ] ].
    ^ candidate.

CTAVLTree>>ceil: aKey
    "Return the smallest element >= aKey or nil if none."
    | cur candidate cmp |
    cur := self root.
    candidate := nil.
    [ cur notNil ] whileTrue: [
        cmp := (aKey compare: cur value) ifAbsent: [ (aKey = cur value) ifTrue: [ 0 ] ifFalse: [ (aKey asString compare: cur value asString) ] ].
        (cmp = 0) ifTrue: [ ^ cur value ].
        (cmp < 0) ifTrue: [ candidate := cur value. cur := cur left ] ifFalse: [ cur := cur right ] ].
    ^ candidate.

CTAVLTree>>successorOf: aKey
    "Return the smallest element > aKey or nil if none."
    | node |
    node := self locateNodeFor: aKey.
    node ifNil: [ ^ (self ceil: aKey) ]. "if not present, ceil returns >=; we need > so if ceil == aKey treat accordingly"
    | s |
    s := node successor.
    ^ s ifNil: [ nil ] ifNotNil: [ s value ].

CTAVLTree>>predecessorOf: aKey
    "Return the largest element < aKey or nil if none."
    | node p |
    node := self locateNodeFor: aKey.
    node ifNil: [ ^ (self floor: aKey) ].
    p := node predecessor.
    ^ p ifNil: [ nil ] ifNotNil: [ p value ].
