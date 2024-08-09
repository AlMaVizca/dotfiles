;;; my-ansible --- Helpers for ansible
;;; Commentary:
;;; Code:

(use-package ansible
  :ensure t)

(use-package ansible-doc
  :ensure t
  :after ansible)

(use-package ansible-vault
  :ensure t
  ;; :init
  ;; (setq
  ;;  ansible-vault-password-file "~/.vault_pass.txt"
  ;;  ansible-vault-command "ansible-vault"
  ;;  )
  :after ansible)

(use-package company-ansible
  :ensure t
  :after ansible)

(provide 'my-ansible)
;;; my-ansible.el ends here
