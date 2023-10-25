;;; my-ide --- Configurations
;;; Commentary:

(use-package ivy
  :ensure t
  :config
  (ivy-mode)
  )

(use-package fill-column-indicator
  :ensure  t
  :custom
  (fill-column 80)
  )

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; fix acute
(require 'iso-transl)

(setq-default history-length 500)
(setq
 enable-remote-dir-locals t
 ;; Follow symlinks without ask
 vc-follow-symlinks t
 ;; debug errors
 debug-on-error t
 )

;; TODO: Review
;; Open file under cursor
(defun jump-local-file ()
  (interactive)
  (find-file
   ( thing-at-point 'filename)
   )
  )
;; (global-set-key (kbd "M-.") 'jump-local-file)


(add-hook 'text-mode-hook 'auto-fill-mode)
(add-hook 'markdown-mode-hook 'auto-fill-mode)


;; (require 'bash-completion)
;; (bash-completion-setup)


;; (require 'my-python)
(require 'my-html)
;;(require 'my-treemacs)

;; TODO
;; (use-package npm
;;   :ensure t)

;; Custom LSP Environments
(require 'my-typescript)
(require 'my-lsp)
;; (require 'my-eglot)

(use-package magit-todos
  :ensure t
  :straight t
  )

(use-package magit
  :ensure t
  :straight t
  :config
  (magit-todos-mode)
  )

;; (use-package magithub
;;   :after magit
;;   :ensure t
;;   :config (magithub-feature-autoinject t))

(use-package forge
  :ensure t
  :straight t
  :after magit
  )
;; (require 'my-dashboard)

;; (require 'my-grammarly)

;;; TODO
(use-package company-tabnine
  :ensure t
  :disabled t
  )

;; (add-to-list 'company-backends #'company-tabnine)


(use-package company
  :straight  t
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
  :straight  t
  :hook (company-mode . company-box-mode)
  )

(use-package eldoc
  :ensure t
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


(use-package prettier-js
  :ensure  t
  :custom
  (prettier-js-args '(
                      "--trailing-comma" "all"
                      "--bracket-spacing" "true"
                      "--single-quote" "true"
                      )
                    )
  (prettier-js-mode nil)
  :hook
  (
   (javascript-mode . prettier-js-mode)
   (typescript-mode . prettier-js-mode)
   )
  )

(use-package focus
  :ensure t
  :hook
  (
   (javascript-mode . focus-mode)
   (typescript-mode . focus-mode)
   )
  )

(use-package flycheck
  :ensure t
  :hook
  (
   (typescript-mode . flycheck-mode)
   )

  )

(require 'my-projectile)

(use-package perspective
  :straight t
  :bind
  ("C-x C-b" . persp-list-buffers) ; or use a nicer switcher, see below
  :custom
  (persp-mode-prefix-key (kbd "C-z"))  ; pick your own prefix key here
  :init
  (persp-mode)
  :hook
  (kill-emacs . persp-state-save)
  )

(use-package js2-mode
  :straight t)

(use-package js2-refactor
  :straight t)

(use-package web-mode
  :straight  t
  :mode
  (
   ("\\.html?\\'" . web-mode)
   ("\\.tsx\\'" . web-mode)
   ("\\.jsx\\'" . web-mode)
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
                )))
  ;; (flycheck-add-mode 'typescript-tslint 'web-mode)
  )


(require 'my-makefile-runner)

(require 'my-ai)
(require 'my-ansible)

(use-package impostman
  :ensure t)

(use-package alert
  :ensure t)

(require 'my-services)
(require 'url)
(provide 'my-ide)
;;; my-ide.el ends here
