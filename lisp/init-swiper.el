;; swiper: isearch with an overview!
;; https://github.com/abo-abo/swiper
(use-package swiper
  :bind (
         :map isearch-mode-map
         ("C-c s" . swiper-from-isearch)) ; isearch > swiper
  :config
  (setq swiper-action-recenter t))

(provide 'init-swiper)

;; swiper
;; `M-p' -> previous search item
;; `M-n' -> next search item
;; `M-n' -> to select the symbol at point in swiper
;; `C-c s' -> to search regexp from isearch to swiper
