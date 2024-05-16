;;; package --- my-langtool
;;; Commentary:
;;; Code:

(use-package langtool
  :ensure t
  :commands langtool-check
  :config
  (setq langtool-http-server-host "langtool.docker"
        langtool-http-server-port 8010))

(provide 'my-langtool)
;;; my-langtool.el ends here
