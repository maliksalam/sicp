#lang racket
(define (double x)
  (* x 2))

(define (halve x)
  (/ x 2))

(define (even? b)
  (= (remainder b 2) 0))

(define (fast-mult a b)
  (cond ((< b 0) (- (fast-mult a (- b))))
        ((= b 0) 0)
        ((= b 1) a)
        ((even? b) (double (fast-mult a (halve b))))
        (else (+ a (fast-mult a (- b 1))))))