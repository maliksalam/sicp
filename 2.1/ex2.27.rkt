#lang racket
(define (reverse items)
  (define (reverse-iter l r)
    (if (null?  l)
        r
        (reverse-iter (cdr l) (cons (car l) r))))
  (reverse-iter items '()))

(define (deep-reverse items)
  (define (reverse-iter l r)
    (if (null?  l)
        r
        (if (pair? (car l))
            (reverse-iter (cdr l) (cons (reverse-iter (car l) '()) r))
            (reverse-iter (cdr l) (cons (car l) r)))))
  (reverse-iter items '()))




(define x (list (list 1 2) (list 3 4)))
(reverse x)
(deep-reverse x)

(define y (list (list 1 2) (list (list 3 4) (list 5 6 7))))
(deep-reverse y)
