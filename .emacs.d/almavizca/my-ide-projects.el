;;; my-ide-projects --- Projects settings
;;; Commentary:
;;; Code:

(use-package projectile
  :ensure (:wait t)
  :custom
  ((projectile-project-root-files '("Makefile"))
   (projectile-completion-system 'ivy)
   (projectile-switch-project-action #'projectile-dired)
   (projectile-per-project-compilation-buffer t)
   (shell-command-switch "-ic")
   ))


(use-package counsel
  :ensure t
  :config
  (global-set-key "\C-s" 'swiper)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "<f6>") 'ivy-resume)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
  (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
  )
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

(use-package counsel-tramp
  :ensure t)

(use-package compile-multi
  :ensure t)

(use-package projection-multi
  :ensure t)

(provide 'my-ide-projects)
;;; my-ide-projects.el ends here
