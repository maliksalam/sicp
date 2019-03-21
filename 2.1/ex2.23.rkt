#lang racket
(define (for-each f l)
  (cond ((null? l)
         (newline))
        (else (f (car l))
              (for-each f (cdr l)))))


(for-each (lambda (x) (display x) (newline))
          (list 57 321 88))