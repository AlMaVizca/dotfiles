;;; my-daemon --- Daemon customizations
;;; Commentary: Setup daemon generic settings

;;; Code
(require 'bookmark)

(setq
 daemon-name (if (not (daemonp)) "no daemon" (daemonp))
 desktop-save nil
 initial-buffer-choice (bookmark-get-filename "Mine")
 frame-title-format daemon-name
 repositories (bookmark-get-filename "repos")
 )

(add-to-list 'mode-line-misc-info daemon-name)

(provide 'my-daemon)
;;; my-daemon.el ends here
