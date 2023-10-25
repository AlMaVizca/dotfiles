;;; my-ansible --- Helpers for ansible
;;; Commentary: required packages and configurations
;;; Code:

(use-package ansible
  :ensure t)

(use-package ansible-doc
  :ensure t)

(use-package ansible-vault
  :ensure t)

(use-package company-ansible
  :ensure t)


(provide 'my-ansible)
;;; my-ansible ends here
