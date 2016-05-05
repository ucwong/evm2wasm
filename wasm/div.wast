(module
  (func $div
    (param $a i64)
    (local $b i64)
    (param $c i64)
    (local $d i64)
    (param $e i64)
    (local $f i64)
    (param $g i64)
    (local $h i64)

    (param $i i64)
    (local $j i64)
    (param $k i64)
    (local $l i64)
    (param $m i64)
    (local $n i64)
    (param $o i64)
    (local $p i64)

    (local $r0 i64)
    (local $r1 i64)
    (local $r2 i64)
    (local $r3 i64)
    (local $r4 i64)
    (local $r5 i64)
    (local $r6 i64)
    (local $r7 i64)

    ;; split the ops
    (set_local $a (i64.and (get_local $a) (i64.const 4294967295)))
    (set_local $b (i64.shl (get_local $a) (i64.const 32))) 
    (set_local $c (i64.and (get_local $c) (i64.const 4294967295)))
    (set_local $d (i64.shl (get_local $c) (i64.const 32))) 
    (set_local $e (i64.and (get_local $e) (i64.const 4294967295)))
    (set_local $f (i64.shl (get_local $e) (i64.const 32)))
    (set_local $g (i64.and (get_local $g) (i64.const 4294967295)))
    (set_local $h (i64.shl (get_local $g) (i64.const 32)))

    (set_local $i (i64.and (get_local $i) (i64.const 4294967295)))
    (set_local $j (i64.shl (get_local $i) (i64.const 32))) 
    (set_local $k (i64.and (get_local $k) (i64.const 4294967295)))
    (set_local $l (i64.shl (get_local $k) (i64.const 32))) 
    (set_local $m (i64.and (get_local $m) (i64.const 4294967295)))
    (set_local $n (i64.shl (get_local $m) (i64.const 32)))
    (set_local $o (i64.and (get_local $o) (i64.const 4294967295)))
    (set_local $p (i64.shl (get_local $o) (i64.const 32)))

    ;; first row multiplication 
    ;; p * h
    (set_local $r7 (i64.mul (get_local $p) (get_local $h)))
    ;; p * g + carry
    (set_local $r6  (i64.add (i64.mul (get_local $p) (get_local $g)) (i64.shl (get_local $r7) (i64.const 32))))
    ;; p * f + carry
    (set_local $r5  (i64.add (i64.mul (get_local $p) (get_local $f)) (i64.shl (get_local $r6) (i64.const 32))))
    ;; p * e + carry
    (set_local $r4  (i64.add (i64.mul (get_local $p) (get_local $e)) (i64.shl (get_local $r5) (i64.const 32))))
    ;; p * d + carry
    (set_local $r3  (i64.add (i64.mul (get_local $p) (get_local $d)) (i64.shl (get_local $r4) (i64.const 32))))
    ;; p * c + carry
    (set_local $r2  (i64.add (i64.mul (get_local $p) (get_local $c)) (i64.shl (get_local $r3) (i64.const 32))))
    ;; p * b + carry
    (set_local $r1  (i64.add (i64.mul (get_local $p) (get_local $b)) (i64.shl (get_local $r2) (i64.const 32))))
    ;; p * a + carry
    (set_local $r0  (i64.add (i64.mul (get_local $p) (get_local $a)) (i64.shl (get_local $r1) (i64.const 32))))

    ;; second row
    ;; o * h + $r6 (pg)
    (set_local $r6 (i64.add (i64.mul (get_local $o) (get_local $h)) (i64.and (get_local $r6) (i64.const 4294967295))))
    ;; o * g + $r5 (pf) + carry
    (set_local $r5 (i64.add (i64.add (i64.mul (get_local $o) (get_local $g)) (i64.and (get_local $r5) (i64.const 4294967295))) (i64.shl (get_local $r6) (i64.const 32))))
    ;; o * f + $r4 (pe) + carry
    (set_local $r4 (i64.add (i64.add (i64.mul (get_local $o) (get_local $f)) (i64.and (get_local $r4) (i64.const 4294967295))) (i64.shl (get_local $r5) (i64.const 32))))
    ;; o * e + $r3 (pd) + carry
    (set_local $r3 (i64.add (i64.add (i64.mul (get_local $o) (get_local $e)) (i64.and (get_local $r3) (i64.const 4294967295))) (i64.shl (get_local $r4) (i64.const 32))))
    ;; o * d + $r2 (pc) + carry
    (set_local $r3 (i64.add (i64.add (i64.mul (get_local $o) (get_local $d)) (i64.and (get_local $r2) (i64.const 4294967295))) (i64.shl (get_local $r3) (i64.const 32))))
    ;; o * c + $r1 (pb) + carry
    (set_local $r2 (i64.add (i64.add (i64.mul (get_local $o) (get_local $c)) (i64.and (get_local $r1) (i64.const 4294967295))) (i64.shl (get_local $r2) (i64.const 32))))
    ;; o * b + $r0 (pa) + carry
    (set_local $r1 (i64.add (i64.add (i64.mul (get_local $o) (get_local $b)) (i64.and (get_local $r0) (i64.const 4294967295))) (i64.shl (get_local $r1) (i64.const 32))))

    ;; third row - n
    ;; n * h + $r5 (og)
    (set_local $r5 (i64.add (i64.mul (get_local $n) (get_local $h)) (i64.and (get_local $r5) (i64.const 4294967295))))
    ;; n * g + $r4 (of) + carry
    (set_local $r4 (i64.add (i64.add (i64.mul (get_local $n) (get_local $g)) (i64.and (get_local $r4) (i64.const 4294967295))) (i64.shl (get_local $r5) (i64.const 32))))
    ;; n * f + $r3 (oe) + carry
    (set_local $r3 (i64.add (i64.add (i64.mul (get_local $n) (get_local $f)) (i64.and (get_local $r3) (i64.const 4294967295))) (i64.shl (get_local $r4) (i64.const 32))))
    ;; n * e + $r2 (od) + carry
    (set_local $r2 (i64.add (i64.add (i64.mul (get_local $o) (get_local $e)) (i64.and (get_local $r2) (i64.const 4294967295))) (i64.shl (get_local $r3) (i64.const 32))))
    ;; n * d + $r1 (oc) + carry
    (set_local $r1 (i64.add (i64.add (i64.mul (get_local $o) (get_local $d)) (i64.and (get_local $r1) (i64.const 4294967295))) (i64.shl (get_local $r2) (i64.const 32))))
    ;; n * c + $r0 (ob) + carry
    (set_local $r0 (i64.add (i64.add (i64.mul (get_local $o) (get_local $c)) (i64.and (get_local $r0) (i64.const 4294967295))) (i64.shl (get_local $r1) (i64.const 32))))

    ;; forth row ---- TODO
    ;; m * h + $r4 (ng)
    (set_local $r4 (i64.add (i64.mul (get_local $o) (get_local $h)) (i64.and (get_local $r4) (i64.const 4294967295))))
    ;; m * g + $r3 (nf) + carry
    (set_local $r3 (i64.add (i64.add (i64.mul (get_local $o) (get_local $g)) (i64.and (get_local $r3) (i64.const 4294967295))) (i64.shl (get_local $r4) (i64.const 32))))
    ;; m * f + $r2 (oe) + carry
    (set_local $r2 (i64.add (i64.add (i64.mul (get_local $o) (get_local $f)) (i64.and (get_local $r2) (i64.const 4294967295))) (i64.shl (get_local $r3) (i64.const 32))))
    ;; m * e + $r1 (od) + carry
    (set_local $r1 (i64.add (i64.add (i64.mul (get_local $o) (get_local $e)) (i64.and (get_local $r1) (i64.const 4294967295))) (i64.shl (get_local $r2) (i64.const 32))))
    ;; m * d + $r0 (oc) + carry
    (set_local $r0 (i64.add (i64.add (i64.mul (get_local $o) (get_local $d)) (i64.and (get_local $r0) (i64.const 4294967295))) (i64.shl (get_local $r1) (i64.const 32))))

    ;; fith row ---- TODO
    ;; l * h + $r3 (ng)
    (set_local $r3 (i64.add (i64.mul (get_local $o) (get_local $h)) (i64.and (get_local $r3) (i64.const 4294967295))))
    ;; l * g + $r2 (nf) + carry
    (set_local $r2 (i64.add (i64.add (i64.mul (get_local $o) (get_local $g)) (i64.and (get_local $r2) (i64.const 4294967295))) (i64.shl (get_local $r3) (i64.const 32))))
    ;; l * f + $r1 (oe) + carry
    (set_local $r1 (i64.add (i64.add (i64.mul (get_local $o) (get_local $f)) (i64.and (get_local $r1) (i64.const 4294967295))) (i64.shl (get_local $r2) (i64.const 32))))
    ;; l * e + $r0 (od) + carry
    (set_local $r0 (i64.add (i64.add (i64.mul (get_local $o) (get_local $e)) (i64.and (get_local $r0) (i64.const 4294967295))) (i64.shl (get_local $r1) (i64.const 32))))

    ;; sixth row ---- TODO
    ;; k * h + $r2 (ng)
    (set_local $r2 (i64.add (i64.mul (get_local $o) (get_local $h)) (i64.and (get_local $r2) (i64.const 4294967295))))
    ;; k * g + $r1 (nf) + carry
    (set_local $r1 (i64.add (i64.add (i64.mul (get_local $o) (get_local $g)) (i64.and (get_local $r1) (i64.const 4294967295))) (i64.shl (get_local $r2) (i64.const 32))))
    ;; k * f + $r0 (oe) + carry
    (set_local $r0 (i64.add (i64.add (i64.mul (get_local $o) (get_local $f)) (i64.and (get_local $r0) (i64.const 4294967295))) (i64.shl (get_local $r1) (i64.const 32))))

    ;; seventh row ---- TODO
    ;; j * h + $r1 (ng)
    (set_local $r1 (i64.add (i64.mul (get_local $o) (get_local $h)) (i64.and (get_local $r1) (i64.const 4294967295))))
    ;; j * g + $r0 (nf) + carry
    (set_local $r0 (i64.add (i64.add (i64.mul (get_local $o) (get_local $g)) (i64.and (get_local $r0) (i64.const 4294967295))) (i64.shl (get_local $r1) (i64.const 32))))

    ;; eigth row ---- TODO
    ;; i * h + $r0 (jg)
    (set_local $r0 (i64.add (i64.mul (get_local $j) (get_local $h)) (i64.and (get_local $r0) (i64.const 4294967295))))

    ;; combine terms
    (set_local $r0 (i64.and (i64.shl (get_local $r0) (i64.const 32) (i64.and (get_local $r1) (i64.const 4294967295)))))
    (set_local $r1 (i64.and (i64.shl (get_local $r2) (i64.const 32) (i64.and (get_local $r3) (i64.const 4294967295)))))
    (set_local $r2 (i64.and (i64.shl (get_local $r4) (i64.const 32) (i64.and (get_local $r5) (i64.const 4294967295)))))
    (set_local $r3 (i64.and (i64.shl (get_local $r6) (i64.const 32) (i64.and (get_local $r7) (i64.const 4294967295)))))
  )
  (export $mul)
)

(assert_test $add((i64.const 1) (i64.const 2) (i64.const 3) (i64.const 4) (i32.const 0)))
(assert_test $add((i64.const 1) (i64.const 2) (i64.const 3) (i64.const 4) (i32.const 1)))
(assert_test $add((i64.const 1) (i64.const 2) (i64.const 3) (i64.const 4) (i32.const 2)))
(assert_test $add((i64.const 1) (i64.const 2) (i64.const 3) (i64.const 4) (i32.const 3)))
