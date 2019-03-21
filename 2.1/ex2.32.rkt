#lang racket
(define (subsets s)
  (if (null? s)
      (list s)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (x) (cons (car s) x))
                          rest)))))

(subsets '(1 2 3 5 6 7))

#|
Working through the substitution below, we can illustrate how this works.
Essentially, recursively, this algorithm joins the first element of a set to the subsets given by the rest of its elements (the
complement of that element in the set)
You keep doing this recursively until you hit an empty list.

(subsets '(1 2))
(append (subsets '(2))
        (map (lambda (x) (cons 1 x))
             (subsets '(2))))

(append (append (subsets '())
                (map (lambda (x) (cons 2 x))
                     (subsets '())))
        (map (lambda (x) (cons 1 x))
             (append (subsets '())
                     (map (lambda (x) (cons 2 x))
                          (subsets '())))))

(append (append '(())
                (map (lambda (x) (cons 2 x))
                     '(())))
        (map (lambda (x) (cons 1 x))
             (append '(())
                     (map (lambda (x) (cons 2 x))
                          '(())))))

(append '(() (2))
        (map (lambda (x) (cons 1 x))
             '(() (2))))

(append '(() (2))
        '((1) (1 2)))

'(() (2) (1) (1 2))

|#