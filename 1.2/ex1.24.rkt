#lang racket
(define (timed-prime-test n)
  (start-prime-test n (current-inexact-milliseconds)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 5)
      (report-prime n (- (current-inexact-milliseconds) start-time))
       #f))

(define (report-prime n elapsed-time)
  (display n)
  (display " *** ")
  (display (* 1000 elapsed-time))
  (display " microseconds")
  (newline))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (sqr (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (even? x)
  (= 0 (remainder x 2)))

(define (search-for-primes y m)
  (if (> m 0)
      (cond ((even? y) (search-for-primes (+ 1 y) m))
            ((timed-prime-test y)
             (search-for-primes (+ y 2) (- m 1)))
            (else (search-for-primes (+ y 2) m)))
      (display "DONE\n")))

(search-for-primes 1000 3)
(search-for-primes 10000 3)
(search-for-primes 100000 3)
(search-for-primes 1000000 3)

#|
We would expect the growth between each steps to be log(10) or ~2.3 let's see how it does:

between 1,000 and 1,000,000 we would expect a log(1,000) or 6.9 order of growth
however, the below looks close to constant. it looks like if you increase the number of tries,
(times parameter in fast-prime?) that relationship seems to hold.
|#