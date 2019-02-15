#lang racket
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (sqr (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fermat-test n a)
  (= (expmod a n n) a))

(define (full-prime? n)
  (define (full-prime?-iter a)
    (cond ((= a n) (display " Satisfied full prime test") (newline))
          ((fermat-test n a) (full-prime?-iter (+ a 1)))
          (else (display " Failed full prime test") (newline))))
  (display n)
  (full-prime?-iter 1))

(full-prime? 561)
(full-prime? 1105)
(full-prime? 1729)
(full-prime? 2465)
(full-prime? 2821)
(full-prime? 6601)