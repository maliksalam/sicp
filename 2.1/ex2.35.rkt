#lang racket
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (enumerate-tree tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))


(define (count-leaves t)
  (accumulate (lambda (x y) (+ 1 y))
              0
              (enumerate-tree t)))

#|
or following the template...
(define (count-leaves t)
   (accumulate + 0 (map (lambda (x) 1)
                        (enumerate-tree t))))
this looks way clunkier to me but does exactly the same thing. maybe it is more clear in terms of signal processing
in that case we could also rewrite length as follows
|#

(define (length l)
  (accumulate +
              0
              (map (lambda (x) 1)
                   l)))

(define x (cons (list 1 2) (list 3 4)))
(define a '(1 2 3 4))
(enumerate-tree x)
(count-leaves x)
(length a)