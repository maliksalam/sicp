#lang racket
(define (square-tree-d tree)
  (cond((null? tree) null)
       ((not (pair? tree)) (sqr tree))
       (else (cons (square-tree-d (car tree))
                   (square-tree-d (cdr tree))))))

(define (square-tree-m tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree-m sub-tree)
             (sqr sub-tree)))
       tree))
  
;Tests
(square-tree-d
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))

(square-tree-m
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))