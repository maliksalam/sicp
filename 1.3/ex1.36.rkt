#lang racket
(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess count)
    (display "iteration number: ")
    (display count)
    (newline)
    (display guess)
    (newline)
    (let ((next (f guess)))
      (cond ((close-enough? guess next)
             (display (+ 1 count))
             (newline)
             next)
            (else (try next (+ 1 count))))))
  (try first-guess 1))

(display "without average damping") (newline)
(fixed-point (lambda (x) (/(log 1000) (log x))) 4.5)

;And with average damping
(newline)
(display "with average damping") (newline)
(define (average a b)
  (/ (+ a b) 2))

(fixed-point (lambda (x) (average x (/(log 1000) (log x)))) 4.5)

#|
this takes 24 steps without average damping and 7 steps with. A very good gain.
|#