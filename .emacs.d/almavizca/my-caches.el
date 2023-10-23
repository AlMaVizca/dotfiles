;;; my-caches --- local caches system
;;; Comments: to reduce network traffic
(require 'bookmark)
(require 'my-makefile-runner)

(defun my-cache-runner (target)
  (interactive)
  (my-makefile-runner target (concat (bookmark-get-filename  "caches" ) "Makefile"))
  )

(global-set-key (kbd "C-S-c r") (lambda () () (interactive) (my-cache-runner "start")))
(global-set-key (kbd "C-S-c s") (lambda () () (interactive) (my-cache-runner "stop")))

(provide 'my-caches)
