;;; my-socials --- Configurations
;;; Commentary: packages for social networks

(use-package ement
  :ensure t)

(use-package circe
  :ensure t
  :custom
  (circe-network-options
   `("Libera Chat"
     :tls t
     :nick (password-store-get-field "Work/libera.chat" "login")
     :sasl-username (password-store-get-field "Work/libera.chat" "login")
     :sasl-password (password-store-get "Work/libera.chat")
     :channels ()))
  )

(provide 'my-socials)
;; my-socials package ends here
