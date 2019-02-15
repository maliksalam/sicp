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

(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0)

;And with average damping
(define (average a b)
  (/ (+ a b) 2))
(fixed-point (lambda (x) (average x (+ 1 (/ 1 x)))) 1.0)

#|
let o be the golden ratio = (1 + sqrt(5))/2 ~ 1.6180 which is what the combination above valuates
to. However let's prove it.
if x is a fixed point of x -> 1 + 1/x it is a solution of the equation x = 1 + 1/x
The first way we can show that is to plug o into the equation above. We get:
o = 1 + 1/o
1 + 1/o - o = 0
multiplying by o, we get:
o + 1 - o^2 = 0
let's replace with the value of o and see if it holds
(1 + sqrt(5))/2 + 1 - ((1 + sqrt(5))/2)^2
= (1 + sqrt(5))/2 + 1 - (1 + 2sqrt(5) + 5)/4
= (2 + 2sqrt(5) + 4 - 1 - 2sqrt(5) - 5)/4
= (2 + 4 - 1 - 5) = 0
The equation holds for x = o therefore o is a fixed point of x -> 1 + 1/x

Another thing we can do is simply solve the equation - x^2 + x + 1 = 0
using the quadratic formula, we get:
x1 = (-1 + sqrt(1^2 - 4(-1*1)))/2*(-1) and
x2 = (-1 - sqrt(1^2 - 4(-1*1)))/2*(-1)

x2 = (-1 - sqrt(1 + 4))/-2
   = -(1 + sqrt(5))/-2
   = (1 + sqrt(5))/2 = o
surprise surprise!
|#