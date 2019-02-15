#lang racket
(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* (term a) result))))
  (iter a 1))

(define (identity x) x)
(define (inc x) (+ x 1))

(define (factorial x)
  (product-iter identity 1 inc x))

(define (even? x)
  (= (remainder x 2) 0))

(define (pi-prod x)
  (define last-term
    (if (even? x)
        x
        (+ x 1)))
  (define (pi-term a)
    (/ (sqr (+ a 1))
       (sqr a)))
  (define (pi-next a)
    (+ a 2))
  (/ (* 2 (product-iter pi-term 3.0 pi-next x)) last-term))
  
  

(* 4 (pi-prod 10001))
(* 4 (pi-prod 10002))
(* 4 (pi-prod 10003))

  