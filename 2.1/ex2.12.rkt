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
  (make-center-width c (* c (/ p 100))))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (percent i)
  (* 100 (/ (width-interval i) (center i))))


(let ((a (make-interval 9.0 11.0))
      (b (make-center-width 10.0 1))
      (c (make-center-percent 10.0 10)))
  (print-interval a)
  (print-interval b)
  (print-interval c)
  (percent c))
