;;; package --- my-langtool
;;; Commentary: My langtool setup

(use-package langtool
  :ensure t
  :config
  (setq langtool-http-server-host "langtool.localdev"
        langtool-http-server-port 8010)

  )


(provide 'my-langtool)
;;; my-langtool ends here
