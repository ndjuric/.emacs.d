;; use-package config

(unless (package-installed-p 'use-package) ; unless it is already installed
	  (package-refresh-contents) ; update packages archive
		  (package-install 'use-package)) ; install the latest version of use-package
(eval-when-compile (require 'use-package))
(setq use-package-always-ensure t)

;; add imenu support for use-package declarations
(setq use-package-enable-imenu-support t)

;; Manage your installed packages with emacs
;; https://github.com/jabranham/system-packages
(use-package system-packages)

;; https://github.com/emacsorphanage/key-chord/tree/master
(use-package key-chord :config (key-chord-mode 1))

(use-package use-package-chords)
(use-package use-package-ensure-system-package)

(provide 'setup-packages)
