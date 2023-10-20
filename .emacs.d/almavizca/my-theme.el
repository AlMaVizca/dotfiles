;;; my-theme - theme preferences
;;; Commentary: theme settings
;;; Code:

(use-package doom-modeline
  :ensure  t
  :init (doom-modeline-mode 1)
  :custom (
           (doom-modeline-height 10)
           )
  )

(use-package solarized-theme
  :ensure t
  :config
  (load-theme 'solarized-dark t)
  (let ((line (face-attribute 'mode-line :underline)))
    (set-face-attribute 'mode-line          nil :overline   line)
    (set-face-attribute 'mode-line-inactive nil :overline   line)
    (set-face-attribute 'mode-line-inactive nil :underline  line)
    (set-face-attribute 'mode-line          nil :box        nil)
    (set-face-attribute 'mode-line-inactive nil :box        nil)
    (set-face-attribute 'mode-line-inactive nil :background "#163a43"))
  )

(use-package moody
  :ensure t
  :config
  (setq x-underline-at-descent-line t)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode))

(defun my-theme-window ()
  "Highlight selected window with a different background color."
  (walk-windows (lambda (w)
                  (unless (eq w (selected-window))
                    (with-current-buffer (window-buffer w)
                      (buffer-face-set '(:background "#163a43"))))))
  (buffer-face-set 'default))
(add-hook 'buffer-list-update-hook 'my-theme-window)

(global-set-key (kbd "<f12>") 'my-theme-buffer)
(make-face 'flash-active-buffer-face)
(set-face-attribute 'flash-active-buffer-face nil
                    :background "#0086a9" :foreground "white" )
(defun my-theme-buffer ()
  (interactive)
  (run-at-time "100 millisec" nil
               (lambda (remap-cookie)
                 (face-remap-remove-relative remap-cookie))
               (face-remap-add-relative 'default 'flash-active-buffer-face)))


;; modeline
(use-package all-the-icons
             :ensure t
             )


(use-package all-the-icons-dired
  :ensure t
  :hook
  (
   (dired-mode . all-the-icons-dired-mode)
   )
  )

(use-package all-the-icons-completion
  :ensure t
  )


;; dired size
(setq dired-listing-switches "-alh")
;; (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)


(provide 'my-theme)
