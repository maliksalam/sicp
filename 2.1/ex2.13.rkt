#lang racket
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

(define (mul-interval x y)
  (let* ((a (lower-bound x))
         (b (upper-bound x))
         (c (lower-bound y))
         (d (upper-bound y))
         (apos? (positive? a))
         (bpos? (positive? b))
         (cpos? (positive? c))
         (dpos? (positive? d)))
    (cond ((and apos? cpos?) (make-interval (* a c) (* b d)))
          ((and (not bpos?) (not dpos?)) (make-interval (* b d) (* a c)))
          ((and (not bpos?) cpos?) (make-interval (* a d) (* b c)))
          ((and apos? (not dpos?)) (make-interval (* b c) (* a d)))
          ((and (not apos?) bpos? cpos?) (make-interval (* a d) (* b d)))
          ((and apos? (not cpos?) dpos?) (make-interval (* b c) (* b d)))
          ((and (not bpos?) (not cpos?) dpos?) (make-interval (* a d) (* a c)))
          ((and apos? bpos? (not dpos?)) (make-interval (* b c) (* a c)))
          (else (let ((p1 (* a c))
                      (p2 (* a d))
                      (p3 (* b c))
                      (p4 (* b d)))
                  (make-interval (min p2 p3)
                                 (max p1 p4)))))))

(define (div-interval x y)
  (if (and (positive? (upper-bound y))
           (negative? (lower-bound y)))
      (error "ERROR: division by an interval spanning 0 is not defined")
      (mul-interval x 
                    (make-interval (/ 1.0 (upper-bound y))
                                   (/ 1.0 (lower-bound y))))))

(define (width-interval i)
  (/ (- (upper-bound i) (lower-bound i))
     2))

(define (print-interval i)
  (display "[")
  (display (lower-bound i))
  (display ", ")
  (display (upper-bound i))
  (display "]")
  (newline))

(define (make-interval a b)
  (if (<= a b)
      (cons a b)
      (error "upper-bound must be larger than lower-bound")))

(define (upper-bound x) (cdr x))

(define (lower-bound x) (car x))

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (make-center-percent c p)
  (make-center-width c (* (abs c) (/ p 100))))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (percent i)
  (* 100 (/ (width-interval i) (center i))))


(let ((a (make-center-percent 5.0 20))
      (b (make-center-percent 10.0 50.0)))
  (print-interval a)
  (display (percent a))
  (newline)
  (print-interval b)
  (display (percent b))
  (newline)
  (print-interval (mul-interval a b))
  (display (percent (mul-interval a b)))
  (newline)
  (display (center (mul-interval a b)))
  (newline)
  (display (+ (percent a) (percent b))))

#|
Proof
x = [a , b]
Let mx be the midpoint of x and tx be the tolerance of x
a = mx - (tx * mx) = mx(1 - tx)
b = mx + (tx * mx) = mx(1 + tx)

y = [c , d]
c = my - (ty * my) = my(1 - ty)
b = my + (ty * my) = my(1 + ty)

x * y = [ac , bd]
ac = mx(1 - tx) my(1 - ty)
bd = mx(1 + tx) my(1 + ty)

ac = mxy - (txy * mxy) = mxy(1 - txy)
bd = mxy + (txy * mxy) = mxy(1 + txy)

mxy = (ac + bd) / 2
txy = ((bd - ac) / 2) / mxy
    = ((bd - ac) / 2) / (ac + bd) / 2
    = (bd - ac) / (ac + bd)
    = (mx(1 + tx) my(1 + ty) - mx(1 - tx) * my(1 - ty)) / (mx(1 - tx) my(1 - ty) + mx(1 + tx) my(1 + ty))
    = (mx*my(1 + ty + tx + tx*ty) - mx*my(1 - ty - tx + txty) / mx*my(1 - ty - tx + tx*ty) + mx*my(1 + ty + tx + tx*ty))
    factoring out the mx*my's and simplifying
    = (1 + ty + tx + tx*ty) - (1 - ty - tx + txty) / (1 - ty - tx + tx*ty) + (1 + ty + tx + tx*ty)
    = 2ty + 2tx / 2 + 2tx*ty
    = (ty + tx) / 1 + tx*ty
subtracting tx + ty from both sides we get
txy - (tx + ty) = ((ty + tx) / 1 + tx*ty) - (tx + ty)
                = (ty + tx - (1 + tx*ty)(tx + ty)) / 1 + tx*ty
                = (ty + tx - tx - ty - tx*tx*ty - tx*ty*ty) / 1 + tx*ty
                = (- tx*tx*ty - tx*ty*ty)/ 1 + tx*ty
                = -tx*ty(tx + ty) / (1 + tx*ty) -> 0 / 1 + 0 = 0 as tx and ty -> 0

mxy = (ac + bd) / 2
    = (mx(1 - tx) my(1 - ty) + mx(1 + tx) my(1 + ty)) / 2
    = mx * my ((1 - tx)(1 - ty) + (1 + tx)(1 + ty)) / 2
    = mx * my (1 - ty - yx + (tx*ty) + 1 + ty + tx + (tx*ty) ) / 2
    = mx * my (2 + 2(tx*ty)) / 2
    = mx * my (1 + (tx*ty)) -> mx * my as tx and ty -> 0

|#
