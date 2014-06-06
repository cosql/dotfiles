;;;add load path
(setq load-path (cons "~/.emacs.d" load-path))

;;; uncomment this line to disable loading of "default.el" at strtup
;; (setq inhibit-default-init t)

;; enable visual feedback on selections
					;(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")

;; always end a file with a newline
					;(setq require-final-newline 'query)

;;; uncomment for CJK utf-8 support for non-Asian users
;; (require 'un-define)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;GLOBAL;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(menu-bar-mode -1)
(tool-bar-mode -1)
(global-font-lock-mode t)
(transient-mark-mode t);高亮显示要拷贝的区域
(setq x-select-enable-clipboard t);支持emacs和外部程序的粘贴

(global-set-key "\C-z" nil)
					;(global-set-key "\C-z" (lambda()(interactive)  (set 'truncate-partial-width-windows (not truncate-partial-width-windows))))

(setq bookmark-save-flag 1)
					;(setq truncate-partial-width-windows t)
(auto-revert-mode t)
(auto-image-file-mode)

(setq inhibit-startup-message t)
(setq default-major-mode 'text-mode)
(mouse-avoidance-mode 'animate)
(setq frame-title-format "%b@DoraEmon")
(auto-image-file-mode)
(global-font-lock-mode t)
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'LaTeX-hide-environment 'disabled nil)

(setq visible-bell t)

(setq column-number-mode t) 

(display-time)
(transient-mark-mode t)
(show-paren-mode t)
(setq show-paren-style 'parentheses)

(if window-system
    (progn
      (require 'color-theme)
      (color-theme-initialize)
      (color-theme-gnome2)))

(setq kill-ring-max 200)
(fset 'yes-or-no-p 'y-or-n-p)

;;隐藏工具条
					;(tool-bar-mode -1)

;;不要临时文件
					;(setq-default make-backup-files nil)

;;不要滚动栏
(scroll-bar-mode -1)

;;设置编码格式
(prefer-coding-system 'utf-8)

(global-set-key "%" 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
	(t (self-insert-command (or arg 1)))))

;;vim中fx的替代品
(defun wy-go-to-char (n char)
  "Move forward to Nth occurence of CHAR.
 Typing `wy-go-to-char-key' again will move forwad to the next Nth
 occurence of CHAR."
  (interactive "p\ncGo to char: ")
  (search-forward (string char) nil nil n)
  (while (char-equal (read-char)
		     char)
    (search-forward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))
(define-key global-map (kbd "C-c a") 'wy-go-to-char)



;; Always end a file with a newline
(setq require-final-newline t)
;; Stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)

(defconst netbsd-knf-style
  '((c-auto-newline . nil)
    (c-tab-always-indent . nil)
    (c-recognize-knr-p . t)
    (c-basic-offset . 8)
    (c-comment-only-line-offset . 0)
    (c-cleanup-list . (brace-else-brace
		       empty-defun-braces
		       defun-close-semi
		       list-close-comma
		       scope-operator))
    (c-hanging-braces-alist . ((defun-open . (before after))
			       (defun-close . (before))
			       (class-open . (after))
			       (class-close . nil)
			       (inline-open . nil)
			       (inline-close . nil)
			       (block-open . (after))
			       (block-close . (before))
			       (substatement-open . nil)
			       (statement-case-open . nil)
			       (brace-list-open . nil)
			       (brace-list-close . nil)
			       (brace-list-intro . nil)
			       (brace-list-entry . nil)
			       ))
    (c-offsets-alist . ((knr-argdecl-intro . +)
			(arglist-cont-nonempty . 4)
			(knr-argdecl . 0)
			(block-open . -)
			(label . -)
			(statement-cont . 4)
			)))
  "NetBSD KNF Style")

(defun knf-c-mode-hook ()
  ;; Add style and set it for current buffer
  (c-add-style "NetBSD KNF" netbsd-knf-style t)
  ;; Offset customizations that are not in this style (??)
  (c-set-offset 'member-init-intro '++)
  ;; Other stuff
  (setq tab-width 8
	indent-tabs-mode t)
					;(c-toggle-auto-hungry-state 1)
					;(define-key c-mode-map "\C-m" 'newline-and-indent)
  )

(defun my-c++-mode-hook ()
  (setq c-basic-offset 4
	tab-width 4
	indent-tabs-mode nil)
  (let ((bname (buffer-file-name)))
    (cond
     ((string-match "llvm/" bname) (setq indent-tabs-mode nil))
     ))

  ;(define-key c++-mode-map "\C-m" 'reindent-then-newline-and-indent)
  (define-key c++-mode-map "\C-ce" 'c-comment-edit)
  (setq c++-auto-hungry-initial-state 'none)
  (setq c++-delete-function 'backward-delete-char)
  ;(setq c++-tab-always-indent t)
  (setq c-indent-level 4)
  (setq c-continued-statement-offset 4)
  (setq c++-empty-arglist-indent 4))

(add-hook 'c-mode-hook 'knf-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c++-mode-hook)

;; (c-add-style "llvm.org"
;;  '((fill-column . 80)
;; 	 (c++-indent-level . 2)
;; 	 (c-basic-offset . 2)
;; 	 (indent-tabs-mode . nil)
;; 	 (c-offsets-alist . ((innamespace 0)))))

;; (add-hook 'c-mode-hook
;;  (function
;;   (lambda nil 
;;    (if (string-match "llvm" buffer-file-name)
;;     (progn
;;      (c-set-style "llvm.org")
;;     )
;;    ))))

;; (add-hook 'c++-mode-hook
;;  (function
;;   (lambda nil 
;;    (if (string-match "llvm" buffer-file-name)
;;     (progn
;;      (c-set-style "llvm.org")
;;     )
;;    ))))


(global-set-key (kbd "C-?") 'help-command)
(global-set-key (kbd "M-?") 'mark-paragraph)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)

;; Meta
(global-set-key "\M- " 'set-mark-command)
(global-set-key "\M-\C-h" 'backward-kill-word)
(global-set-key "\M-\C-r" 'query-replace)
(global-set-key "\M-r" 'replace-string)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-h" 'help-command)

;; Function keys
(global-set-key [f1] 'manual-entry)
(global-set-key [f2] 'info)
(global-set-key [f3] 'goto-line)
(global-set-key [f4] 'advertised-undo)
(global-set-key [f5] 'eval-current-buffer)
(global-set-key [f6] 'buffer-menu)
(global-set-key [f7] 'other-window)
(global-set-key [f8] 'find-file)
(global-set-key [f9] 'save-buffer)
(global-set-key [f10] 'next-error)
(global-set-key [f11] 'ecb-activate)
(global-set-key [f12] 'ecb-deactivate)
(global-set-key [C-f1] 'compile)
(global-set-key [C-f2] 'grep)
(global-set-key [C-f3] 'next-error)
(global-set-key [C-f4] 'previous-error)
(global-set-key [C-f5] 'display-faces)
(global-set-key [C-f8] 'dired)
(global-set-key [C-f10] 'kill-compilation)

;; Keypad bindings
(global-set-key [up] "\C-p")
(global-set-key [down] "\C-n")
(global-set-key [left] "\C-b")
(global-set-key [right] "\C-f")
(global-set-key [home] "\C-a")
(global-set-key [end] "\C-e")
(global-set-key [prior] "\M-v")
(global-set-key [next] "\C-v")
(global-set-key [C-up] "\M-\C-b")
(global-set-key [C-down] "\M-\C-f")
(global-set-key [C-left] "\M-b")
(global-set-key [C-right] "\M-f")
(global-set-key [C-home] "\M-<")
(global-set-key [C-end] "\M->")
(global-set-key [C-prior] "\M-<")
(global-set-key [C-next] "\M->")

;; Mouse
(global-set-key [mouse-3] 'imenu)

;; Misc
(global-set-key [C-tab] "\C-q\t")	; Control tab quotes a tab.
					;(setq backup-by-copying-when-mismatch t)

;; Treat 'y' or <CR> as yes, 'n' as no.
(fset 'yes-or-no-p 'y-or-n-p)
(autoload 'ediff-buffers "ediff" "Intelligent Emacs interface to diff" t)
(autoload 'ediff-files "ediff" "Intelligent Emacs interface to diff" t)
(autoload 'ediff-files-remote "ediff"
  "Intelligent Emacs interface to diff")

(setq auto-mode-alist
      (append '(("\\.cpp$" . c++-mode)
		("\\.hpp$" . c++-mode)
		("\\.lsp$" . lisp-mode)
		("\\.scm$" . scheme-mode)
		("\\.pl$" . perl-mode)
		) auto-mode-alist))

;; Auto font lock mode
(defvar font-lock-auto-mode-list
  (list 'c-mode 'c++-mode 'c++-c-mode 'emacs-lisp-mode 'lisp-mode 'perl-mode 'scheme-mode)
  "List of modes to always start in font-lock-mode")

(defvar font-lock-mode-keyword-alist
  '((c++-c-mode . c-font-lock-keywords)
    (perl-mode . perl-font-lock-keywords))
  "Associations between modes and keywords")

(defun font-lock-auto-mode-select ()
  "Automatically select font-lock-mode if the current major mode is in font-lock-auto-mode-list"
  (if (memq major-mode font-lock-auto-mode-list)
      (progn
	(font-lock-mode t))
    )
  )

(if (and (not window-system)
	 (not (equal system-type 'ms-dos)))
    (progn
      (progn
	(keyboard-translate ?\C-h ?\C-?)
	(keyboard-translate ?\C-? ?\C-h))))


;; Indicate that this file has been read at least once
(setq first-time nil)

;; No need to debug anything now

(setq debug-on-error nil)

;; All done
(message "All done, %s%s" (user-login-name) ".")
(require 'go-mode-load)

(global-set-key "\M-w"
		(lambda ()
		  (interactive)
		  (if mark-active
		      (kill-ring-save (region-beginning)
				      (region-end))
		    (progn
		      (kill-ring-save (line-beginning-position)
				      (line-end-position))
		      (message "copied line")))))


;; kill region or whole line
(global-set-key "\C-w"
		(lambda ()
		  (interactive)
		  (if mark-active
		      (kill-region (region-beginning)
				   (region-end))
		    (progn
		      (kill-region (line-beginning-position)
				   (line-end-position))
		      (message "killed line")))))

(setq make-backup-files nil)
(setq auto-save-default nil)

;; Load CEDET.
;; See cedet/common/cedet.info for configuration details.
;; IMPORTANT: For Emacs >= 23.2, you must place this *before* any
;; CEDET component (including EIEIO) gets activated by another
;; package (Gnus, auth-source, ...).
(load-file "~/.emacs.d/cedet-1.1/common/cedet.el")

;; Enable EDE (Project Management) features
(global-ede-mode 1)

;; Enable EDE for a pre-existing C++ project
;; (ede-cpp-root-project "NAME" :file "~/myproject/Makefile")


;; Enabling Semantic (code-parsing, smart completion) features
;; Select one of the following:

;; * This enables the database and idle reparse engines
(semantic-load-enable-minimum-features)

;; * This enables some tools useful for coding, such as summary mode,
;;   imenu support, and the semantic navigator
(semantic-load-enable-code-helpers)

;; * This enables even more coding tools such as intellisense mode,
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
;; (semantic-load-enable-gaudy-code-helpers)

;; * This enables the use of Exuberant ctags if you have it installed.
;;   If you use C++ templates or boost, you should NOT enable it.
;; (semantic-load-enable-all-exuberent-ctags-support)
;;   Or, use one of these two types of support.
;;   Add support for new languages only via ctags.
;; (semantic-load-enable-primary-exuberent-ctags-support)
;;   Add support for using ctags as a backup parser.
;; (semantic-load-enable-secondary-exuberent-ctags-support)

;; Enable SRecode (Template management) minor-mode.
;; (global-srecode-minor-mode 1)

(add-to-list 'load-path
	     "/usr/home/mike/.emacs.d/ecb-2.40")

(require 'ecb)
(setq ecb-tip-of-the-day nil)
(setq stack-trace-on-error t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(display-time-mode t)
 '(ecb-options-version "2.40")
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Droid Sans Mono" :foundry "unknown" :slant normal :weight normal :height 120 :width normal)))))
