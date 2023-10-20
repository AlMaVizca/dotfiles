;;; my-kubernetes --- Configurations
;;; Commentary:

(use-package k8s-mode
  :ensure t)

(use-package kubedoc
  :ensure t)

(use-package kubernetes
  :ensure t
  :commands (kubernetes-overview)
  :config
  (setq kubernetes-poll-frequency 3600
        kubernetes-redraw-frequency 3600))

(provide 'my-kubernetes)
;;; my-kubernetes.el ends here
