(defvar gc-cons-threshold-original gc-cons-threshold)
(setq gc-cons-threshold (* 100 1024 1024) gc-cons-percentage 0.6)

(defun set-custom-gc-threshold ()
  (setq gc-cons-threshold gc-cons-threshold-original gc-cons-percentage 0.1))

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package system-packages)
(use-package key-chord :config (key-chord-mode 1))

; set home and emacs dir
(defvar user-home-directory (concat (getenv "HOME") "/"))
(setq user-emacs-directory (concat user-home-directory ".emacs.d/"))

; save custom to separate dir
(setq custom-file (concat user-emacs-directory "custom/settings.el"))
(load custom-file :noerror :nomessage) ;; silent load

(add-to-list 'load-path (concat user-emacs-directory "elisp/"))

(require 'init-general)
(require 'init-visual)
(require 'init-ivy-counsel)

(package-install-selected-packages)

(require 'server)
(unless (server-running-p) (server-start))

;; reset gc-cons-threshold to original
(add-hook 'emacs-startup-hook #'set-custom-gc-threshold)


