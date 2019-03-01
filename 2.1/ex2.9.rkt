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
  (mul-interval x 
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

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

(define (width-analysis a b)
  (display "interval a: ")
  (print-interval a)
  (display "width a: ")
  (display (width-interval a))
  (newline)
  (display "interval b: ")
  (print-interval b)
  (display "width b: ")
  (display (width-interval b))
  (newline)(newline)
  
  (display "interval (a + b): ")
  (print-interval (add-interval a b))
  (display "width (a + b): ")
  (display (width-interval (add-interval a b)))
  (newline)
  (display "width (a) + width (b): ")
  (display (+ (width-interval a) (width-interval b)))
  (newline)(newline)

  (display "interval (a - b): ")
  (print-interval (sub-interval a b))
  (display "width (a - b): ")
  (display (width-interval (sub-interval a b)))
  (newline)
  (display "width (a) + width (b): ")
  (display (+ (width-interval a) (width-interval b)))
  (newline)(newline)
  
  (display "interval (a * b): ")
  (print-interval (mul-interval a b))
  (display "width (a * b): ")
  (display (width-interval (mul-interval a b)))
  (newline)
  (display "width (a) * width (b): ")
  (display (* (width-interval a) (width-interval b)))
  (newline)(newline)
  
  (display "interval (a / b): ")
  (print-interval (div-interval a b))
  (display "width (a / b): ")
  (display (width-interval (div-interval a b)))
  (newline)
  (display "width (a) / width (b): ")
  (display (/ (width-interval a) (width-interval b)))
  (newline)(display "...................................")
  (newline)(newline))

(let ((a (make-interval 7.0 20.0))
      (b (make-interval 4.0 6.0)))
  (width-analysis a b))

(let ((a (make-interval 7.0 20.0))
      (b (make-interval 6.0 8.0)))
  (width-analysis a b))

(let ((a (make-interval -17.0 -2.0))
      (b (make-interval 6.0 25.0)))
  (width-analysis a b))

#|
Proof of (width-interval (+ x y)) = (width-interval (x - y)) = (+ (width-interval x) (width-interval y))
let's define:
x = [a, b]
y = [c, d]

(width-interval x) = (/ (- b a) 2)
(width-interval y) = (/ (- d c) 2)
(+ (width-interval x) (width-interval y) = (/ (+ (- b a) (- d c)) 2)
                       = (/ (+ b -a d -c) 2)
                       = (/ (- (+ b d) (+ a c)) 2)
(add-interval x y) = [(+ a c), (+ b d)]
(width-interval (add-interval x y)) = (width-interval [(+ a c), (+ b d)])
                                    = (/ (- (+ b d) (+ a c)) 2)
=> (width-interval (+ x y)) = (+ (width-interval x) (width-interval y))

also:
(width-interval (- x y)) = (width-interval (+ x -y))
                         = (+ (width-interval x) (width-interval -y))
-y = [-d, -c]
=> (width-interval -y) = (/ (- -c -d) 2)
                       = (/ (- d c) 2)
                       = (width-interval y)

=> (width-interval (- x y)) = (+ (width-interval x) (width-interval y))
                            = (width-interval (+ x y))
QED
|#