#lang racket
(define (double x)
  (+ x x))

(define (halve x)
  (/ x 2))

(define (even? b)
  (= (remainder b 2) 0))

(define (fast-mult-iter a b c)
  (cond ((< b 0) (- (fast-mult-iter a (- b) c)))
        ((= b 0) c)
        ((even? b) (fast-mult-iter (double a) (halve b) c))
        (else (fast-mult-iter a (- b 1) (+ c a)))))

(define (* a b)
  (if (< a b)
      (fast-mult-iter b a 0)
      (fast-mult-iter a b 0)))