#lang racket
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

(define (mul-interval x y)
  (let* ((a (lower-bound x))
         (b (upper-bound x))
         (c (lower-bound y))
         (d (upper-bound y))
         (apos? (positive? a))
         (bpos? (positive? b))
         (cpos? (positive? c))
         (dpos? (positive? d)))
    (cond ((and apos? cpos?) (make-interval (* a c) (* b d)))
          ((and (not bpos?) (not dpos?)) (make-interval (* b d) (* a c)))
          ((and (not bpos?) cpos?) (make-interval (* a d) (* b c)))
          ((and apos? (not dpos?)) (make-interval (* b c) (* a d)))
          ((and (not apos?) bpos? cpos?) (make-interval (* a d) (* b d)))
          ((and apos? (not cpos?) dpos?) (make-interval (* b c) (* b d)))
          ((and (not bpos?) (not cpos?) dpos?) (make-interval (* a d) (* a c)))
          ((and apos? bpos? (not dpos?)) (make-interval (* b c) (* a c)))
          (else (let ((p1 (* a c))
                      (p2 (* a d))
                      (p3 (* b c))
                      (p4 (* b d)))
                  (make-interval (min p2 p3)
                                 (max p1 p4)))))))

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

(define (make-interval a b)
  (if (<= a b)
      (cons a b)
      (error "upper-bound must be larger than lower-bound")))

(define (upper-bound x) (cdr x))

(define (lower-bound x) (car x))

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (make-center-percent c p)
  (make-center-width c (* (abs c) (/ p 100))))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (percent i)
  (* 100 (/ (width-interval i) (center i))))

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))
(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval
     one (add-interval (div-interval one r1)
                       (div-interval one r2)))))

(let ((a (make-center-percent 50.0 1))
      (b (make-center-percent 50.0 1)))
  (print-interval a)
  (display (percent a))
  (newline)
  (print-interval b)
  (display (percent b))
  (newline)(newline)
  
  (print-interval (par1 a b))
  (display (center (par1 a b)))
  (newline)
  (display (percent (par1 a b)))
  (newline)(newline)
  
  (print-interval (par2 a b))
  (display (center (par2 a b)))
  (newline)
  (display (percent (par2 a b)))
  (newline)(newline)

  (print-interval (div-interval a a))
  (display (center (div-interval a a)))
  (newline)
  (display (percent (div-interval a a)))
  (newline)(newline)
  
  (print-interval (div-interval a b))
  (display (center (div-interval a b)))
  (newline)
  (display (percent (div-interval a b))))

#|
Lem is right
More importantly it looks like the center of a/a is not 1 but an approximation of it
|#