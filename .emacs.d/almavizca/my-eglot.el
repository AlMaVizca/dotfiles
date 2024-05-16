;;; my-eglot --- Eglot settings
;;; Commentary:

;; Code
(use-package eglot
  :ensure t
  :hook
  ((typescript-mode . eglot-ensure)
   (python-mode . eglot-ensure))
  :config
  ;; (add-to-list 'eglot-server-programs
  ;;              '((typescript-mode) "typescript-language-server" "--stdio")
  ;;              '((js-mode) "typescript-language-server" "--stdio")
  ;;              )
  )

;;'((php-mode) "intelephense" "--stdio")

(defun typescript-save ()
  "format typescript code before save with prettier."
  (when (eq major-mode 'typescript-mode)
    (eglot-code-action-organize-imports)))

(provide 'my-eglot)
;;; my-eglot.el ends here
