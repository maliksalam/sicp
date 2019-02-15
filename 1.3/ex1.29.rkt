#lang racket
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (inc n) (+ n 1))
(define (cube n) (* n n n))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

(define (simpson-integral f a b n)
  (define h (/ (- b a) n))
  (define (even? x) (= (remainder x 2) 0))
  (define (y k)
    (f (+ a (* k h))))
  (define (sim-term k)
    (* (cond ((or (= k 0) (= k n)) 1)
             ((even? k) 2)
             (else 4))
       (y k)))
  (define (sim-next k)
    (+ k 1))
  (* (sum sim-term 0 sim-next n) (/ h 3.0)))

(integral cube 0 1 0.01)

(integral cube 0 1 0.0001)

(simpson-integral cube 0 1 100)

(simpson-integral cube 0 1 1000)