#lang racket

(define (inc x)
  (+ 1 x))

(define (compose f g)
  (lambda (x) (f (g x))))


(define (repeated f n)
  (if (= n 0)
      (lambda (x) x)
      (compose f (repeated f (- n 1)))))

((repeated sqr 2) 5)
((repeated inc 2) 5)
((repeated inc 10) 10)