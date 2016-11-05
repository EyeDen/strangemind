; Helper functions which teams require:

(defun k-permutations-with-repetition (n-list k)
  (cond ((equal 0 k) (list nil))
        ((null n-list) nil)
        ((null (cdr n-list)) (list n-list))
        (t (loop for element in n-list
             append (mapcar (lambda (l) (cons element l))
                            (k-permutations-with-repetition n-list (- k 1)))))))

(defun my-color-counter (colors list)
  (loop with tally = (make-array (length colors) :initial-element 0)
     for peg in list
     for index = (spot peg)
     do (incf (aref tally index))
     finally (return tally)))

(defun my-process-guess (colors answer guess)
  (loop
     with guess-color-count = (my-color-counter colors guess)
     with true-color-count = (my-color-counter colors answer)
     with exact-counter = 0
     for entry in guess
     for peg in answer
     for exact = (equal entry peg)
     when exact 
     do (incf exact-counter)
     and do (decf (aref guess-color-count (spot entry)))
     and do (decf (aref true-color-count (spot entry)))
     finally (return (list exact-counter (loop for i from 0 to (1- (length colors))))
              for guessed = (aref true-color-count i)
              for true = (aref guess-color-count i)
              when (<= true guessed)
              sum true
              else sum guessed)))

; Usage:
; (setf *random-state* (make-random-state t))
; (print (pick-with-probability '((a 0.45) (b 0.10) (c 0.15) (d 0.30))))
(defun pick-with-probability (items-with-probabilties)
  "Weighted random choice from a list of tuples (item probability)"
  (let ((random-number (random 1.0)))
    (loop
      for tuple in items-with-probabilties
      for probability = (second tuple)
      summing probability into running-sum
      ; do (format t "~%sum so far: ~a" running-sum)
      ; do (format t "~%random: ~a" random-number)
      when (>= running-sum random-number)
      do (return-from pick-with-probability (first tuple)))))