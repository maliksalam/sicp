#lang racket
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things) 
              (cons (sqr (car things))
                    answer))))
  (iter items '()))

(square-list (list 1 2 3 4))

#|
What this is doing is progressing through the list and cons-ing the square of the car of the list
and the answer list (initialized as the empty list). This adds the next result to the front of the
list which ends up reversing the list. We can solve this by using append or reversing answer
before returning it.
|#

(define (fd-square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (sqr (car things))))))
  (iter items '()))
(fd-square-list (list 1 2 3 4))

#|
This gives us an even weirder result. Answer is initialized as the empty list, so as we cons the
car of things to it this gives us the pair ('() 1). If we keep going, we are going to keep cons-
ing a pair with the square of the next element which is not how a list is constructed (it is the
reverse in some way) 
|#