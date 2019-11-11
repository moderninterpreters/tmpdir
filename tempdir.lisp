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
  `(let ((,name (mkdtemp ,@args)))
     (unwind-protect
          (progn
            ,@body*)
       (uiop:delete-directory-tree ,name :validate t))))
