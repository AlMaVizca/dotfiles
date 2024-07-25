;;; my-packages --- custom package managers and sources
;;; Commentary:
;;; Personal choices to manage packages
;;; Code:

(require 'my-elpaca)

(use-package compat
  ;; Cloning from source to avoid gpg problem
  :ensure (:protocol https :host github :repo "emacs-compat/compat")
  )

(use-package git-modes
  :ensure (:wait t)
  )

(use-package helm
  :ensure t
  )

(use-package mermaid-mode
  :ensure t
  :commands mermaid-mode
  )

(use-package auto-package-update
  :ensure t
  :disabled t
  :custom
  (auto-package-update-delete-old-versions t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe))

(use-package sudo-edit
  :ensure f
  :disabled t)

(provide 'my-packages)
;;; my-packages ends here
