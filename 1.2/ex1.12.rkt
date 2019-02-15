#lang racket
(define (p x y)
  (cond ((< x y) (display "Error: coordinates are out of triangle"))
        ((or (= x y) (= y 0)) 1)
        (else (+ (p (- x 1) y)
                 (p (- x 1) (- y 1)) ))))
  