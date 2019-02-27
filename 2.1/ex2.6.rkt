#lang racket
(define zero (lambda (f) (lambda (x) x)))

(define one (lambda (f) (lambda (x) (f x))))

(define two (lambda (f) (lambda (x) (f (f x)))))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define (* a b)
  (lambda (f) (a (b f))))

(define (+ a b)
  (lambda (f) (lambda (x) ((a f) ((b f) x)))))


((zero add1) 0)
((one add1) 0)
((two add1) 0)
(((* two one) add1) 0)
(((+ two one) add1) 0)

#|
Substituting to get an expression of one:
(add-1 zero)
(lambda (f) (lambda (x) (f ((zero f) x))))
(lambda (f) (lambda (x) (f ((lambda (x) x) x))))
(lambda (f) (lambda (x) (f x)))

Substituting to get an expression of two:
(add-1 one)
(lambda (f) (lambda (x) (f ((one f) x))))
(lambda (f) (lambda (x) (f ((lambda (x) (f x)) x))))
(lambda (f) (lambda (x) (f (f x))))
|#
