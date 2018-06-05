(use-package hydra
  :config
  (set-face-attribute 'hydra-face-red nil
                      :foreground "#FF6956" :bold t :background "#383838")
  (set-face-attribute 'hydra-face-blue nil
                      :foreground "Cyan" :bold t :background "#383838")
  (set-face-attribute 'hydra-face-amaranth nil
                      :foreground "#e52b50" :bold t :background "#383838")
  (set-face-attribute 'hydra-face-pink nil
                      :foreground "HotPink1" :bold t :background "#383838")
  (set-face-attribute 'hydra-face-teal nil
                      :foreground "SkyBlue1" :bold t :background "#383838")
  (hydra-add-font-lock))

(provide 'init-hydra)
