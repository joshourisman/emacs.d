;; Add plugins to load-path
(add-to-list 'load-path "~/.emacs.d/plugins")

;; turn on global-auto-revert
(global-auto-revert-mode 1)

;; Set up minimap
(require 'minimap)

;; enable line numbers for text-mode
(global-linum-mode t)

;; set up textmate-mode
(require 'textmate-mode)
(add-hook 'python-mode-hook 'textmate-mode)
(add-hook 'html-mode-hook 'textmate-mode)
(add-hook 'emacs-lisp-mode-hook 'textmate-mode)

;; set up electric pairs for elisp-mode
;; (add-hook 'emacs-lisp-mode-hook
;; 	  (lambda ()
;; 	    (define-key emacs-lisp-mode-map "(" 'electric-pair)))
;; (defun electric-pair ()
;;   "Insert character pair without sournding spaces"
;;   (interactive)
;;   (let (parens-require-spaces)
;;     (insert-pair)))

;; Set tabs to be 4 spaces
(setq indent-tabs-mode nil)
(setq tab-width 4)
(setq-default py-indent-offset 4)

;; Put backup files somewhere less annoying
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; set more reasonable window size
(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
      (progn
	;; use 80 char wide window
	(add-to-list 'default-frame-alist (cons 'width 80))
	;; for the height, subtract a couple hundred pixels
	;; from the screen height (for panels, menubars and
	;; whatnot), then divide by the height of a char to
	;; get the height we want
	(add-to-list 'default-frame-alist 
		     (cons 'height (/ (- (x-display-pixel-height) 200) (frame-char-height)))))))

(set-frame-size-according-to-resolution)

;; set up some functions for adjusting the window
(defun setup-dual-windows ()
  (interactive)
  (delete-other-windows)
  (set-frame-width (selected-frame) 174)
  (split-window-horizontally))

(defun setup-single-window ()
  (interactive)
  (delete-other-windows)
  (set-frame-width (selected-frame) 80))

;; enable ido-mode
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ;; enable fuzzy matching

;; auto-indent new lines
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Flymake
;; from Justin Lilly

(eval-after-load 'python-mode
  '(progn
     (require 'flymake)
     (when (load "flymake" t)
       (defun flymake-pylint-init ()
         (let* ((temp-file (flymake-init-create-temp-buffer-copy
                            'flymake-create-temp-inplace))
                (local-file (file-relative-name
                             temp-file
                             (file-name-directory buffer-file-name))))
           (list "epylint" (list local-file))))
       (add-to-list 'flymake-allowed-file-name-masks
                    '("\\.py\\'" flymake-pylint-init)))))

;; yasnippet
(add-to-list 'load-path
	     "~/.emacs.d/plugins/yasnippet-0.6.1c")
(require 'yasnippet)
(yas/initialize)

(setq yas/root-directory '("~/.emacs.d/mysnippets"
			   "~/.emacs.d/plugins/yasnippet-0.6.1c/snippets"))
(mapc 'yas/load-directory yas/root-directory)

(load "~/.emacs.d/plugins/django-mode.el")

;; markdown mode
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '("\\.mdown" . markdown-mode) auto-mode-alist))

;; enable emacs-nav
(require 'nav)

;; display current column number in mode line
(setq column-number-mode t)

(require 'mercurial)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(nav-quickdir-list (quote ("~/.emacs.d" "~/PROJECTS" "~/OPENSOURCE"))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; code checking via flymake
;; set code checker here from "epylint", "pyflakes"
;; (setq pycodechecker "pyflakes")
;; (when (load "flymake" t)
;;   (defun flymake-pycodecheck-init ()
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;            (local-file (file-relative-name
;;                         temp-file
;;                         (file-name-directory buffer-file-name))))
;;       (list pycodechecker (list local-file))))
;;   (add-to-list 'flymake-allowed-file-name-masks
;;                '("\\.py\\'" flymake-pycodecheck-init)))

;; (add-hook 'python-mode-hook 'flymake-mode)

