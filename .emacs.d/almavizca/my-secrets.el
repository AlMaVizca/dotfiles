;;; my-secrets - secrets settings
;;; Commentary: auth sources and tokens

;; TODO
(use-package pass
  :ensure t
  :straight t
  )

(use-package password-store
  :ensure t)

(use-package password-store-otp
  :ensure t)


(require 'auth-source-pass)
(auth-source-pass-enable)
(setq auth-sources '("~/Repositories/dotfiles/emacs.d/authinfo.gpg" password-store))

(setq
 ;; bitly
 bitly-access-token (password-store-get "Work/bitly.com/token")
 )

(provide 'my-secrets)
;;; my-secrets ends here.
