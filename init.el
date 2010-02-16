(add-to-list 'load-path "~/.emacs.d/plugins")

;; set more reasonable window size
(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
  (progn
    ;; use 120 char wide window for largeish displays
    ;; and smaller 80 column windows for smaller displays
    ;; pick whatever numbers make sense for you
    (if (> (x-display-pixel-width) 1280)
        (add-to-list 'default-frame-alist (cons 'width 120))
      (add-to-list 'default-frame-alist (cons 'width 80)))
    ;; for the height, subtract a couple hundred pixels
    ;; from the screen height (for panels, menubars and
    ;; whatnot), then divide by the height of a char to
    ;; get the height we want
    (add-to-list 'default-frame-alist 
                 (cons 'height (/ (- (x-display-pixel-height) 200) (frame-char-height)))))))

(set-frame-size-according-to-resolution)

;; enable ido-mode
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ;; enable fuzzy matching

;; auto-indent new lines
(define-key global-map (kbd "RET") 'newline-and-indent)

;; pyflakes
;; (when (load "flymake" t) 
;;   (defun flymake-pyflakes-init () 
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy 
;;                        'flymake-create-temp-inplace)) 
;;            (local-file (file-relative-name 
;;                         temp-file 
;;                         (file-name-directory buffer-file-name)))) 
;;       (list "pyflakes" (list local-file)))) 
;;   (add-to-list 'flymake-allowed-file-name-masks 
;;                '("\\.py\\'" flymake-pyflakes-init)))
;; (add-hook 'python-mode-hook 'flymake-mode)

;; yasnippet
(add-to-list 'load-path
	     "~/.emacs.d/plugins/yasnippet-0.6.1c")
(require 'yasnippet)
(yas/initialize)

(setq yas/root-directory '("~/.emacs.d/mysnippets"
			   "~/.emacs.d/plugins/yasnippet-0.6.1c/snippets"))
(mapc 'yas/load-directory yas/root-directory)

(load "~/.emacs.d/plugins/django-mode.el")

;; display current column number in mode line
(setq column-number-mode t)

(require 'mercurial)