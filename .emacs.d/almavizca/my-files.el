;;; my-files --- configurations for dired
;;; Commentary: personal management settings

(defun dired-dotfiles-toggle ()
  "Show/hide dot-files"
  (interactive)
  (when (equal major-mode 'dired-mode)
    (if (or (not (boundp 'dired-dotfiles-show-p)) dired-dotfiles-show-p) ; if currently showing
        (progn
          (set (make-local-variable 'dired-dotfiles-show-p) nil)
          (message "h")
          (dired-mark-files-regexp "^\\\.")
          (dired-do-kill-lines))
      (progn (revert-buffer)            ; otherwise just revert to re-show
             (set (make-local-variable 'dired-dotfiles-show-p) t)))))



(provide 'my-files)
;;; my-files package ends here
