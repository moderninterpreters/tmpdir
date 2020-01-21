(in-package :tmpdir)

(defun mkdtemp (&key (parent (uiop:temporary-directory)) prefix suffix )
  ;; this isn't the most efficient way to do it, but it get's the job
  ;; done for V1.
  (uiop:with-temporary-file (:stream unused :pathname name :prefix prefix :suffix suffix :type "tmp")
    (uiop:delete-file-if-exists name)
    (let ((name (pathname (format nil "~a/"(namestring name)))))
      (ensure-directories-exist name)
      name)))

(defmacro with-tmpdir ((name &rest args) &body body*)
  (let ((tmp-name (gensym)))
    `(let ((,tmp-name (mkdtemp ,@args)))
       (let ((,name ,tmp-name)) ;; this let's us do things like (with-tmpdir(*foobar*) ..)
        (unwind-protect
             (progn
               ,@body*)
          ;; workaround bug in cl-fad for lispworks, see
          ;; https://github.com/edicl/cl-fad/pull/30
          (let (#+lispworks
                (system:*directory-link-transparency* nil))
           (fad:delete-directory-and-files ,tmp-name)))))))
