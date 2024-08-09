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

(use-package openwith
  :ensure t
  :config
  (when (require 'openwith nil 'noerror)
    (setq openwith-associations
          (list
           (list (openwith-make-extension-regexp
                  '("mpg" "mpeg" "mp3" "mp4"
                    "avi" "wmv" "wav" "mov" "flv"
                    "ogm" "ogg" "mkv"))
                 "vlc"
                 '(file))
           (list (openwith-make-extension-regexp
                  '("xbm" "pbm" "pgm" "ppm" "pnm"
                    "png" "gif" "bmp" "tif" "jpeg" "jpg"))
                 "gpicview"
                 '(file))
           (list (openwith-make-extension-regexp
                  '("doc" "xls" "ppt" "odt" "ods" "odg" "odp"))
                 "libreoffice"
                 '(file))
           '("\\.lyx" "lyx" (file))
           '("\\.chm" "kchmviewer" (file))
           (list (openwith-make-extension-regexp
                  '("pdf" "ps" "ps.gz" "dvi"))
                 "evince"
                 '(file))
           ))
    (openwith-mode 1))
  )

(provide 'my-packages)
;;; my-packages.el ends here
