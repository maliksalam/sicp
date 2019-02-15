#lang racket

(define (cont-frac-iter n d k)
  (define (iter i result)
    (if (= i 0)
        result
        (iter (- i 1) (/ (n i) (+ result (d i))))))
  (iter k 0))

(define (d i)
  (define (iter a b c j)
    (cond ((> j (+ i 1))
           a)
          ((= a 1)
           (iter b c 1 (+ j 1)))
          (else
           (iter b c (+ a 2) (+ j 1)))))
  (iter 1 2 1 3))

(define (better-d i)
  (if (not (= 2 (remainder i 3)))
      1
      (* 2 (/ (+ i 1) 3))))

(- (+ (cont-frac-iter (lambda (i) 1.0)
                      better-d
                      20)
      2)
   2.718281828459045)
#|
this converges to 2 fairly quickly only k=20
2.718281828459045
|#