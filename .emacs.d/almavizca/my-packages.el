;;; my-packages --- custom package managers and sources
;;; Commentary: Personal choices to manage packages

(setq straight-log t)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


(straight-use-package 'use-package)


(use-package helm
  :ensure t
  :straight t
  )

(straight-use-package 'org)

(use-package mermaid-mode
  :ensure t
  :commands mermaid-mode
  )

(use-package sudo-edit
  :ensure f
  :disabled t)

(provide 'my-packages)
;;; my-packages ends here
