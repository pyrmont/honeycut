(use ../deps/testament)

(import ../init :as h)

(deftest re-exports-the-everyday-api
  (each f [h/parse h/render h/get h/put h/update h/add h/remove]
    (is (function? f))))

(deftest parses-and-renders
  (def src "@{:name \"x\"}")
  (is (== src (h/render (h/parse src)))))

(deftest edits-end-to-end
  (def t (h/parse "@{:name \"x\"}"))
  (is (== "x" (h/get t [:name])))
  (is (== "@{:name \"x\"\n  :version \"1.0.0\"}"
          (h/render (h/add t [] {:version "1.0.0"}))))
  (is (== "@{:name \"y\"}" (h/render (h/put t [:name] "y"))))
  (is (== "@{:name \"x\"}"
          (h/render (h/remove (h/add t [] {:version "1.0.0"}) [:version])))))

(run-tests!)
