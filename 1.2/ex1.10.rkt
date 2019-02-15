#lang racket
(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

(display "(A 1 10): ")
(A 1 10)
(display "(A 2 4): ")
(A 2 4)
(display "(A 3 3): ")
(A 3 3)

#|
(f n) computes 2*n
(g n) computes 2^n
(h n) computes 2^2^... (n times)
|#