#lang racket
(define (make-rectangle a c)
  (cons a c))

(define (length r)
  (let ((p1 (car r))
        (p2 (make-point (x-point (car r)) (y-point (cdr r)))))
    (make-segment p1 p2)))

(define (width r)
  (let ((p1 (cdr r))
        (p2 (make-point (x-point (car r)) (y-point (cdr r)))))
    (make-segment p1 p2)))
#|
(define (make-rectangle l w)
  (cons l w))

(define (length r)
  (car r))

(define (width r)
  (cdr r))
|#

(define (make-segment start end)
  (cons start end))

(define (start-segment x)
  (car x))

(define (end-segment x)
  (cdr x))

(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

(define (length-segment s)
  (let ((x1 (x-point (start-segment s)))
        (y1 (y-point (start-segment s)))
        (x2 (x-point (end-segment s)))
        (y2 (y-point (end-segment s))))
    (sqrt (+ (sqr (- x2 x1)) (sqr (- y2 y1))))))

(define (area r)
  (let ((l (length-segment (length r)))
        (w (length-segment (width r))))
    (* l w)))

(define (perimeter r)
  (let ((l (length-segment (length r)))
        (w (length-segment (width r))))
    (* 2 (+ l w))))

(define a (make-point 0 0))
(define b (make-point 0 2))
(define c (make-point 4 2))
(define w (make-segment a b))
(define l (make-segment b c))
;(define r (make-rectangle l w))
(define r2 (make-rectangle a c))
(length-segment w)
(length-segment l)
  
(area r2)
(perimeter r2)
