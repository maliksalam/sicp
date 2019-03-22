#lang racket
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) null sequence))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(define (length sequence)
  (accumulate (lambda (x y) (+ y 1)) 0 sequence))

;tests
(let ((a '(1 2 3 4))
      (b '(5 6 7 8)))
  (display (map sqr a))
  (newline)
  (display (append a b))
  (newline)
  (display (length a)))

   