"CTAVLTree - small test examples and usage snippets
File: CTAVLTree-TestsExamples.st

"Example usage"
| t1 t2 unionTree interTree diffTree |
t1 := CTAVLTree new.
t1 addAllowDuplicates: 5; addAllowDuplicates: 2; addAllowDuplicates: 5; addAllowDuplicates: 10.
t2 := CTAVLTree new.
t2 addAllowDuplicates: 5; addAllowDuplicates: 7; t2 addAllowDuplicates: 5.

"Union (multiplicity = max) -> counts for 5 should be max(2,2)=2 etc"
unionTree := CTAVLTree unionOf: t1 and: t2.
Transcript show: 'Union as array: ', (unionTree asSortedArrayWithCounts) printString; cr.

interTree := CTAVLTree intersectionOf: t1 and: t2.
Transcript show: 'Intersection: ', (interTree asSortedArrayWithCounts) printString; cr.

diffTree := CTAVLTree differenceOf: t1 minus: t2.
Transcript show: 'Difference (t1 \\ t2): ', (diffTree asSortedArrayWithCounts) printString; cr.

"Floor/Ceil examples"
Transcript show: 'floor 6 in t1: ', (t1 floor: 6) printString; cr.
Transcript show: 'ceil 6 in t1: ', (t1 ceil: 6) printString; cr.

"Removal"
t1 removeOne: 5. "decrement count of 5 from 2 to 1"
Transcript show: t1 asSortedArrayWithCounts; cr.
t1 removeOne: 5. "remove last 5 - node removed"
Transcript show: t1 asSortedArrayWithCounts; cr.
