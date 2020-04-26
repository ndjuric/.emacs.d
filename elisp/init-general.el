(setq confirm-kill-emacs #'y-or-n-p)

(add-hook 'prog-mode-hook
          (lambda () (interactive)
            (setq show-trailing-whitespace 1)))

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

;; move between windows using Shift+Arrows
(windmove-default-keybindings)

;; in-buffer code completion
(use-package company
  :init
  (global-company-mode 1))

(use-package projectile
  :init
  (projectile-global-mode)
  (setq projectile-enable-caching t))

(use-package format-all
  :bind*
  ("C-M-<tab>" . format-all-buffer))

(global-set-key (kbd "C-c w") 'whitespace-mode)
(global-set-key (kbd "RET") 'newline-and-indent)
(provide 'init-general)
