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
  (is (== "@{:name \"x\"}" (edit "@{:name \"y\"}" |(d/put $ [:name] "x"))))
  (is (== "{:a 1 :b 9}" (edit "{:a 1 :b 2}" |(d/put $ [:b] 9)))))

(deftest put-struct-aligns
  (is (== "[{:baz :bar\n  :qux :quux}]"
          (edit "[:bar]" |(d/put $ [0] {:baz :bar :qux :quux})))))

(deftest update-value
  (is (== "{:n 2}" (edit "{:n 1}" |(d/update $ [:n] inc)))))

(deftest add-key-to-dict
  (is (== "@{:name \"x\"\n  :homepage \"h\"}"
          (edit "@{:name \"x\"}" |(d/add $ [] {:homepage "h"}))))
  (is (== "{:baz :qux}" (edit "{}" |(d/add $ [] {:baz :qux})))))

(deftest add-element-to-array
  (is (== "[:a\n :b]" (edit "[:a]" |(d/add $ [] [:b]))))
  (is (== "[:a]" (edit "[]" |(d/add $ [] [:a])))))

(deftest add-into-nested
  (is (== "{:foo {:bar 1}}" (edit "{:foo {}}" |(d/add $ [:foo] {:bar 1})))))

(deftest remove-key
  (is (== "{:a 1}" (edit "{:a 1\n :b 2}" |(d/remove $ [:b]))))
  (is (== "{:b 2}" (edit "{:a 1\n :b 2}" |(d/remove $ [:a])))))

(deftest remove-element
  (is (== "[:a]" (edit "[:a :b]" |(d/remove $ [1]))))
  (is (== "[]" (edit "[:bar]" |(d/remove $ [0])))))

(deftest key-order-threads-through
  (defn name-first [dd] (sort-by (fn [[k]] [(not= k :name) k]) (pairs dd)))
  (is (== "@{:deps [{:name \"a\"\n          :url \"u\"}]}"
          (edit "@{:deps []}"
                |(d/add $ [:deps] [{:url "u" :name "a"}] :key-order name-first)))))

(deftest errors
  (assert-thrown (d/put (p/parse "{:a 1}") [:missing] 9))
  (assert-thrown (d/add (p/parse "{:a 1}") [:a] {:x 1})))

(run-tests!)
