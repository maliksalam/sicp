#lang racket
(define (cont-frac n d k)
  (define (iter i)
    (if (= i k)
        (/ (n i) (d i))
        (/(n i) (+ (d i) (iter (+ i 1))))))
  (iter 1))

(define (cont-frac-iter n d k)
  (define (iter i result)
    (if (= i 0)
        result
        (iter (- i 1) (/ (n i) (+ result (d i))))))
  (iter k 0))
      
(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           10)

(cont-frac-iter (lambda (i) 1.0)
                (lambda (i) 1.0)
                10)

#|
0.6180 is the approximation we are looking for; we get with k = 10
|#