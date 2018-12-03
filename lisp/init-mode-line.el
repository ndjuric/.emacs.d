(use-package mode-line-bell
  :defer 1
  :config (mode-line-bell-mode))

(setq-default mode-line-format
              '("%e"
                mu-eyebrowse-mode-line
                mode-line-front-space
                mode-line-mule-info
                mode-line-client
                mode-line-modified
                mode-line-remote
                mode-line-buffer-identification " " mode-line-position
                (vc-mode vc-mode)
                (multiple-cursors-mode mc/mode-line)
                " " mode-line-modes
                " " mode-line-misc-info
                mode-line-end-spaces))

;; Tabs and ribbons for the mode-line
(use-package moody
  :config
  (when (is-mac-p)
    (setq moody-slant-function #'moody-slant-apple-rgb))
  (setq x-underline-at-descent-line t)
  (setq moody-mode-line-height 22)

  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode)
  (column-number-mode)
  (size-indication-mode))

;; A minor-mode menu for the mode line
(use-package minions
  :init (minions-mode)
  :config
  (setq minions-mode-line-lighter "#")
  (setq minions-direct '(flycheck-mode)))

(provide 'init-mode-line)
