(use-package rainbow-delimiters
  :hook ((prog-mode . rainbow-delimiters-mode)))

(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox t))

(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)
(setq inhibit-startup-echo-area-message t)

(setq initial-major-mode 'emacs-lisp-mode)

;(setq-default cursor-type '(bar . 1))
(toggle-frame-fullscreen)
(blink-cursor-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(use-package dimmer
  :ensure t
  :hook ((after-init . dimmer-mode))
  :config
  (setq-default dimmer-fraction 0.2)
  (setq dimmer-exclusion-regexp "^/*helm.*\\|^ \*Minibuf-.*"))

(use-package beacon
  :config
  (beacon-mode)
  (setq beacon-size 25)
  (add-to-list 'beacon-dont-blink-major-modes #'comint-mode)
  (add-to-list 'beacon-dont-blink-major-modes #'term-mode))

(provide 'init-visual)
