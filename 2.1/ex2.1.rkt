#lang racket
(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))

(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

(define (gcd a b)
  (if (= b 0)
      (abs a)
      (gcd b (remainder a b))))

(define (make-rat n d)
  (let ((s (/ (* n d)
              (abs (* n d))))
        (n (abs n))
        (d (abs d))
        (g (gcd n d)))
    (cons (* s (/ n g)) (/ (abs d) g))))

(define (make-rat-better n d)
  (let ((g (gcd n d)))
    (if (negative? d)
        (cons (/ (* n -1) g) (/ (* d -1) g))
        (cons (/ n g) (/ d g)))))

(define (numer x) (car x))

(define (denom x) (cdr x))

(define (print-rat x)
  (display (numer x))
  (display "/")
  (display (denom x))
  (newline))


(define minus-one-half (make-rat-better -1 2))
(print-rat minus-one-half)
(define one-third (make-rat-better 1 3))
(print-rat (add-rat minus-one-half one-third))