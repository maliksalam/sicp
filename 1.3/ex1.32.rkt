#lang racket
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
         (accumulate combiner null-value term (next a) next b))))

(define (accumulate-iter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))
  (iter a null-value))

(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (product term a next b)
  (accumulate * 1 term a next b))

(define (sum-iter term a next b)
  (accumulate-iter + 0 term a next b))

(define (product-iter term a next b)
  (accumulate-iter * 1 term a next b))

(define (identity x) x)
(define (inc x) (+ x 1))

(define (sum-integers a b)
  (sum identity a inc b))

(define (factorial x)
  (product identity 1 inc x))

(define (sum-integers-iter a b)
  (sum-iter identity a inc b))

(define (factorial-iter x)
  (product-iter identity 1 inc x))

(sum-integers 1 10)
(factorial 3)

(sum-integers-iter 1 10)
(factorial-iter 3)