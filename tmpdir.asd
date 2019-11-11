(defsystem "tmpdir"
  :description "Simple library to create temporary directories"
  :author "Arnold Noronha <arnold@jipr.io>"
  :license  "MIT license"
  :version "0.0.1"
  :serial t
  :depends-on (:uiop)
  :components ((:file "package")
               (:file "tmpdir")))
