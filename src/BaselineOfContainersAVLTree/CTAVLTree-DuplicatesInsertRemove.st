"CTAVLTree - insertion & removal with duplicate counts
File: CTAVLTree-DuplicatesInsertRemove.st
Adds two new public methods: addAllowDuplicates: and removeOne:.
(They are non-intrusive helpers; you may choose to replace the existing add:/remove: with these.)
"

CTAVLTree>>addAllowDuplicates: aKey
    "Insert aKey. If a node with the same key exists increment its count.
    Rebalance and update subtree sizes up the path."
    | cur parent cmp newNode |
    cur := self root.
    parent := nil.
    [ cur notNil ] whileTrue: [
        parent := cur.
        cmp := (aKey compare: cur value) ifAbsent: [ (aKey = cur value) ifTrue: [ 0 ] ifFalse: [ (aKey asString compare: cur value asString) ] ].
        (cmp = 0) ifTrue: [
            "duplicate: increment count and update subtree sizes upwards"
            cur count: (cur count + 1).
            cur updateSubtreeSizeUpwards.
            ^ cur ].
        (cmp < 0) ifTrue: [ cur := cur left ] ifFalse: [ cur := cur right ] ].
    "not found: create a new node and insert as leaf"
    newNode := self newNodeWith: aKey parent: parent.
    (parent isNil) ifTrue: [ self root: newNode ]
        ifFalse: [ ((aKey compare: parent value) < 0) ifTrue: [ parent left: newNode ] ifFalse: [ parent right: newNode ] ].
    "ensure subtreeSizes and heights updated and then rebalance upwards"
    newNode updateSubtreeSizeUpwards.
    self rebalanceFrom: newNode.
    ^ newNode.

CTAVLTree>>removeOne: aKey
    "Remove one occurrence of aKey: if node has count > 1 decrement count; if count = 1 remove node.
    Returns true if something was removed, false if not present."
    | node |
    node := self locateNodeFor: aKey.
    node ifNil: [ ^ false ].
    (node count > 1) ifTrue: [
        node count: (node count - 1).
        node updateSubtreeSizeUpwards.
        ^ true ].
    "count = 1: do normal node removal (reuse existing remove node code path if present)"
    self removeNode: node.
    ^ true.

"Utilities - hooks you will need to implement if not present in your repo:
 - newNodeWith: parent:  --> create a CTAVLNode with given value and parent
 - locateNodeFor:        --> find node for aKey (existing tree likely has it)
 - removeNode: node      --> remove the node object and rebalance / update sizes
 - rebalanceFrom: node   --> walk-up rebalancer (we provided earlier in other suggestions)
If such helpers exist in your code base, use them; otherwise I can supply removeNode: implementation too."
