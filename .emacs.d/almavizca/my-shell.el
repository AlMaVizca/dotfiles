;;; my-shell -- Shell customizations
;;; Commentary: Special shell configurations

(use-package vterm
  :ensure t
  :bind
  (:map vterm-mode-map
        ([mouse-1] . nil)
        ([mouse-2] . nil)
        ([mouse-3] . nil)
        ([mouse-4] . nil)
        ([mouse-5] . nil)
        )
  )

(use-package multi-vterm
  :ensure t
  :bind
  (
   ("º" . multi-vterm-dedicated-toggle)
   ("C-c t" . multi-vterm-project)
   ("C-c s" . multi-vterm)
   ("C-<prior>" . multi-vterm-prev)
   ("C-<next>" . multi-vterm-next)
   ([mouse-1] . nil)
   )
  :custom
  (multi-vterm-dedicated-window-height 15)
  (multi-vterm-buffer-name daemon-name)
  (multi-term-default-dir (bookmark-get-filename daemon-name))
  )


;;Set shell
;; (customize-set-variable
;;  'explicit-shell-file-name
;;  nil)
;; (customize-set-variable
;;  'bash-completion-prog
;;  "/usr/bin/zsh")
;; (customize-set-variable
;;  'bash-completion-re
;;  "/bin/zsh")

;; (setq explicit-shell-file-name "/usr/bin/zsh")
;; (setq shell-file-name "zsh")
;; (setq explicit-zsh-args '("--login" "--interactive"))
;; (defun zsh-shell-mode-setup ()
;;   (setq-local comint-process-echoes t))
;; (add-hook 'shell-mode-hook #'zsh-shell-mode-setup)


;; (customize-set-variable
;;  'shell-prompt-pattern
;;  "^[^#$%>
;; ]*[#$%>] *" )

;; (defun ask-user-about-lock ()
;;   t
;;   )

;; Test fish
;; (when (and (executable-find "fish")
;;            (require 'fish-completion nil t))
;;   (global-fish-completion-mode))


(provide 'my-shell)
