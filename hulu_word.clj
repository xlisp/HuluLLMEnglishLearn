#!/usr/bin/env bb
;; ===>>> Use:  `cat *.md | bb hulu_word.clj | sort` => TODO：写一个LLM应用来帮助你学习英语！
;; 自动分页，然后加上数字上去，打印出来。提交到谷歌翻译上面去翻译，然后返回回来打印 。谷歌插件那里需要是chrome插件操作！

;; === https://blog.labol.co.jp/entry/writing-shell-scripts-with-clojure-using-babashka  <= 谷歌提问：babashka input in shell script 
;;(def *input* (clojure.string/split-lines (slurp "/Users/clojure/aaa.txt")))
;;hulu_word () {
;;	cat *.md | bb -i '(doseq [i (distinct (flatten (map (fn [stri] (filter #(re-find  #"\w" % ) (clojure.string/split stri #"\s|\.|\)|\(|\/|\"|,|\:|\[|;|_|-|@|\*")) ) *input*)))] (println i))' | sort
;;}

(def input_
  (->> (slurp *in*) 
     (clojure.string/split-lines)))

(def knowed-word
  (set
    (map
      clojure.string/lower-case
      (clojure.string/split-lines
        (slurp "/Users/clojure/Documents/_think_different_everday/knowed-word.txt")))))

(def every-word
  (remove
    (fn [w] (knowed-word w))
    (map
      clojure.string/lower-case
      (distinct
        (flatten
          (map
            (fn [stri]
              (filter #(re-find  #"\w" % )
                (clojure.string/split stri #"\s|\.|\)|\(|\/|\"|,|\:|\[|\]|;|_|-|@|\*|：")) ) input_))))))

(doseq [w every-word]
  (println w))
