#lang racket
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (if (and (positive? (upper-bound y))
           (negative? (lower-bound y)))
      (error "ERROR: division by an interval spanning 0 is not defined")
      (mul-interval x 
                    (make-interval (/ 1.0 (upper-bound y))
                                   (/ 1.0 (lower-bound y))))))

(define (width-interval i)
  (/ (- (upper-bound i) (lower-bound i))
     2))

(define (print-interval i)
  (display "[")
  (display (lower-bound i))
  (display ", ")
  (display (upper-bound i))
  (display "]")
  (newline))

(define (make-interval a b) (cons a b))
(define (upper-bound x) (cdr x))
(define (lower-bound x) (car x))

(let ((a (make-interval 1.0 2.0))
      (b (make-interval -1.0 1.0))
      (c (make-interval 4.0 17.0)))
  (print-interval (div-interval a c))
  (newline)
  (print-interval (div-interval a b)))
      