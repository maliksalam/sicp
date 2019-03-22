#lang racket
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))


(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      null
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))


(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (transpose mat)
  (accumulate-n cons null mat))

(define (matrix-*-vector m v)
  (map (lambda (row) (dot-product v row)) m))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row) (matrix-*-vector cols row)) m)))

(define m '((1 2 3) (4 5 6) (7 8 9)))
(define v '(1 2 3))
(matrix-*-vector m v)
(transpose m)
(matrix-*-matrix m m)

(define a (list (list 14 9 3) (list 2 11 15) (list 0 12 17) (list 5 2 3)))
(define b (list (list 12 25) (list 9 10) (list 8 5)))
(matrix-*-matrix a b)