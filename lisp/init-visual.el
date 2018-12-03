(use-package rainbow-delimiters
  :hook ((prog-mode . rainbow-delimiters-mode)))

(use-package gruvbox-theme)

(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)
(setq inhibit-startup-echo-area-message t)

(setq initial-major-mode 'emacs-lisp-mode)

(setq-default cursor-type '(bar . 1))
(toggle-frame-fullscreen)
(blink-cursor-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

(setq ring-bell-function 'ignore)
(setq mouse-wheel-progressive-speed nil)
(setq frame-resize-pixelwise t)
(setq tooltip-mode nil)

;; display date and time
(setq display-time-format "%a-%d %H:%M")
(setq display-time-default-load-average nil)
(display-time-mode)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; macos transparent titlebar
(when (is-mac-p)
  (add-to-list 'default-frame-alist '(ns-appearance . dark)))

;; remove scrollbar
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; resize windows proportionally
(setq window-combination-resize t)

;; Show actual lines instead of the page break char ^L
;; enter page-break character in Emacs by entering `C-q C-l'
(use-package page-break-lines
  :hook ((prog-mode . page-break-lines-mode)
         (org-mode . page-break-lines-mode)))

;; column-enforce-mode: highlight characters which exceed fill-column
(use-package column-enforce-mode
  :config
  (add-hook 'prog-mode-hook (lambda ()
                              (unless (eq major-mode 'web-mode)
                                (column-enforce-mode))))

  ;; enforce a column of 80 for highlighting
  (setq column-enforce-column 80)
  (set-face-attribute 'column-enforce-face nil
                      :underline nil :foreground "firebrick3")
  (setq column-enforce-comments nil))

;; dimer: Interactively highlight which buffer is active by dimming the others.
(use-package dimmer
  :ensure t
  :hook ((after-init . dimmer-mode))
  :config
  (setq-default dimmer-fraction 0.5)
  (setq dimmer-exclusion-regexp "^\*helm.*\\|^ \*Minibuf-.*"))

;; beacon: blink the cursor whenever scrolling or switching between windows
(use-package beacon
  :config
  (beacon-mode)
  (setq beacon-size 25)
  ;; don't blink in shell-mode
  (add-to-list 'beacon-dont-blink-major-modes #'comint-mode)
  (add-to-list 'beacon-dont-blink-major-modes #'term-mode))

;; fontify-face: Fontify symbols representing faces with that face.
(use-package fontify-face :defer t)

(provide 'init-visual)
;;; init-visual.el ends here
