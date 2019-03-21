#lang racket
(define (square-list items)
  (if (null? items)
      '()
      (cons (sqr (car items))
            (square-list (cdr items)))))

(square-list (list 1 2 3 4))

(define (square-list-map items)
  (map sqr items))

(square-list-map (list 1 2 3 4))