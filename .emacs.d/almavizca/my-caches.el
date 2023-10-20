;;; my-caches --- local caches system
;;; Comments: to reduce network traffic
(require 'bookmark)
(setq bookmark-default-file "~/Repositories/dotfiles/emacs.d/bookmarks.el")
(bookmark-load bookmark-default-file t)
(require 'my-makefile-runner)

(defun my-cache-runner (target)
  (interactive)
  (my-makefile-runner target "/home/krahser/Repositories/inthependiente/caches/Makefile")
  )

;;(bookmark-get-filename "caches")


(global-set-key (kbd "C-S-c r") (lambda () () (interactive) (my-cache-runner "start")))
(global-set-key (kbd "C-S-c s") (lambda () () (interactive) (my-cache-runner "stop")))

(provide 'my-caches)
