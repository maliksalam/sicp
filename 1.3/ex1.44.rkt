#lang racket
(define (compose f g)
  (lambda (x) (f (g x))))


(define (repeated f n)
  (if (= n 0)
      (lambda (x) x)
      (compose f (repeated f (- n 1)))))

(define (smooth f)
  (let ((dx 0.7))
    (lambda (x)
      (/ (+ (f (- x dx))
            (f x)
            (f (+ x dx)))
         3))))

(define (repeat-smooth f n)
  ((repeated smooth n) f))

(define (impulse-maker a y)
  (lambda (x)
    (if (= x a)
        y
        0)))

(define my-impulse-function
  (impulse-maker 0 6))

((smooth sin) (/ pi 2))
((repeat-smooth sin 1) (/ pi 2))
((repeat-smooth sin 2) (/ pi 2))
((repeat-smooth sin 3) (/ pi 2))
((repeat-smooth sin 4) (/ pi 2))
((repeat-smooth sin 10) (/ pi 2))

(+ 0.0 ((repeat-smooth my-impulse-function 3) 0))
(+ 0.0 ((smooth (smooth (smooth my-impulse-function))) 0))