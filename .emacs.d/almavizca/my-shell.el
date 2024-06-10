;;; my-shell -- Shell customizations
;;; Commentary:
;; Special shell configurations

;;; Code:
(use-package vterm
  :ensure t
  :commands vterm
  :bind (:map vterm-mode-map
              ([mouse-1] . nil)
              ([mouse-2] . nil)
              ([mouse-3] . nil)
              ([mouse-4] . nil)
              ([mouse-5] . nil)
              ))

(use-package multi-vterm
  :ensure t
  :commands multi-vterm multi-vterm-dedicated-toggle
  :bind (
         ("º" . multi-vterm-dedicated-toggle)
         ("C-c º" . multi-vterm-project)
         ("C-c s" . multi-vterm)
         ("C-<prior>" . multi-vterm-prev)
         ("C-<next>" . multi-vterm-next)
         ([mouse-1] . nil))
  :custom
  (multi-vterm-dedicated-window-height 15)
  (multi-vterm-buffer-name daemon-name)
  (multi-term-default-dir (bookmark-get-filename daemon-name)))

(provide 'my-shell)
