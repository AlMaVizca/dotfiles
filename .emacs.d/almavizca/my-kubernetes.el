;;; my-kubernetes --- Configurations
;;; Commentary:
;;; Code:

(use-package k8s-mode
  :ensure t
  :hook (k8s-mode . yas-minor-mode)
  ;; .dir-locals.el example to automatically load k8s for that proyect
  ;;((auto-mode-alist . (("\\.yaml\\'" . k8s-mode))))
  )

(use-package kubedoc
  :ensure t)

(use-package kubernetes
  :ensure t
  :config
  (setq kubernetes-poll-frequency 3600
        kubernetes-redraw-frequency 3600)
  (fset 'k8s 'kubernetes-overview)
  )

(provide 'my-kubernetes)
;;; my-kubernetes.el ends here
