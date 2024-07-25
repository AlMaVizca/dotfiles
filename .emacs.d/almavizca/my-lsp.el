;;; my lsp
;;; custom settings
;; Code


(defun efs/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(setenv "SNYK_TOKEN" (password-store-get "Work/snyk.io-token"))
(defun register-snyk ()
  (lsp-register-client
   (make-lsp-client
    :server-id 'snyk-ls

    ;; The "-o" option specifies the issue format, I prefer markdown over HTML
    :new-connection (lsp-stdio-connection '("snyk-ls" "-o" "md"))

    ;; Change this to the modes you want this in; you may want to include the
    ;; treesitter versions if you're using them
    :major-modes '(python-mode typescript-mode)

    ;; Allow running in parallel with other servers. This is why Eglot isn't an
    ;; option right now
    :add-on? t

    :initialization-options
    (lambda ()
      (list :integrationName "Emacs"
            :integrationVersion (emacs-version)

            ;; Enable these features only if available for your organization.
            ;; Note: these are strings, not booleans; that's what the server
            ;; expects for whatever reason
            :activateSnykCodeSecurity "true"
            :activateSnykCodeQuality "true"

            ;; List trusted folders here to avoid repeated permission requests
            :trustedFolders [])))))

(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-keymap-prefix "C-c l") ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t)
  ;; (add-hook 'c++-mode-hook #'lsp)
  (add-hook 'python-mode-hook #'lsp)
  (register-snyk)
  :hook
  '(
    (lsp-mode . yas-minor-mode)
    (lsp-mode . efs/lsp-mode-setup)))
;; (use-package lsp-docker
;;   :config
;;   (defvar lsp-docker-client-packages
;;     '(lsp-css lsp-clients lsp-bash lsp-go lsp-pylsp lsp-html lsp-typescript
;;               lsp-terraform lsp-clangd))

;;   (setq lsp-docker-client-configs
;;         '((:server-id bash-ls :docker-server-id bashls-docker :server-command "bash-language-server start")
;;           (:server-id clangd :docker-server-id clangd-docker :server-command "clangd")
;;           (:server-id css-ls :docker-server-id cssls-docker :server-command "css-languageserver --stdio")
;;           (:server-id gopls :docker-server-id gopls-docker :server-command "gopls")
;;           (:server-id html-ls :docker-server-id htmls-docker :server-command "html-languageserver --stdio")
;;           (:server-id pylsp :docker-server-id pyls-docker :server-command "pylsp")
;;           (:server-id ts-ls :docker-server-id tsls-docker :server-command "typescript-language-server --stdio")))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :hook
  (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-position 'bottom)
  )

