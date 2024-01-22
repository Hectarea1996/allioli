
(in-package #:allioli)


(defvar *arg-table* nil
  "Hash table of arguments.")

(defvar *lambda-arguments* nil
  "Vector of arguments stored in order of appearence.")


(defun arg-type (datum)
  "If DATUM is a symbol it can return the keywords :simple or :complex depending on its name. If the name is \"?\", then :simple is returned, otherwise, :complex. In the rest of cases NIL is returned."
  (cond
    ((and (symbolp datum)
          (char= (aref (symbol-name datum) 0) #\?))
     (if (string= (symbol-name datum) "?")
         :simple
         :complex))
    (t nil)))


(defun ensure-argument (argname)
  "Return from a table a symbol associated with a name. The same symbol is always returned for the same name.
A new symbol with the name ARGNAME is created if there was not a symbol associated with ARGNAME."
  (multiple-value-bind (arg presentp) (gethash argname *arg-table*)
    (cond
      (presentp
       arg)
      (t
       (let ((newarg (make-symbol argname)))
         (setf (gethash argname *arg-table*) newarg)
         (vector-push-extend newarg *lambda-arguments*)
         newarg)))))


(defun process-datum (datum)
  "Process a datum. If it is an ARG-TYPE, then a new uninterned symbol is returned. Otherwise the datum is 
returned."
  (case (arg-type datum)
    (:simple (ensure-argument (symbol-name (gensym "?"))))
    (:complex (ensure-argument (symbol-name datum)))
    (t datum)))


(defun process-form (form)
  "Returns a processed form substituting ARG-TYPEs."
  (cond
    ((consp form)
     (cons (process-form (car form)) (process-form (cdr form))))
    (t (process-datum form))))


(defun allioli (form)
  "Creates a function that will call FORM and will receive as many arguments as symbols whose name starts
with '?'. Each time a symbol named '?' is encountered, a new argument will be received. If the name is longer but
starts with '?', then a new argument will be received but can be used several times and only one additional 
argument will be received and no more."
  (let* ((*arg-table* (make-hash-table :test 'equal))
         (*lambda-arguments* (make-array 3 :fill-pointer 0 :adjustable t))
         (processed-form (process-form form)))
    `(lambda (,@(coerce *lambda-arguments* 'list))
       ,processed-form)))


(defun read-allioli (s c n)
  "Reads the next form of a stream and returns the form processed by ALLIOLI."
  (declare (ignore c n))
  (allioli (read s)))


(named-readtables:defreadtable syntax
  (:merge :common-lisp)
  (:dispatch-macro-char #\# #\¿ #'read-allioli))
