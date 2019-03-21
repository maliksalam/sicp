#lang racket
(define (reverse list)
  (define (reverse-iter l r)
    (if (null?  l)
        r
        (reverse-iter (cdr l) (cons (car l) r))))
  (reverse-iter list '()))

(reverse (list 1 4 9 16 25))