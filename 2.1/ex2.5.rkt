#lang racket
(define (cons a b)
  (* (expt 2 a)
     (expt 3 b)))

(define (num-divs n d)
  (define (iter x count)
    (if (zero? (remainder x d))
        (iter (/ x d) (+ count 1))
        count))
  (iter n 0))

(define (car z)
  (num-divs z 2))

(define (cdr z)
  (num-divs z 3))

(define a (cons 32 2))
(car a)
(cdr a)