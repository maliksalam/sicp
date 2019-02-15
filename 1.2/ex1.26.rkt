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
         (remainder (* (expmod base (/ exp 2) m)
                       (expmod base (/ exp 2) m))
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
1009 *** 1397.94921875 microseconds
1013 *** 1024.90234375 microseconds
1019 *** 1732.91015625 microseconds
DONE
10007 *** 15506.103515625 microseconds
10009 *** 13998.046875 microseconds
10037 *** 12606.201171875 microseconds
DONE
100003 *** 132764.16015625 microseconds
100019 *** 152427.978515625 microseconds
100043 *** 163870.1171875 microseconds
DONE
1000003 *** 1171300.048828125 microseconds
1000033 *** 1200498.046875 microseconds
1000037 *** 1150447.998046875 microseconds
DONE

This is quite a bit slower. it basically nests two exmod calls that will each get evaluated in
applicative order instead of ust one. This doesn't just double the number of of calls to expmod
but changes a linearly recursive process to a tree recursive one. This means the number of calls
grows exponentially ( O(log exp n) = O(n))
|#