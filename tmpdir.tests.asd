(defsystem :tmpdir.tests
  :serial t
  :depends-on (:tmpdir
               :fiveam
               :osicat
               :cl-fad)
  :components ((:file "test-tmpdir")))
