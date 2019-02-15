#lang racket
(define (square x) (* x x))

(define (sum_square a b) (+ (square a) (square b)))

(define (lg_ss a b c)
    (cond ((and (<= a b) (<= a c)) (sum_square b c))
          ((and (<= b a) (<= b c)) (sum_square a c))
          ((and (<= c b) (<= c a)) (sum_square a b))))