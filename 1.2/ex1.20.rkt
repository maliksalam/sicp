#lang racket
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))


#|
Normal Order:
(gcd 206 40)
(gcd 40 (remainder 206 40))
eval -> (= 0 (remainder 206 40)) 2 (1 remainder)
(gcd (remainder 206 40) (remainder 40 (remainder 206 40)))
eval -> (= 0 (remainder 40 (remainder 206 40))) (2 remainder)
(gcd (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
eval -> (= 0 (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) (4 remainder)
(gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
eval -> (= 0 (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))) (7 remainder)
eval -> (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (4 remainder)
Total: 18 remainder calls

Applicative Order:
(gcd 206 40)
(gcd 40 (remainder 206 40))
(gcd 40 6)
(gcd 6 (remainder 40 6))
(gcd 6 4)
(gcd 4 (remainder 6 4))
(gcd 4 2)
(gcd 2 (remainder 4 2))
(gcd 2 0)
2
Total: 4 remainder calls
|#
