#lang racket
(define (double p)
  (lambda (x) (p (p x))))

(define (inc x)
  (+ 1 x))

((double inc) 5)
(((double double) inc) 5)
((((double double) double ) inc) 5)