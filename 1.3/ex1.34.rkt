#lang racket
(define (f g)
  (g 2))

(f sqr)

(f (lambda (z) (* z (+ z 1))))

(f f)

#|
(f f) returns an error because of the following evaluation trace
(f f)
(f 2) 
(2 2) <- this expression returns an error because the interpreter it expects a procedure after an
open parenthesis and it got the number 2 which is not a procedure
|#