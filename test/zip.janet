(use ../deps/testament)

(import ../lib/parse :as p)
(import ../lib/zip :as z)

(deftest navigation-and-value
  (def z0 (z/zip (p/parse "[:a :b :c]")))
  (is (z/root? z0))
  (def bt (z/down z0))
  (is (== :bracket-tuple (first (z/node bt))))
  (is (z/branch? bt))
  (def a (z/down-skip bt))
  (is (not (z/branch? a)))
  (is (== :a (z/value a)))
  (is (== :b (z/value (z/right-skip a))))
  (is (== :c (z/value (z/right-skip (z/right-skip a)))))
  (is (nil? (z/right-skip (z/right-skip (z/right-skip a)))))
  (is (== :b (z/value (z/left-skip (z/right-skip (z/right-skip a)))))))

(deftest up-and-root
  (def a (-> (z/zip (p/parse "[:a :b]")) z/down z/down-skip))
  (is (== :bracket-tuple (first (z/node (z/up a)))))
  (is (z/root? (-> a z/up z/up)))
  (is (== :code (first (z/root (-> a z/up z/up))))))

(deftest leftmost-and-rightmost
  (def a (-> (z/zip (p/parse "[:a :b :c]")) z/down z/down-skip))
  (is (== :c (z/value (z/rightmost a))))
  (is (== :a (z/value (-> a z/rightmost z/leftmost)))))

(deftest sibling-edits
  (def a (-> (z/zip (p/parse "[:a :b :c]")) z/down z/down-skip))
  (is (== "[:x :b :c]" (p/generate (z/root (z/replace a [:keyword ":x"])))))
  (is (== "[:a:z :b :c]" (p/generate (z/root (z/insert-right a [:keyword ":z"])))))
  (is (== "[:z:a :b :c]" (p/generate (z/root (z/insert-left a [:keyword ":z"])))))
  (is (== "[:a  :c]" (p/generate (z/root (z/remove (z/right-skip a)))))))

(deftest child-edits
  (def bt (-> (z/zip (p/parse "[:a]")) z/down))
  (is (== "[:a:z]" (p/generate (z/root (z/append-child bt [:keyword ":z"])))))
  (is (== "[:z:a]" (p/generate (z/root (z/insert-child bt [:keyword ":z"])))))
  (is (== 1 (length (z/children bt)))))

(deftest edit-with-function
  (def n (-> (z/zip (p/parse "[1 2]")) z/down z/down-skip))
  (defn bump [node] [:number (string (inc (scan-number (get node 1))))])
  (is (== "[2 2]" (p/generate (z/root (z/edit n bump))))))

(deftest depth-first-walk
  (def z0 (z/zip (p/parse "[:a]")))
  (is (== :bracket-tuple (first (z/node (z/df-next z0)))))
  (is (== :a (z/value (z/df-next (z/df-next z0))))))

(deftest state-is-an-immutable-struct
  (is (struct? (z/state (-> (z/zip (p/parse "[:a]")) z/down))))
  (is (empty? (z/state (z/zip (p/parse "[:a]"))))))

(deftest errors-at-root
  (assert-thrown (z/remove (z/zip (p/parse "[:a]"))))
  (assert-thrown (z/insert-right (z/zip (p/parse "[:a]")) [:keyword ":z"])))

(deftest column-of-original-nodes
  (def top (z/down (z/zip (p/parse "@{:name \"x\"\n  :deps []}"))))
  (is (== 1 (z/column-of top)))
  (is (== 3 (z/column-of (z/down-skip top))))
  (is (== 3 (z/column-of (-> top z/down-skip z/right-skip z/right-skip)))))

(deftest column-of-inserted-nodes
  (def a (-> (z/zip (p/parse "[:a :b]")) z/down z/down-skip))
  (def ins (-> a (z/insert-right [:keyword ":xx"]) z/right))
  (is (== 4 (z/column-of ins))))

(deftest untouched-round-trip
  (def src "{:a {:b [1 2 3]}\n # c\n :d \"e\"}")
  (is (= src (p/generate (z/root (z/zip (p/parse src)))))))

(run-tests!)
