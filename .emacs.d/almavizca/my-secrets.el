;;; my-secrets --- secrets settings
;;; Commentary:
;;; Code:

(use-package password-store
  :ensure (:protocol https
                     :host github
                     :repo "zx2c4/password-store"
                     :files (:defaults "/contrib/emacs/*")
                     )
  )

(use-package password-store-otp
  :ensure (:protocol https :host github :repo "realcomplex/password-store-otp.el")
  )

(use-package pass
  :ensure t
  :after password-store-otp)

(require 'auth-source-pass)
(auth-source-pass-enable)
(setq
 auth-sources '("~/Repositories/dotfiles/emacs.d/authinfo.gpg" password-store)
 )

(fset 'epg-wait-for-status 'ignore)

(provide 'my-secrets)
;;; my-secrets.el ends here.
