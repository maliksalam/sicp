#lang racket
#|
Because lisp uses applicative order for evaluation, the predicate of the if
statement gets evaluated first which gives us the operator for the outer
expression. This effectively changes the sign in front of b (+ if b is positive
 and - if b is negative). This is a procedure analogous to a + |b|.
|#

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))