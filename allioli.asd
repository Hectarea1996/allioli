

(defsystem "allioli"
  :depends-on ("named-readtables")
  :components ((:file "package")
               (:file "allioli")))


(defsystem "allioli/docs"
  :defsystem-depends-on ("adp-github")
  :build-operation "adp-github-op"
  :depends-on ("allioli")
  :components ((:scribble "README")))
