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
        (else (find-divisor n (+ test-divisor 1)))))

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
10009 *** 10.009765625 microseconds
10037 *** 9.033203125 microseconds
DONE
100003 *** 25.87890625 microseconds
100019 *** 26.123046875 microseconds
100043 *** 26.123046875 microseconds
DONE
1000003 *** 83.984375 microseconds
1000033 *** 83.0078125 microseconds
1000037 *** 83.0078125 microseconds
DONE

The results above seem to bear out that testing for the primality of grows with (sqrt n)
indeed, testing around 10,000 takes about 3 ((sqrt 10) = 3.16) times the time it takes
to test around 100,000 and this relationship holds for 1,000,000.
The strange thing is that the first prime test takes a while longer than the rest.
Even after trying higher and higher numbers, this relationship seems to hold.
This seems to indicate that programs on my machine run in time proportional to the number
of steps required for the computation
|#