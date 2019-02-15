#lang racket
(define (f-rec n)
  (if (< n 3)
      n
      (+ (f-rec (- n 1))
         (* 2 (f-rec (- n 2)))
         (* 3 (f-rec (- n 3))))))

(define (f-iter n)
  (define (iter a b c count)
    (cond ((< count 0) (display "Error: please input a number greater or equal to zero"))
          ((= count 0) a)
          (else (iter b c (+ (* 3 a) (* 2 b) c ) (- count 1)))))
      (iter 0 1 2 n))
