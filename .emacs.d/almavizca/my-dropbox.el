;;; my-dropbox --- Configurations
;;; Commentary:

;;; Code:
(add-to-list 'auto-save-file-name-transforms '("\\`.*/Dropbox/.*" "/tmp/" t))
(add-to-list 'backup-directory-alist '("\\`.*/Dropbox/.*" . "/tmp/"))
(let (
      (dropbox-repo "~/Repositories/emacs/emacs-dropbox")
      )
  (message dropbox-repo)
  (message (file-directory-p dropbox-repo))
  (unless (file-directory-p dropbox-repo)
    (add-to-list 'load-path dropbox-repo)
    (require 'dropbox)
    ))

(add-to-list 'load-path "~/Repositories/emacs/emacs-dropbox")
(require 'dropbox)
;;; my-dropbox.el ends here
