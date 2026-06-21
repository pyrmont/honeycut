(use ../deps/testament)

(import ../init :as e)

(deftest re-exports-the-everyday-api
  (each f [e/parse e/generate e/get e/put e/update e/add e/remove]
    (is (function? f))))

(deftest parses-and-generates
  (def src "@{:name \"x\"}")
  (is (== src (e/generate (e/parse src)))))

(deftest edits-end-to-end
  (def t (e/parse "@{:name \"x\"}"))
  (is (== "x" (e/get t [:name])))
  (is (== "@{:name \"x\"\n  :version \"1.0.0\"}"
          (e/generate (e/add t [] {:version "1.0.0"}))))
  (is (== "@{:name \"y\"}" (e/generate (e/put t [:name] "y"))))
  (is (== "@{:name \"x\"}"
          (e/generate (e/remove (e/add t [] {:version "1.0.0"}) [:version])))))

(run-tests!)
