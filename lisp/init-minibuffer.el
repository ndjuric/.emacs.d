(when (not (bound-and-true-p disable-recursive-edit-in-minibuffer))
  (setq enable-recursive-minibuffers t)
  (minibuffer-depth-indicate-mode 1))

;; resize minibuffer window to accommodate text
(setq resize-mini-window t)

(use-package whole-line-or-region)

(defun my-minibuffer-setup-hook ()
  (whole-line-or-region-local-mode -1))
(defun my-minibuffer-exit-hook ()
  (whole-line-or-region-local-mode))

(add-hook 'minibuffer-setup-hook #'my-minibuffer-setup-hook)
(add-hook 'minibuffer-exit-hook #'my-minibuffer-exit-hook)

;; enable some minor modes when in eval-expression of minibuffer
(add-hook 'eval-expression-minibuffer-setup-hook (lambda()
                                                   (smartparens-mode)
                                                   (rainbow-delimiters-mode)
                                                   (eldoc-mode)))

(provide 'init-minibuffer)
