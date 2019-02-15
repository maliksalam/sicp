#lang racket
(define (filtered-accumulate combiner null-value term a next b filter)
  (cond ((> a b)
         null-value)
        ((filter a)
         (combiner (term a)
                   (filtered-accumulate combiner null-value term (next a) next b filter)))
        (else (filtered-accumulate combiner null-value term (next a) next b filter))))

(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (sqr test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= (smallest-divisor n) n))

(define (inc x) (+ x 1))

(define (sos-prime a b)
  (filtered-accumulate + 0 sqr a inc b prime?))

(define (gcd a b)
  (define (common-divisor? test-divisor)
    (and (= (remainder a test-divisor) 0)
         (= (remainder b test-divisor) 0)))
  (define (find-gcd test-divisor)
    (cond ((=  test-divisor 1) 1)
          ((common-divisor? test-divisor) test-divisor)
          (else (find-gcd (- test-divisor 1)))))
  (find-gcd (min a b)))

(define (gcd-iter a b)
  (if (= b 0)
      a
      (gcd-iter b (remainder a b))))

(define (rel-prime-prod n)
  (define (identity x) x)
  (define (prime-rel? a)
    (= (gcd-iter a n) 1))
  (filtered-accumulate * 1 identity 1 inc n prime-rel?))

(rel-prime-prod 11)
    
  