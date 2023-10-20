;;; my-services --- 3rd party services

;;; Commentary: 3rd party services

;; TODO: Check gitlab(helm-gitlab) or lab(https://github.com/isamert/lab.el)
(use-package gitlab
  :ensure t
  :custom
  (gitlab-host "https://gitlab.com")
  (gitlab-token-id (password-store-get "Work/gitlab.com/fenix-token"))
  )

(use-package gitlab-pipeline
  :ensure t)
(use-package gitlab-ci-mode
  :ensure t)

(use-package lab
  :ensure t
  :custom
  ;; Required.
  (lab-host "https://gitlab.com")
  ;; Required.
  (lab-token (password-store-get "Work/gitlab.com/fenix-token"))
  ;; Optional, but useful. See the variable documentation.
  ;; (lab-group "YOUR-GROUP-ID")
  )

(provide 'my-services)
