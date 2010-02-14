;; enable ido-mode
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ;; enable fuzzy matching

;; auto-indent new lines
(define-key global-map (kbd "RET") 'newline-and-indent)
