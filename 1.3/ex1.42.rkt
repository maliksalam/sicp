#lang racket
(define (inc x)
  (+ 1 x))

(define (compose f g)
  (lambda (x) (f (g x))))

((compose sqr inc) 6)