(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

(use-package php-mode
  :ensure t
  :hook ((php-mode . lsp-deferred)))

(setq
 lsp-clients-typescript-preferences nil
 lsp-intelephense-global-storage-path "/opt/lsp/intelephense"
 lsp-intelephense-licence-key nil
 lsp-intelephense-multi-root t
 lsp-intelephense-storage-path "/opt/lsp/lsp-cache"
 lsp-javascript-preferences-import-module-specifier "relative"
 lsp-typescript-preferences-import-module-specifier "relative"
 lsp-typescript-suggest-complete-function-calls t)


;; (lsp-register-client
;;  (make-lsp-client :new-connection
;;                   (lsp-tramp-connection
;;                    (lambda ()
;;                      `(,(lsp-package-path 'typescript-language-server)
;;                        "--tsserver-path"
;;                        ,"/home/node/node_modules/.bin/tsserver"
;;                        ,@lsp-clients-typescript-server-args))
;;                    )
;;                   :major-modes '(typescript-mode)
;;                   :remote? t
;;                   :activation-fn 'lsp-typescript-javascript-tsx-jsx-activate-p
;;                   :priority -2
;;                   :completion-in-comments? t
;;                   :initialization-options (lambda ()
;;                                             (append
;;                                              (when lsp-clients-typescript-disable-automatic-typing-acquisition
;;                                                (list :disableAutomaticTypingAcquisition lsp-clients-typescript-disable-automatic-typing-acquisition))
;;                                              (when lsp-clients-typescript-log-verbosity
;;                                                (list :logVerbosity lsp-clients-typescript-log-verbosity))
;;                                              (when lsp-clients-typescript-max-ts-server-memory
;;                                                (list :maxTsServerMemory lsp-clients-typescript-max-ts-server-memory))
;;                                              (when lsp-clients-typescript-npm-location
;;                                                (list :npmLocation lsp-clients-typescript-npm-location))
;;                                              (when lsp-clients-typescript-plugins
;;                                                (list :plugins lsp-clients-typescript-plugins))
;;                                              (when lsp-clients-typescript-preferences
;;                                                (list :preferences lsp-clients-typescript-preferences))))
;;                   :initialized-fn (lambda (workspace)
;;                                     (with-lsp-workspace workspace
;;                                       (lsp--set-configuration
;;                                        (ht-merge (lsp-configuration-section "javascript")
;;                                                  (lsp-configuration-section "typescript")
;;                                                  (lsp-configuration-section "completions")
;;                                                  (lsp-configuration-section "diagnostics"))))
;;                                     (let ((caps (lsp--workspace-server-capabilities workspace))
;;                                           (format-enable (or lsp-javascript-format-enable lsp-typescript-format-enable)))
;;                                       (lsp:set-server-capabilities-document-formatting-provider? caps format-enable)
;;                                       (lsp:set-server-capabilities-document-range-formatting-provider? caps format-enable)))
;;                   :after-open-fn (lambda ()
;;                                    (when lsp-javascript-display-inlay-hints
;;                                      (lsp-javascript-inlay-hints-mode)))
;;                   :ignore-messages '("readFile .*? requested by TypeScript but content not available")
;;                   :server-id 'ts-ls-remote
;;                   :request-handlers (ht ("_typescript.rename" #'lsp-javascript--rename))
;;                   )
;;  )

;; (lsp-register-client
;;  (make-lsp-client :new-connection (lsp-tramp-connection
;;                                    (lambda ()
;;                                      `(,(or (executable-find
;;                                              (cl-first lsp-intelephense-server-command))
;;                                             "intelephense")
;;                                        ,@(cl-rest lsp-intelephense-server-command)))
;;                                    )
;;                   :activation-fn (lsp-activate-on "php")
;;                   :priority -1
;;                   :remote? t
;;                   :notification-handlers (ht ("indexingStarted" #'ignore)
;;                                              ("indexingEnded" #'ignore))
;;                   :initialization-options (lambda ()
;;                                             (list :storagePath lsp-intelephense-storage-path
;;                                                   :globalStoragePath lsp-intelephense-global-storage-path
;;                                                   :licenceKey lsp-intelephense-licence-key
;;                                                   :clearCache lsp-intelephense-clear-cache))
;;                   :multi-root lsp-intelephense-multi-root
;;                   :completion-in-comments? t
;;                   :server-id 'iph-remote
;;                   :download-server-fn (lambda (_client callback error-callback _update?)
;;                                         (lsp-package-ensure 'intelephense
;;                                                             callback error-callback))
;;                   :synchronize-sections '("intelephense")))
;;
;; (use-package dap-mode
;;   :ensure  t
;; Uncomment the config below if you want all UI panes to be hidden by default!
;; :custom
;; (lsp-enable-dap-auto-configure nil)
;; :config
;; (dap-ui-mode 1)

;; :config
;; Set up Node debugging
;; (require 'dap-node)
;; (dap-node-setup) ;; Automatically installs Node debug adapter if needed

;; Evaluate generic dap
;; (dap-register-debug-template
;;  "Nestjs::dashboard"
;;  (list
;;   :name "Nestjs::dashboard"
;;   :type "node"
;;   :request "launch"
;;   :cwd "/home/krahser/Work/service"
;;   :envFile "/home/krahser/Work/service-dap.ini"
;;   :args `("/home/krahser/Work/service/src/main.ts")
;;   :runtimeArgs `(
;;                  "--nolazy",
;;                  "-r",
;;                  "ts-node/register",
;;                  "-r",
;;                  "tsconfig-paths/register"
;;                  )
;;   :outFiles `("/home/krahser/Work/service/dist/**/*.js")
;;   )
;;  )


;; Bind `C-c l d` to `dap-hydra` for easy access
;; (general-define-key
;;  :keymaps 'lsp-mode-map
;;  :prefix lsp-keymap-prefix
;;  "d" '(dap-hydra t :wk "debugger"))
;; )


;; (setup (:pkg dap-mode )
;;        ;; Assuming that `dap-debug' will invoke all this
;;        (:when-loaded
;;         (:option lsp-enable-dap-auto-configure nil)
;;         (dap-ui-mode 1)
;;         (dap-tooltip-mode 1)
;;         (dap-node-setup)))





(provide 'my-lsp)
;;; my-lsp.el ends here
