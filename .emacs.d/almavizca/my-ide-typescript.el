;;; my-ide-typescript -- Javascript & Typescript settings
;;; Commentary: custom settings
;; Code
(use-package tide
  :ensure (:wait t)
  :after (typescript-mode javascript-mode)
  :hook
  ((typescript-mode . tide-setup)
   (typescript-mode . tide-hl-identifier-mode))
  :custom
  (tide-hl-identifier-idle-time 0.3)
  (tide-always-show-documentation t)
  (tide-completion-detailed t)
  (tide-completion-ignore-case t)
  (tide-completion-show-source t)
  (tide-user-preferences '(:importModuleSpecifierPreference "relative")))

(defun typescript-save ()
  "format typescript code before save with prettier."
  (when (eq major-mode 'typescript-mode)
    (tide-organize-imports)))

(use-package typescript-mode
  :mode "\\.ts\\'"
  :config
  (setq typescript-indent-level 2)
  ;; (require 'dap-node)
  ;; (dap-node-setup)
  )

;; (add-hook 'before-save-hook 'typescript-prettier)
;; (add-hook 'before-save-hook 'typescript-save)

(use-package prettier-js
  :ensure  t
  :custom
  (prettier-js-args '(
                      "--trailing-comma" "all"
                      "--bracket-spacing" "true"
                      "--single-quote" "true"
                      ))
  (prettier-js-mode nil)
  :hook
  ((javascript-mode . prettier-js-mode)
   (typescript-mode . prettier-js-mode)))

;;; Angular
;; (require 'bookmark)
;; (setq
;;  angular-modules (bookmark-get-filename "angular-modules")
;;  angular-language-server (concat angular-modules "@angular/language-server")
;;  lsp-clients-angular-language-server-command
;;  `("node"
;;    ,angular-language-server
;;    "--ngProbeLocations"
;;    ,angular-modules
;;    "--tsProbeLocations"
;;    ,angular-modules
;;    "--stdio"))

;; (use-package angular-mode
;;   :ensure t
;;   :hook
;;   (angular-mode . lsp-mode))

;; (use-package angular-snippets
;;              angular-snippets
;;   :ensure t)

(use-package js2-mode
  :ensure t
  :hook (
         ;; (js2-mode . js2-imenu-extra-mode)
         (js2-mode . tide-setup)
         (js2-mode . js2-minor-mode)
         (js2-mode . prettier-js-mode)
         )
  :init (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))

(use-package js2-refactor
  :ensure t)

(provide 'my-ide-typescript)
;;; my-ide-typescript.el ends here
