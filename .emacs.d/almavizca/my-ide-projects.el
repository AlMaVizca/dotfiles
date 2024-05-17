;;; my-ide-projects --- Projects settings
;;; Commentary:
;;; Code:

;;; ToDo: Setup projectile
;; (projectile-project-search-path repositories)

;; (use-package projectile
;;   :diminish projectile-mode
;;   :config (projectile-mode)
;;   :custom
;;   (
;;    (projectile-completion-system 'ivy)
;;    (projectile-switch-project-action #'projectile-dired)
;;    (projectile-per-project-compilation-buffer t)
;;    (shell-command-switch "-ic")
;;    )
;;   :bind-keymap
;;   ("C-c p" . projectile-command-map)
;;   )

;; (use-package counsel-projectile
;;   :ensure t
;;   :config (counsel-projectile-mode)
;;   )

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

(use-package consult-project-extra
  :ensure t)

(use-package consult-todo
  :ensure t
  :custom
  (consult-todo--narrow '(
                          (?t . "TODO")
                          (?f . "FIXME")
                          (?i . "IN-PROGRESS")
                          (?b . "BUG")
                          (?h . "HACK")
                          ))
  )

(use-package compile-multi
  :ensure t
  :straight t)

(use-package projection-multi
  :ensure t)

(provide 'my-ide-projects)
;;; my-ide-projects.el ends here
