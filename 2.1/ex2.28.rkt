#lang racket
(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

(define (fringe tree)
  (cond ((null? tree) '())
        ((pair? tree)
         (append (fringe (car tree))
                 (fringe (cdr tree))))
        (else (list tree))))

(define x (list (list 1 2) (list 3 4)))

(fringe x)

(fringe (list x x))

(fringe (list 1 (list 2 3) 4))