;;; Complete symbols at point using Pymacs.

;;; See pycomplete.py for the Python side of things and a short description
;;; of what to expect.

(require 'pymacs)
(require 'python-mode)

(pymacs-load "pycomplete")

(defun py-complete ()
  (interactive)
  (let ((pymacs-forget-mutability t)) 
    (insert (pycomplete-pycomplete (py-symbol-near-point)
				   (py-find-global-imports)))))

(defun py-find-global-imports ()
  (save-excursion
    (let (first-class-or-def imports)
      (goto-char (point-min))
      (setq first-class-or-def
	    (re-search-forward "^ *\\(def\\|class\\) " nil t))
      (goto-char (point-min))
      (setq imports nil)
      (while (re-search-forward
	      "^\\(import \\|from \\([A-Za-z_][A-Za-z_0-9]*\\) import \\).*"
	      nil t)
	(setq imports (append imports
			      (list (buffer-substring
				     (match-beginning 0)
				     (match-end 0))))))
      imports)))

(defun py-complete-python-dotexpr-begin nil
   (interactive)
     (re-search-backward "[^a-zA-Z_0-9\\.]")
       (forward-char))

    (defun py-complete-python-dotexpr-end nil
       (interactive)
         (re-search-forward "[a-zA-Z_0-9\\.]*"))

    (put 'python-dotexpr 'beginning-op 'py-complete-python-dotexpr-begin)
    (put 'python-dotexpr 'end-op 'py-complete-python-dotexpr-end)

    (defun py-complete-show (string)
       (display-message-or-buffer string "*PythonHelp*"))

    (defun py-complete-help (string)
       "get help on a python expression"
         (let ((help-string
                         (pycomplete-pyhelp string (py-find-global-imports))))
              (if (and help-string (> (length help-string) 300))
                       (with-output-to-temp-buffer "*Python Help*"
                                  (print help-string))
                             (py-complete-show help-string))))

    (defun py-complete-help-thing-at-point nil
       (interactive)
         (require 'thingatpt)
           (let ((sym (thing-at-point 'python-dotexpr)))
                (if sym
                         (py-complete-help sym))))

    (set 'py-complete-current-signature nil)

    (defun py-complete-signature (function)
       "get signature of a python function or method"
         (interactive)
           (set 'py-complete-current-signature
                   (pycomplete-pysignature function)))

    (defun py-complete-signature-show nil
       (interactive)
         (require 'thingatpt)
           (let ((sym (thing-at-point 'python-dotexpr)))
                (if sym
                         (progn
                                    (py-complete-show (py-complete-signature sym))))))

    (defun py-complete-signature-expr nil
       (interactive)
         (require 'thingatpt)
           (let ((dotexpr (read-string "signature on: "
                                                         (thing-at-point 'python-dotexpr))))
                (if dotexpr
                         (py-complete-show
                                   (py-complete-signature dotexpr)))))

    (defun py-complete-electric-lparen nil
       "electricly insert '(', and try to get a signature for the stuff to the left"
         (interactive)
           (py-complete-signature-show)
             (self-insert-command 1))

    (defun py-complete-electric-comma nil
       "electricly insert ',', and redisplay latest signature"
         (interactive)
           (self-insert-command 1)
             (if py-complete-current-signature
                    (py-complete-show (format "%s" py-complete-current-signature))))

(define-key py-mode-map "\M-\C-i" 'py-complete)
(define-key py-mode-map "\t" 'py-complete)
(define-key py-mode-map [f1] 'py-complete-help-thing-at-point)
(define-key py-mode-map "(" 'py-complete-electric-lparen)
(define-key py-mode-map "," 'py-complete-electric-comma)
(define-key py-mode-map [f2] 'py-complete-signature-expr) 

(provide 'pycomplete)
