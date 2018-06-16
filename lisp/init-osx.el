(use-package exec-path-from-shell
  :if (is-mac-p)
  :init
  (setq exec-path-from-shell-check-startup-files nil)
  (exec-path-from-shell-initialize))

(use-package osx-trash
  :if (is-mac-p)
  :config
  (setq delete-by-moving-to-trash t)
  (osx-trash-setup))

(provide 'init-osx)
