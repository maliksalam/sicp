#lang racket

(define (rm-square-check x m)
  (if (and (not (or (= x 1) (= x (- m 1))))
           (= (remainder (* x x) m) 1))
      0
      (remainder (* x x) m)))

      
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (rm-square-check (expmod base (/ exp 2) m) m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (miller-rabin-test n)
  (define (try-it a)
    (= (expmod a (- n 1) n) 1))
  (try-it (+ 2 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((miller-rabin-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (even? x)
  (= 0 (remainder x 2)))


(fast-prime? 561 2)
(fast-prime? 1105 2)
(fast-prime? 1729 2)
(fast-prime? 2465 2)
(fast-prime? 2821 2)
(fast-prime? 6601 2)