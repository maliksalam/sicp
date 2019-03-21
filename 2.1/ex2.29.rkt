#lang racket

;Mobile representation
(define (make-mobile left right)
  (list left right))
(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (car (cdr mobile)))

;Branch Representation
(define (make-branch length structure)
  (list length structure))
(define (branch-length branch)
  (car branch))
(define (branch-structure branch)
  (car (cdr branch)))

#|
pair representation of Mobile and Branch
(define (make-mobile left right)
  (cons left right))
(define (make-branch length structure)
  (cons length structure))
(define (right-branch mobile)
  (cdr mobile))
define (branch-structure branch)
  (cdr branch))
|#

;Total Weight
(define (branch-weight branch)
  (let ((s (branch-structure branch)))
    (if (pair? s)
        (total-weight s)
        s)))
              
(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

;Balance

(define (branch-torque branch)
   (* (branch-length branch)
      (branch-weight branch)))

(define (balanced-branch? branch)
  (let ((s (branch-structure branch)))
    (if (pair? s)
        (balanced-mobile? s)
        #t)))
  
  
(define (balanced-mobile? mobile)
  (let ((lb (left-branch mobile))
        (rb (right-branch mobile)))
    (and (= (branch-torque lb)
            (branch-torque rb))
         (balanced-branch? lb)
         (balanced-branch? rb))))

;tests
(define b1 (make-branch 5 4))
(define b2 (make-branch 2 10))
(define m1 (make-mobile b1 b2))
(define b3 (make-branch 10 m1))
(define m2 (make-mobile b1 b3))
(define m3 (make-mobile b3 b3))

(left-branch m1)
(right-branch m1)
(branch-length b1)
(branch-structure b1)
(branch-length (right-branch m1))
(branch-structure (right-branch m1))
(total-weight m2)
(balanced-mobile? m1)
(balanced-mobile? m3)

(define a (make-mobile (make-branch 2 3) (make-branch 2 3)))
(define b (make-mobile (make-branch 2 3) (make-branch 4 5)))
(define c (make-mobile (make-branch 5 a) (make-branch 3 b)))
(define d (make-mobile (make-branch 10 a) (make-branch 12 5)))
(balanced-mobile? d)

#|
changing from list to cons in make-mobile and make-branch, we can land back on our feet by simply changing our right-branch
branch-structure selectors from (car (cdr x)) to simply (cdr x). The rest can remain exactly the same. This shows the power of
abstraction barriers
|#