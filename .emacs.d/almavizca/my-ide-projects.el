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


(use-package compile-multi
  :ensure t
  :straight t)

(use-package projection-multi
  :ensure t)

(use-package helm-make
  ;;; Run projects based on the Makefile definition
  :ensure t
  :straight nil
  :custom
  (helm-make-comint t)
  (helm-make-named-buffer t)
  (helm-make-arguments "-j%d")
  :config
  (defcustom helm-make-parameters ""
    "Pass these parameters as variables to `helm-make'"
    :type 'string
    :group 'helm-make)

  (defun helm--make-construct-command (arg file)
    "Construct the `helm-make-command'.

ARG should be universal prefix value passed to `helm-make' or
`helm-make-projectile', and file is the path to the Makefile or the
ninja.build file."
    (format (concat "%s%s -C %s " helm-make-arguments " %%s")
            (if (= helm-make-niceness 0)
                ""
              (format "nice -n %d " helm-make-niceness))
            (cond
             ((equal helm--make-build-system 'ninja)
              helm-make-ninja-executable)
             (t
              (concat helm-make-parameters " " helm-make-executable)))
            (replace-regexp-in-string
             "^/\\(scp\\|ssh\\).+?:.+?:" ""
             (shell-quote-argument (file-name-directory file)))
            (let ((jobs (abs (if arg (prefix-numeric-value arg)
                               (if (= helm-make-nproc 0) (helm--make-get-nproc)
                                 helm-make-nproc)))))
              (if (> jobs 0) jobs 1))))

  (global-set-key (kbd "C-c C-r") 'helm-make-projectile)
  )

(provide 'my-ide-projects)
;;; my-ide-projects.el ends here
