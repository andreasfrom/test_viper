; Property from "Productive Use of Failure in Inductive Proof",
; Andrew Ireland and Alan Bundy, JAR 1996
(declare-datatypes (a)
  ((list (nil) (cons (head a) (tail (list a))))))
(declare-datatypes () ((Nat (Z) (S (p Nat)))))
(define-fun-rec
  equal
    ((x Nat) (y Nat)) Bool
    (match x
      (case Z
        (match y
          (case Z true)
          (case (S z) false)))
      (case (S x2)
        (match y
          (case Z false)
          (case (S y2) (equal x2 y2))))))
(define-fun-rec
  elem
    ((x Nat) (y (list Nat))) Bool
    (match y
      (case nil false)
      (case (cons z xs) (or (equal x z) (elem x xs)))))
(define-fun-rec
  (par (a)
    (append
       ((x (list a)) (y (list a))) (list a)
       (match x
         (case nil y)
         (case (cons z xs) (cons z (append xs y)))))))
(assert-not
  (forall ((x Nat) (y (list Nat)) (z (list Nat)))
    (=> (elem x y) (=> (elem x z) (elem x (append y z))))))
(check-sat)
