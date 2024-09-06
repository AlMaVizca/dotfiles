;;; my-system --- System management
;;; Commentary: system settings

;;; General settings
(require 'my-bookmarks)
(require 'my-secrets)
(require 'my-daemon)
(require 'my-keybindings)
(require 'my-shell)
(require 'my-networking)

(setq
 enable-remote-dir-locals t
 ;; Follow symlinks without ask
 vc-follow-symlinks t
 ;; Disable reopen buffers
 desktop-save-mode nil
 ;; debug errors
 debug-on-error t
 debug-on-signal nil
 file-name-history '()
 )
(remove-hook 'after-init-hook 'savehist-hook t)
(remove-hook 'after-init-hook 'recentf-mode t)

;;; Reading and writing tools
(require 'my-langtool)
(require 'my-email)
(require 'my-blog)
(require 'my-org-addons)
(use-package pocket-reader
  :ensure t)

(add-hook 'before-save-hook 'delete-trailing-whitespace)
;; Automatic line breaking
(add-hook 'text-mode-hook 'auto-fill-mode)
(add-hook 'markdown-mode-hook 'auto-fill-mode)
;; Fix acute
(require 'iso-transl)

;;; IT Tools
(require 'my-ai)
(require 'my-docker)
(require 'my-gitlab)
(require 'my-ide)
(require 'my-ide-typescript)
(require 'my-cloud-management)

(require 'my-theme)
(use-package xclip
  ;; Integrated clipboard
  :ensure t
  :config
  (xclip-mode +1)
  (setq
   x-select-enable-clipboard t
   x-select-enable-primary t
   x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)
   x-stretch-cursor t))

(provide 'my-system)
;;; my-system.el ends here
