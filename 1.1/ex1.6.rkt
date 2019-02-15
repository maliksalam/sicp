#lang racket
#|
(calling (sqrt x) will never terminate. Since (new-if) is not a special form,
and adhering to applicative order the interpreter will always evaluate both of
its arguments, therefore always making recursive call. By contrast, (if) and
(cond) evaluate predicates in order and stop when one evaluates to #t. This
problem only arises because (new-if) is a wrapper around (cond) replacing it
with (cond) would work just fine so, in this case, normal order evaluation would
work as well.
|#

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (square x)
  (* x x))

(define (sqrt x)
  (sqrt-iter (/ x 4.0) x))

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))