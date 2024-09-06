;;; my-cloud-management -- Tools to provision or manage instances
;;; Commentary:
;; Administration tools for devops tasks
;;; Code:
(require 'my-ansible)
(require 'my-kubernetes)

;; Terraform packages
(use-package company-terraform
  :ensure t)

(use-package terraform-mode
  :ensure t)

(use-package terraform-doc
  :ensure t)


(provide 'my-cloud-management)
;;; my-cloud-management.el ends here
