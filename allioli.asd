

(defsystem "allioli"
  :author "Héctor Galbis Sanchis"
  :description "Alliolification"
  :license "MIT"
  :depends-on ("named-readtables" "fare-quasiquote-extras")
  :components ((:file "src/package")
               (:module "src"
                :depends-on ("src/package")
                :components ((:file "allioli")))))


;; (defsystem "allioli/docs"
;;   :defsystem-depends-on ("adp-github")
;;   :build-operation "adp-github-op"
;;   :depends-on ("allioli")
;;   :components ((:module "scribble"
;;                 :components ((:scribble "README")))))
