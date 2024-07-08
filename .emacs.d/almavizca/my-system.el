;;; my-system --- System management
;;; Commentary: system settings

;;; General settings
(require 'my-packages)
(require 'my-bookmarks)
(require 'my-secrets)
(require 'my-theme)
(require 'my-daemon)
(require 'my-keybindings)
(require 'my-shell)
(require 'my-networking)

(setq
 enable-remote-dir-locals t
 ;; Follow symlinks without ask
 vc-follow-symlinks t
 ;; debug errors
 debug-on-error t
 debug-on-signal nil
 )

;;; Reading and writing tools
(require 'my-org)
(require 'my-langtool)
(require 'my-email)
(require 'my-blog)
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
(require 'my-ansible)
(require 'my-docker)
(require 'my-gitlab)
(require 'my-ide)
(require 'my-kubernetes)

(use-package xclip
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
