#lang racket
(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (deriv g)
  (let ((dx  0.000001))
  (lambda (x)
    (/ (- (g (+ x dx)) (g x))
       dx))))

(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(define (cube x) (* x x x))

(define (cubic a b c)
  (lambda (x)
    (+ (cube x)
       (* a (sqr x))
       (* b x) c)))

(let ((a 1)
      (b (- 1))
      (c 1))
  (newtons-method (cubic a b c) 1))
