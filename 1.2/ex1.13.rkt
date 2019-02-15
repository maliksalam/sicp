#lang racket
#|
Let's start by following the Hint and proving:
Fib(n) = (o^n - w^n)/sqrt(5)
with:
o = (1 + sqrt(5))/2
w = (1 - sqrt(5))/2

Inductive proof:
Initial Step:
n = 0
by definition, Fib(0) = 0
(o^0 - w^0)/sqrt(5) = (1 - 1)/sqrt(5)
                    = (0)/sqrt(5)
                    = 0
=> Fib(n) = (o^n - w^n)/sqrt(5) is true for n = 0

n = 1
by definition, Fib(1) = 1
(o^1 - w^1)/sqrt(5) = (o - w)/sqrt(5)
                    = ((1 + sqrt(5))/2 - (1 - sqrt(5))/2)/sqrt(5)
                    = (1/2 + sqrt(5)/2 - 1/2 + sqrt(5)/2)/sqrt(5)
                    = (sqrt(5)/2 + sqrt(5)/2)/sqrt(5)
                    = sqrt(5) / sqrt(5)
                    = 1

=> Fib(n) = (o^n - w^n)/sqrt(5) is true for n = 1

Inductive Step:
Assuming Fib(n-1) = (o^n-1 - w^n-1)/sqrt(5)
And      Fib(n) = (o^n - w^n)/sqrt(5)
Prove:   Fib(n+1) = (o^n+1 - w^n+1)/sqrt(5)

by definition:
Fib(n+1) = Fib(n) + Fib(n-1)
         = (o^n - w^n)/sqrt(5) + (o^n-1 - w^n-1)/sqrt(5)
         = [(o^n - w^n) + (o^n-1 - w^n-1)]/sqrt(5)
         = (o * o^n-1 - w * w^n-1 + o^n-1 - w^n-1)/sqrt(5)
         = [o^n-1 * (o + 1) - w^n-1 * (w + 1)]/sqrt(5)
         = [o^n-1 * o^2 - w^n-1 * w^2]/sqrt(5) (because o and w are the roots of equation x^2 = x + 1)
         = [o^n+1 - w^n+1]/sqrt(5)

=> for all n >= 0, Fib(n) = (o^n - w^n)/sqrt(5)
=> Fib(n) = o^n/sqrt(5) - w^n/sqrt(5)
=> o^n/sqrt(5) - Fib(n) = w^n/sqrt(5)
=> |o^n/sqrt(5) - Fib(n)| = |w^n/sqrt(5)|

and w = (1 - sqrt(5))/2 ~= -0.61
=> -1 < w < 1
=> -1 < w^n < 1
=> -1/sqrt(5) < w^n/sqrt(5) < 1/sqrt(5)
=> 0 < |w^n/sqrt(5)| < 1/sqrt(5) (~= 0.45)
=> 0 < |w^n/sqrt(5)| < 1/2
=> 0 < |o^n/sqrt(5) - Fib(n)| < 1/2
within 1/2 of any real number there is only one integer
=> Fib(n) is the closest integer to o^n/sqrt(5)
QED
|#