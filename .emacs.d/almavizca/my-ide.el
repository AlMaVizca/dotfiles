;;; my-ide --- Configurations
;;; Commentary:


(use-package ivy
  :ensure t
  :custom
  (ivy-use-virtual-buffers t)
  (enable-recursive-minibuffers t)
  (ivy-use-selectable-prompt t)
  :config
  (ivy-mode)
  )

(use-package ivy-rich
  :ensure t)

(use-package ivy-fuz
  :ensure t)

(use-package ivy-pass
  :ensure t)

(use-package fill-column-indicator
  ;; Display a line at 80 characters width
  :ensure  t
  :custom
  (fill-column 80))

;; (require 'my-python)
(require 'my-ide-html)

;; Custom LSP Environments
;; (require 'my-lsp)
;; (require 'my-eglot)


(use-package magit
  :ensure t
  )

(use-package magit-todos
  :ensure t
  ;; Notes
  ;;; There is an error due to (cl-defun magit-todos--git-diff-callback (&key magit-status-buffer results-regexp search-regexp-elisp process heading exclude-globs &allow-other-keys
  ;;; receiving heading as nil and is overwriting magit-todos-section-heading
  ;;; Causing propertize to be called with a nil string
  :config
  (magit-todos-mode)
  )


;; (use-package magithub
;;   :after magit
;;   :ensure t
;;   :config (magithub-feature-autoinject t))


(use-package forge
  :ensure t
  :after magit
  ;;; modify dimmer to avoid error with reset variable
  ;; https://github.com/gonewest818/dimmer.el/issues/68#issuecomment-2053620377
  )
;; (require 'my-dashboard)

(use-package company
  :ensure t
  :hook
  (
   (typescript-mode . company-mode)
   )

  :bind
  (:map company-active-map
        ("<tab>" . company-complete-selection))
  ;; (:map lsp-mode-map
  ;;       ("<tab>" . company-indent-or-complete-common))

  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0)
  (company-show-numbers t)
  (company-tooltip-align-annotations t)
  )

(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode)
  )

(use-package eldoc
  :ensure (:wait t)
  :hook
  (
   (typescript-mode . eldoc-mode)
   )
  )

(use-package php-eldoc
  :ensure t)

;; (use-package ac-php-core
;;   :ensure t)

;; (use-package ac-php
;;   :ensure t)

;;; TODO
(use-package company-php
  :ensure t
  :disabled t
  )


;; TODO: review focus mode
;; (use-package focus
;;   :ensure t
;;   :hook
;;   (
;;    (javascript-mode . focus-mode)
;;    (typescript-mode . focus-mode)
;;    )
;;   )

(use-package flycheck
  :ensure (:wait t)
  :hook
  ((typescript-mode . flycheck-mode)))

(use-package flymake-jslint
  :ensure t)

(use-package flymake-json
  :ensure t)

(use-package flymake-less
  :ensure t)

(use-package flymake-python-pyflakes
  :ensure t)

(use-package flymake-shell
  :ensure t)

(use-package flymake-yaml
  :ensure t)

(use-package ioccur
  :ensure t)

(require 'my-ide-projects)

;; TODO: perspective

(use-package web-mode
  :ensure t
  :mode
  (
   ("\\.html?\\'" . web-mode)
   ("\\.tsx\\'" . web-mode)
   )
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-block-padding 2
        web-mode-comment-style 2

        web-mode-enable-css-colorization t
        web-mode-enable-auto-pairing t
        web-mode-enable-comment-keywords t
        web-mode-enable-current-element-highlight t
        )
  (add-hook 'web-mode-hook
            (lambda ()
              (when (string-equal "tsx" (file-name-extension buffer-file-name))
                ))))

(use-package impostman
  :ensure t
  :commands impostman-import-file)

;;; Yasnippets
(use-package yasnippet
  :ensure t
  :hook
  (prog-mode . yas-global-mode))

(use-package yasnippet-snippets
  :ensure t
  :after yasnippet)

(use-package ivy-yasnippet
  :ensure t)

;; Ctags
(defun build-ctags ()
  (interactive)
  (message "building project tags")
  (let ((root (eproject-root)))
    (shell-command (concat "ctags -e -R --exclude=.git -f " root "TAGS " root)))
  (message "tags built successfully"))

(use-package wakatime-mode
  :ensure t
  :custom
  (wakatime-api-key (password-store-get-field "Work/wakatime.com/contact@almavizca.xyz" "token"))
  (wakatime-cli-path "/home/krahser/.asdf/shims/wakatime")
  :config
  (global-wakatime-mode t)
  )

(provide 'my-ide)
;;; my-ide.el ends here
