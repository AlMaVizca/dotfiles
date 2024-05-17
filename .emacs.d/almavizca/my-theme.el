;;; my-theme --- theme preferences
;;; Commentary:
;;; Code:

(use-package doom-modeline
  ;; Run nerd-icons-install-fonts
  :ensure  t
  :init
  (doom-modeline-mode 1)
  :custom ((doom-modeline-height 10)))

(use-package solarized-theme
  :ensure t
  :config
  (let ((line (face-attribute 'mode-line :underline)))
    (set-face-attribute 'mode-line          nil :overline   line)
    (set-face-attribute 'mode-line-inactive nil :overline   line)
    (set-face-attribute 'mode-line-inactive nil :underline  line)
    (set-face-attribute 'mode-line          nil :box        nil)
    (set-face-attribute 'mode-line-inactive nil :box        nil)
    (set-face-attribute 'mode-line-inactive nil :background "#163a43")))

;; TODO
;; (use-package moody
;;   ;;; Tabs and ribbons for the mode line
;;   :ensure nil
;;   :config
;;   (setq x-underline-at-descent-line t)
;;   (moody-replace-mode-line-buffer-identification)
;;   (moody-replace-vc-mode)
;;   )

;; modeline
(use-package all-the-icons
  :ensure t)

(use-package all-the-icons-dired
  :ensure t
  :hook
  ((dired-mode . all-the-icons-dired-mode)))

(use-package all-the-icons-completion
  :ensure t)

(use-package all-the-icons-ivy
  :ensure t)

(use-package all-the-icons-ivy-rich
  :ensure t)

(use-package all-the-icons-nerd-fonts
  :ensure t)

(use-package nerd-icons-completion
  :ensure t)

(use-package nerd-icons-ivy-rich
  :ensure t)

(use-package nerd-icons-dired
  :ensure t)

(use-package counsel
  :ensure t)

(use-package counsel-tramp
  :ensure t)

;; dired size
(setq dired-listing-switches "-alh")
;; (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

(provide 'my-theme)
;;; my-theme.el ends here
