(load (merge-pathnames "../lib/genetic.lisp" *load-truename*))

(subtest "Testing Genetic Algorithm team"
  ; TODO: ensure each individual in initial population contains only valid colors
  ; TODO: ensure each individual in initial population is of the correct length

  (is '(A B C A B) (first-guess 5 '(a b c))
    "First guess should generate the expected first guess")

  (is
    *population-size*
    (length (initial-population 4 '(A B C D E F)))
    "ensure initial population is of size *population-size*"))