#lang racket
(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence)))))


(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(fold-right / 1.0 '(1 2 3))
(fold-left / 1.0 '(1 2 3))
(fold-right list '() '(1 2 3))
(fold-left list '() '(1 2 3))
(fold-right - 0 '(1 2 3))
(fold-left - 0 '(1 2 3))
(fold-right + 0 '(1 2 3))
(fold-left + 0 '(1 2 3))
(fold-right * 1 '(1 2 3 4))
(fold-left * 1 '(1 2 3 4))

#|
fold right and fold-left will have the same results if op is commutative. Addition and multiplication are commutative hence the
last two pairs of procedure give the same result
|#