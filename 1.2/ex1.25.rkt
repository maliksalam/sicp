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

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (sqr (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (expmod base exp m)
  (remainder (fast-expt base exp) m))

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
1009 *** 117.919921875 microseconds
1013 *** 131.8359375 microseconds
1019 *** 202.880859375 microseconds
DONE
10007 *** 598809.814453125 microseconds
10009 *** 3745.849609375 microseconds
10037 *** 4335.9375 microseconds
DONE
100003 *** 1331716.064453125 microseconds
100019 *** 504990.966796875 microseconds
100043 *** 307118.1640625 microseconds
DONE
1000003 *** 8429861.083984375 microseconds
1000033 *** 7534075.927734375 microseconds
1000037 *** 8142317.87109375 microseconds
DONE

This procedure crawls especially at higher numbers which is surpirsing
this is because we end up having to exponentiate a random number by a very large one (espcially
towards the end) our initial expmod keeps things manageable purely in terms of the arithmetic.
it never acutally makes successive computations on numbers much larger than the number we are
testing by successively getting the remainder (instead of computing the a^n first which is very
large and then taking the remainder)
|#