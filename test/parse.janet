(use ../deps/testament)

(import ../lib/parse :as p)

(deftest round-trip
  (def cases
    ["(+ 1 2)"
     "[:a :b :c]"
     "@{:x 1 :y 2}"
     "{:a {:b [1 2 3]}}"
     "@(a b) @[1 2]"
     "#! shebang\n(foo)\n"
     "# a comment\n(foo)"
     "~(a ,b ;c 'd)"
     "|(+ $ 1)"
     "\"a string\\n\""
     "@\"a buffer\""
     "``a\nlong\nstring``"
     "1_000 0xff 2r101 3.14 1e2 -8:s"
     ":keyword some-symbol nil true false"
     "  \n\t\r\n "])
  (each src cases
    (is (= src (p/generate (p/parse src))) src)))

(deftest node-shape
  (def t (p/parse "(+ 1)"))
  (is (== :code (get t 0)))
  (is (== :tuple (get-in t [1 0])))
  (is (== :symbol (get-in t [1 1 0])))
  (is (== "+" (get-in t [1 1 1])))
  (is (== :whitespace (get-in t [1 2 0])))
  (is (== :number (get-in t [1 3 0])))
  (is (== "1" (get-in t [1 3 1]))))

(deftest atom-nodes-are-type-and-text-only
  (def kw (get (p/parse ":foo") 1))
  (is (== :keyword (get kw 0)))
  (is (== ":foo" (get kw 1)))
  (is (== 2 (length kw))))

(deftest generate-from-built-nodes
  (is (== ":a" (p/generate [:keyword ":a"])))
  (is (== "[:a :b]" (p/generate [:bracket-tuple
                                 [:keyword ":a"]
                                 [:whitespace " "]
                                 [:keyword ":b"]])))
  (is (== "@{:x 1}" (p/generate [:table
                                 [:keyword ":x"]
                                 [:whitespace " "]
                                 [:number "1"]]))))

(deftest comments-and-whitespace-preserved
  (def src "(a   b\n  # a comment\n  c)")
  (is (= src (p/generate (p/parse src)))))

(run-tests!)
