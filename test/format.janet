(use ../deps/testament)

(import ../lib/format :as f)

(deftest atoms
  (is (== "37.5" (f/value->source 37.5 "")))
  (is (== ":foo" (f/value->source :foo "")))
  (is (== "\"hi\"" (f/value->source "hi" "")))
  (is (== "true" (f/value->source true "")))
  (is (== "nil" (f/value->source nil ""))))

(deftest collections
  (is (== "[1\n 2\n 3]" (f/value->source [1 2 3] "")))
  (is (== "@[1\n  2]" (f/value->source @[1 2] "")))
  (is (== "{:a 1}" (f/value->source {:a 1} ""))))

(deftest nested-alignment
  (is (== "{:foo {:bar :baz\n       :qux true}}"
          (f/value->source {:foo {:bar :baz :qux true}} ""))))

(deftest indent-applied
  (is (== "{:a 1\n    :b 2}" (f/value->source {:a 1 :b 2} "   "))))

(deftest key-order-hook
  (defn name-first [d] (sort-by (fn [[k]] [(not= k :name) k]) (pairs d)))
  (is (== "{:name \"x\"\n :tag \"t\"\n :url \"u\"}"
          (f/value->source {:url "u" :name "x" :tag "t"} "" :key-order name-first))))

(deftest rejects-functions
  (assert-thrown (f/value->source print "")))

(run-tests!)
