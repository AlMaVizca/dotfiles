;;; my-eaf --- Integrate on local env


(use-package eaf
  :load-path "~/.emacs.d/site-lisp/emacs-application-framework"
  :custom
  (eaf-browser-continue-where-left-off t)
  (eaf-browser-enable-adblocker t)
  (browse-url-browser-function 'eaf-open-browser)
  :config
  (require 'eaf-pdf-viewer)
  (require 'eaf-file-sender)
  (require 'eaf-image-viewer)
  (require 'eaf-jupyter)
  (require 'eaf-markdown-previewer)
  (require 'eaf-video-player)
  (require 'eaf-git)
  (require 'eaf-terminal)
  (require 'eaf-rss-reader)
  (require 'eaf-mindmap)
  (require 'eaf-system-monitor)
  (require 'eaf-file-manager)
  (require 'eaf-vue-demo)
  (require 'eaf-org-previewer)
  (require 'eaf-camera)
  (require 'eaf-pdf-viewer)
  (require 'eaf-browser)
  (require 'eaf-airshare)

  (defalias 'browse-web #'eaf-open-browser)
  (eaf-bind-key scroll_up "C-n" eaf-pdf-viewer-keybinding)
  (eaf-bind-key scroll_down "C-p" eaf-pdf-viewer-keybinding)
  (eaf-bind-key take_photo "p" eaf-camera-keybinding)
  (eaf-bind-key nil "M-q" eaf-browser-keybinding))

(provide 'my-eaf)
;; my-eaf.el code ends here
