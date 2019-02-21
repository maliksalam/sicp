#lang racket
(define (iterative-improve good-enough? improve-guess)
  (define (iter guess)
    (if (good-enough? guess)
        (improve-guess guess)
        (iter (improve-guess guess))))
  iter)


(define (sqrt x)
  ((iterative-improve
    (lambda (guess) (< (abs (- (sqr guess) x)) 0.001))
    (lambda (guess) (average guess (/ x guess))))
   1.0))

(define (fixed-point f first-guess)
  ((iterative-improve
    (lambda (guess) (< (abs (- guess (f guess))) 0.00001))
    f)
   first-guess))


(define (average x y)
  (/ (+ x y) 2))

(sqrt 4)
(fixed-point cos 1.0)
(fixed-point (lambda (y) (+ (sin y) (cos y)))
             1.0)
(fixed-point (lambda (x) (+ 1 (/ 1 x))) 2.0)