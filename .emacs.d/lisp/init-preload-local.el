;;; init-preload-local -- My custom init
;;; Commentary:
;;; Load elpaca and org before purcell's settings

(add-to-list 'load-path (expand-file-name "almavizca" user-emacs-directory))

(require 'my-packages)
(require 'my-bookmarks)
(require 'my-org)

(provide 'init-preload-local)
;;; init-preload-local.el ends here
