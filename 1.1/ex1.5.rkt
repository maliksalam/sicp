#lang racket

#|
Applicative order: The interpreter will first evaluate the arguments to test.
When evaluating p it will keep defining it in terms of itself forever and hang.

Normal order: The interpreter will keep expanding expressions until it finds
an expression whose operator is a primitive. In this case it will expand
(test) and, (if) being a special form, (= x 0) evaluates to true and test
returns 0. It never evaluates (p) and does not hang.

Because Lisp uses applicative order, this will hang.
|#

(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

(test 0 (p))