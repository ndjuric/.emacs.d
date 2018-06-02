;; Projectile: Project Interaction Library for Emacs
;; https://github.com/bbatsov/projectile
(use-package projectile
  :defer 1
  :config
  (setq projectile-completion-system 'ivy
        projectile-enable-caching t)

  ;; ignore stack directory as projectile project
  (add-to-list 'projectile-ignored-projects
               (concat user-home-directory ".stack/global-project/"))
  ;; ignore all projects under exercism directory
  (require 'f)
  (defun my-projectile-ignore-project (project-root)
    (f-descendant-of? project-root (expand-file-name "~/exercism")))
  (setq projectile-ignored-project-function #'my-projectile-ignore-project)
  (bind-keys
   ("C-c p r" . projectile-replace-regexp))
  (projectile-mode))

(provide 'init-projectile)
