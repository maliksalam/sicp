#lang racket
(define (cont-frac-iter n d k)
  (define (iter i result)
    (if (= i 0)
        result
        (iter (- i 1) (/ (n i) (+ result (d i))))))
  (iter k 0))

(define (tan-cf x k)
  (cont-frac-iter (lambda (i) (if (= i 1)
                                  x
                                  (- (sqr x))))
                  (lambda (i) (- (* 2 i) 1))
                  k))

(tan-cf 1.0 9)
(tan 1.0)

