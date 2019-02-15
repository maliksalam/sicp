#lang racket
(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (sqr test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b)
  (= (remainder b a) 0))

(display "199 smallest divisor: ")
(smallest-divisor 199)
(newline)

(display "1999 smallest divisor: ")
(smallest-divisor 1999)
(newline)

(display "19999 smallest divisor: ")
(smallest-divisor 19999)
(newline)