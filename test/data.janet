(use ../deps/testament)

(import ../lib/parser :as p)
(import ../lib/data :as d)

(defn- edit [src f] (p/render (f (p/parse src))))

(deftest get-values
  (def t (p/parse "@{:name \"x\"\n  :deps [{:name \"a\"} {:name \"b\"}]}"))
  (is (== "x" (d/get t [:name])))
  (is (== {:name "a"} (d/get t [:deps 0])))
  (is (== "b" (d/get t [:deps 1 :name])))
  (is (nil? (d/get t [:missing])))
  (is (== :none (d/get t [:missing] :none))))

(deftest put-value
  (is (== "@{:name \"x\"}" (edit "@{:name \"y\"}" (fn [x] (d/put x [:name] "x")))))
  (is (== "{:a 1 :b 9}" (edit "{:a 1 :b 2}" (fn [x] (d/put x [:b] 9))))))

(deftest put-struct-aligns
  (is (== "[{:baz :bar\n  :qux :quux}]"
          (edit "[:bar]" (fn [x] (d/put x [0] {:baz :bar :qux :quux}))))))

(deftest update-value
  (is (== "{:n 2}" (edit "{:n 1}" (fn [x] (d/update x [:n] inc))))))

(deftest add-key-to-dict
  (is (== "@{:name \"x\"\n  :homepage \"h\"}"
          (edit "@{:name \"x\"}" (fn [x] (d/add x [] {:homepage "h"})))))
  (is (== "{:baz :qux}" (edit "{}" (fn [x] (d/add x [] {:baz :qux}))))))

(deftest add-element-to-array
  (is (== "[:a\n :b]" (edit "[:a]" (fn [x] (d/add x [] [:b])))))
  (is (== "[:a]" (edit "[]" (fn [x] (d/add x [] [:a]))))))

(deftest add-into-nested
  (is (== "{:foo {:bar 1}}" (edit "{:foo {}}" (fn [x] (d/add x [:foo] {:bar 1}))))))

(deftest remove-key
  (is (== "{:a 1}" (edit "{:a 1\n :b 2}" (fn [x] (d/remove x [:b])))))
  (is (== "{:b 2}" (edit "{:a 1\n :b 2}" (fn [x] (d/remove x [:a]))))))

(deftest remove-element
  (is (== "[:a]" (edit "[:a :b]" (fn [x] (d/remove x [1])))))
  (is (== "[]" (edit "[:bar]" (fn [x] (d/remove x [0]))))))

(deftest key-order-threads-through
  (defn name-first [dd] (sort-by (fn [[k]] [(not= k :name) k]) (pairs dd)))
  (is (== "@{:deps [{:name \"a\"\n          :url \"u\"}]}"
          (edit "@{:deps []}"
                (fn [x] (d/add x [:deps] [{:url "u" :name "a"}] :key-order name-first))))))

(deftest errors
  (assert-thrown (d/put (p/parse "{:a 1}") [:missing] 9))
  (assert-thrown (d/add (p/parse "{:a 1}") [:a] {:x 1})))

(run-tests!)
