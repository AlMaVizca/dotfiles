;;; my-daemon package

;;; Code
(require 'bookmark)
(setq
 daemon-name (if (not (daemonp)) "no daemon" (daemonp))
 desktop-save nil
 initial-buffer-choice (bookmark-get-filename "ToDo")
 )
(setq frame-title-format daemon-name)
(add-to-list 'mode-line-misc-info daemon-name)

(setq
 roam-directory (bookmark-get-filename "notes")
 repositories (bookmark-get-filename "repos")
 )

(provide 'my-daemon)
;;; my-daemon ends here
