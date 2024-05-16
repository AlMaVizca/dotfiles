;;; my-gitlab --- Gitlab integrations
;;; Commentary:
;;; Code:
;; TODO: Check gitlab(helm-gitlab) or lab(https://github.com/isamert/lab.el)
(use-package gitlab
  :ensure t
  :commands gitlab-mode
  :custom
  (gitlab-host "https://gitlab.com")
  (gitlab-token-id (password-store-get "Work/gitlab.com/fenix-token")))

(use-package gitlab-pipeline
  :ensure t
  :after gitlab)

(use-package gitlab-ci-mode
  :ensure t
  :after gitlab)

(use-package lab
  :ensure t
  :custom
  ;; Required.
  (lab-host "https://gitlab.com")
  ;; Required.
  (lab-token (password-store-get "Work/gitlab.com/fenix-token"))
  ;; Optional, but useful. See the variable documentation.
  ;; (lab-group "YOUR-GROUP-ID")
  :after gitlab)

(provide 'my-gitlab)
;;; my-gitlab.el ends here
