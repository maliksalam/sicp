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

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (= n 0)
      (lambda (x) x)
      (compose f (repeated f (- n 1)))))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (average a b)
  (/ (+ a b) 2))

(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))

(define (sqrt x)
  (fixed-point-of-transform
   (lambda (y) (/ x y)) average-damp 1.0))

(define (experimental-root n x damp-count)
  (fixed-point-of-transform
   (lambda (y) (/ x (expt y (- n 1))))
   (repeated average-damp damp-count)
   1.0))


(define (root n x)
  (display "damp-count used: ")
  (display (floor (/ (log n) (log 2))))
  (newline)
  (fixed-point-of-transform
   (lambda (y) (/ x (expt y (- n 1))))
   (repeated average-damp (floor (/ (log n) (log 2))))
   1.0))

(sqrt 4)
(experimental-root 128 340282366920938463463374607431768211456 7)
(root 128 340282366920938463463374607431768211456)