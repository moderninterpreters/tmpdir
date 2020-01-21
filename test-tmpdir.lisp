(defpackage :tmpdir.tests
  (:use :cl
        :tmpdir
        :fiveam)
  (:export))
(in-package :tmpdir.tests)

(test dir-exists-p
  (let (dir-copy)
    (with-tmpdir (dir)
     (setf dir-copy dir)
     (is-true (path:-d dir)))
    (is-false (path:-e dir-copy))))

(test deletes-inside-directory
  (let (test-file)
   (with-tmpdir (dir)
     (setf test-file (path:catfile dir "test.txt"))
     (with-open-file (f test-file :direction :output))
     (is-true (path:-e test-file)))
   (is-false (path:-e test-file))))

(test does-not-follow-symlinks
  (with-tmpdir (outside :prefix "outside")
    (let ((outfile (path:catfile outside "test.txt")))
      (with-open-file (f outfile :direction :output))
      (with-tmpdir (dir :prefix "dir")
        (osicat:make-link (path:catfile dir "test.txt")
                               :target outfile
                               :hard nil))
      (is-true (path:-e outside))
      (is-true (path:-e outfile)))))
