;;; my-langtool - Custom settings for language tool
;;; Commentary:
;;; Code:

(use-package langtool
  :ensure t
  :commands langtool-check
  :config
  (setq langtool-http-server-host "api.languagetoolplus.com"
        langtool-http-server-port 443
        langtool-http-server-stream-type 'tls
        langtool-http-username "aldo.vizcaino87@gmail.com"
        langtool-http-apiKey (password-store-get "Education/languagetool.org/languagetool.org-token")
        langtool-level 'picky
        ))

(provide 'my-langtool)
;;; my-langtool.el ends here
