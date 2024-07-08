;;; my-ide-projects --- Projects settings
;;; Commentary:
;;; Code:

(use-package projectile
  :ensure t
  :custom
  ((projectile-project-root-files '("Makefile"))
   (projectile-completion-system 'ivy)
   (projectile-switch-project-action #'projectile-dired)
   (projectile-per-project-compilation-buffer t)
   (shell-command-switch "-ic")
   ))

;; (defun zsh-shell-mode-setup ()
;;   (setq-local comint-process-echoes t))
;; (add-hook 'shell-mode-hook #'zsh-shell-mode-setup)
;; (add-hook 'term-mode-hook 'compilation-shell-minor-mode)

(use-package counsel-projectile
  :ensure t
  :config (counsel-projectile-mode))

;; (projectile-register-project-type 'npm '("package.json")
;;                                   :project-file "package.json"
;;                                :compile "npx npm install"
;;                                :test "npm test"
;;                                :run "npm start"
;;                                :test-suffix ".spec")

;; (def-projectile-commander-method ?F
;;   "Git fetch."
;;   (magit-status)
;;   (if (fboundp 'magit-fetch-from-upstream)
;;       (call-interactively #'magit-fetch-from-upstream)
;;     (call-interactively #'magit-fetch-current)))


(use-package compile-multi
  :ensure t
  :straight t)

(use-package projection-multi
  :ensure t)

(provide 'my-ide-projects)
;;; my-ide-projects.el ends here
