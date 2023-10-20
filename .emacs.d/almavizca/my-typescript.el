;;; my typescript
;;; custom settings
;; Code
(use-package tide
  :ensure t
  :after (typescript-mode)
  :hook
  (
   (typescript-mode . tide-setup)
   (typescript-mode . tide-hl-identifier-mode)
   )
  :custom
  (tide-hl-identifier-idle-time 0.3)
  (tide-always-show-documentation t)
  (tide-completion-detailed t)
  (tide-completion-ignore-case t)
  (tide-completion-show-source t)
  (tide-user-preferences '(:importModuleSpecifierPreference "relative"))
  )


(defun typescript-save ()
  "format typescript code before save with prettier."
  (when (eq major-mode 'typescript-mode)
    (tide-organize-imports)
    ))




(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook
  (
   (typescript-mode . prettier-js-mode)
   )
  :config
  (setq typescript-indent-level 2)
  (require 'dap-node)
  (dap-node-setup)
  )




;; (setq tide-tsserver-executable "node_modules/typescript/bin/tsserver")


;; (add-hook 'before-save-hook 'typescript-prettier)
;; (add-hook 'before-save-hook 'typescript-save)
(require 'bookmark)

(setq
 angular-modules (bookmark-get-filename "angular-modules")
 angular-language-server (concat angular-modules "@angular/language-server")
 lsp-clients-angular-language-server-command
 `("node"
   ,angular-language-server
   "--ngProbeLocations"
   ,angular-modules
   "--tsProbeLocations"
   ,angular-modules
   "--stdio"))

(use-package angular-mode
  :ensure t
  :hook
  (angular-mode . lsp-mode))

;; (use-package angular-snippets
;;              angular-snippets
;;   :ensure t)




(provide 'my-typescript)
;;; my-typescript.el ends here
