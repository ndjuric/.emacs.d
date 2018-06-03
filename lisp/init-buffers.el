;; prevent switching to a visible buffer
(setq switch-to-visible-buffer nil)

;; uniquify buffers
(use-package uniquify :ensure nil
  :defer 2
  :config
  ;; make buffers with same name unique
  (setq uniquify-buffer-name-style 'forward)
  (setq uniquify-separator "/")
  (setq uniquify-after-kill-buffer-p t)    ; rename after killing uniquified
  (setq uniquify-ignore-buffers-re "^\\*")) ; don't muck with special buffers

;; make emacs auto-refresh all buffers when files have changed on the disk
(global-auto-revert-mode t)
(setq auto-revert-remote-files t)
(setq auto-revert-verbose nil)

;;; Reopen Killed File
(defvar killed-file-list nil
  "List of recently killed files.")

(defun add-file-to-killed-file-list ()
  "If buffer is associated with a file name, add that file to the
`killed-file-list' when killing the buffer."
  (when buffer-file-name
    (push buffer-file-name killed-file-list)))

(add-hook 'kill-buffer-hook #'add-file-to-killed-file-list)

;; Toggle between buffers
(defun toggle-between-buffers ()
  "Toggle between 2 buffers"
  (interactive)
  (switch-to-buffer (other-buffer)))
(bind-chord "ZZ" #'toggle-between-buffers)

(defun rename-file-and-buffer ()
  "Rename the current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))

(defun revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
  (interactive) (revert-buffer t t))

(bind-keys
 ("C-c m v" . rename-file-and-buffer)
 ("C-c m d" . make-directory)
 ("s-u" . revert-buffer-no-confirm))

(defun my/split-below-and-move ()
  "split window below and move there"
  (interactive)
  (split-window-below)
  (other-window 1))

(defun my/split-right-and-move ()
  "split window right and move there"
  (interactive)
  (split-window-right)
  (other-window 1))

(bind-keys
 ("C-x 2" . my/split-below-and-move)
 ("C-x 3" . my/split-right-and-move))

;;; Revert buffer
(defvar my-skippable-buffers '("*Messages*"
                               "*Help*"
                               "*Bookmark List*"
                               "*Ibuffer*"
                               "*compilation*")
  "Buffer names ignored by `my-next-buffer' and `my-previous-buffer'.")

(defun my-change-buffer (change-buffer)
  "Call CHANGE-BUFFER until current buffer is not in `my-skippable-buffers'."
  (let ((initial (current-buffer)))
    (funcall change-buffer)
    (let ((first-change (current-buffer)))
      (catch 'loop
        (while (member (buffer-name) my-skippable-buffers)
          (funcall change-buffer)
          (when (eq (current-buffer) first-change)
            (switch-to-buffer initial)
            (throw 'loop t)))))))

(defun my-next-buffer ()
  "Variant of `next-buffer' that skips `my-skippable-buffers'."
  (interactive)
  (my-change-buffer 'next-buffer))

(defun my-previous-buffer ()
  "Variant of `previous-buffer' that skips `my-skippable-buffers'."
  (interactive)
  (my-change-buffer 'previous-buffer))

(global-set-key [remap next-buffer] 'my-next-buffer)
(global-set-key [remap previous-buffer] 'my-previous-buffer)

(defun wh/switch-buffers-same-mode ()
  "Allows us to switch between buffers of the same major mode"
  (interactive)
  (let* ((matching-bufs (--filter (eq major-mode (with-current-buffer it major-mode))
                                  (buffer-list)))
         (bufs-with-names (--map
                           (cons
                            (let ((proj-name (with-current-buffer it (projectile-project-name))))
                              (if proj-name
                                  (format "%s (%s)" (buffer-name it) proj-name)
                                (buffer-name it)))
                            it)
                           matching-bufs))
         (chosen-buf
          (cdr (assoc (completing-read "Buffer: " bufs-with-names)
                      bufs-with-names))))
    (switch-to-buffer chosen-buf)))
(bind-key "C-x B" #'wh/switch-buffers-same-mode)

;; beginend: Emacs package to redefine M-< and M-> for some modes
;; https://github.com/DamienCassou/beginend
(use-package beginend
  :config
  (beginend-global-mode)
  (beginend-define-mode ivy-occur-mode
    (progn
      (ivy-occur-next-line 4))
    (progn
      (ivy-occur-previous-line 1)))
  (add-hook 'ivy-occur-grep-mode-hook #'beginend-ivy-occur-mode))

(defun duplicate-buffer (new-name)
  "Create a copy of the current buffer with the filename NEW-NAME.
The original buffer and file are untouched."
  (interactive (list (read-from-minibuffer "New name: " (buffer-file-name))))

  (let ((filename (buffer-file-name))
        (new-directory (file-name-directory new-name))
        (contents (buffer-substring (point-min) (point-max))))
    (unless filename (error "Buffer '%s' is not visiting a file!" (buffer-name)))

    (make-directory new-directory t)
    (find-file new-name)
    (insert contents)
    (basic-save-buffer)))

;;; Narrow/Widen
;; http://endlessparentheses.com/emacs-narrow-or-widen-dwim.html
(defun endless/narrow-or-widen-dwim (p)
  "Widen if buffer is narrowed, narrow-dwim otherwise.
Dwim means: region, org-src-block, org-subtree, or defun,
whichever applies first. Narrowing to org-src-block actually
calls `org-edit-src-code'.
With prefix P, don't widen, just narrow even if buffer is already
narrowed."
  (interactive "P")
  (declare (interactive-only))
  (cond ((and (buffer-narrowed-p) (not p))
         (widen))
        ((region-active-p)
         (narrow-to-region (region-beginning) (region-end)))
        ((derived-mode-p 'org-mode)
         (cond
          ((ignore-errors (org-edit-src-code) t))
          ((ignore-errors (org-narrow-to-block) t))
          (t
           (org-narrow-to-subtree))))
        ((derived-mode-p 'latex-mode)
         (LaTeX-narrow-to-environment))
        (t
         (narrow-to-defun))))
(bind-key "C-x n n" #'endless/narrow-or-widen-dwim)

(provide 'init-buffers)
