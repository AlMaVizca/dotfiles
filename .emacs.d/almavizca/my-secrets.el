;;; my-secrets --- secrets settings
;;; Commentary:
;;; Code:

(use-package pass
  :ensure t
  :straight t)

(use-package ivy-pass
  :ensure t)

(use-package password-store
  :ensure t)

(use-package password-store-otp
  :ensure t)

(require 'auth-source-pass)
(auth-source-pass-enable)
(setq
 auth-sources '("~/Repositories/dotfiles/emacs.d/authinfo.gpg" password-store)
 bitly-access-token (password-store-get "Work/bitly.com/token")
 )

(fset 'epg-wait-for-status 'ignore)

(provide 'my-secrets)
;;; my-secrets.el ends here.
