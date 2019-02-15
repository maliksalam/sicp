#lang racket
(define (timed-prime-test n)
  (start-prime-test n (current-inexact-milliseconds)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime n (- (current-inexact-milliseconds) start-time))
       #f))

(define (report-prime n elapsed-time)
  (display n)
  (display " *** ")
  (display (* 1000 elapsed-time))
  (display " microseconds")
  (newline))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (sqr test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (next number)
  (if (= number 2)
      3
      (+ number 2)))

         
(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (even? x)
  (= 0 (remainder x 2)))

(define (search-for-primes y m)
  (if (> m 0)
      (cond ((even? y) (search-for-primes (+ 1 y) m))
            ((timed-prime-test y)
             (search-for-primes (+ y 2) (- m 1)))
            (else (search-for-primes (+ y 2) m)))
      (display "DONE\n")))

(search-for-primes 10000 3)
(search-for-primes 100000 3)
(search-for-primes 1000000 3)

#|
10007 *** 8.056640625 microseconds
10009 *** 8.056640625 microseconds
10037 *** 6.103515625 microseconds
DONE
100003 *** 19.04296875 microseconds
100019 *** 16.11328125 microseconds
100043 *** 64.94140625 microseconds
DONE
1000003 *** 49.8046875 microseconds
1000033 *** 49.072265625 microseconds
1000037 *** 49.072265625 microseconds
DONE

looks like the time is cut down by half as expected. It does seem like the ratio of improvement
increases as the size of the prime number increases (possibly due to more overhead noise at
smaller levels. Performance loss might be attached to the extra (if) that needs to be called in
next
|#