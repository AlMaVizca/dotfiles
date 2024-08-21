;;; my-org-addons --- org-mode extra packages
;;; Commentary:
;;; Code:

(use-package org-contrib
  :ensure t)

;;; TODO: Transition cleanup to org-roam
(use-package org-mind-map
  :disabled t
  :init
  (require 'ox-org)
  :ensure t
  ;; Uncomment the below if 'ensure-system-packages` is installed
  ;;:ensure-system-package (gvgen . graphviz)
  :config
  (setq org-mind-map-engine "dot")      ; Default. Directed Graph
  ;; (setq org-mind-map-engine "neato")  ; Undirected Spring Graph
  ;; (setq org-mind-map-engine "twopi")  ; Radial Layout
  ;; (setq org-mind-map-engine "fdp")    ; Undirected Spring Force-Directed
  ;; (setq org-mind-map-engine "sfdp")   ; Multiscale version of fdp for the layout of large graphs
  ;; (setq org-mind-map-engine "twopi")  ; Radial layouts
  ;; (setq org-mind-map-engine "circo")  ; Circular Layout
  )

;; TODO: evaluate org-modern heading bullet
(use-package org-modern
  :ensure t
  ;; :disabled t
  ;;:hook (org-mode . org-modern-mode)
  :config
  (dolist (face '(window-divider
                  window-divider-first-pixel
                  window-divider-last-pixel))
    (face-spec-reset-face face)
    (set-face-foreground face (face-attribute 'default :background)))
  (set-face-background 'fringe (face-attribute 'default :background))

  (setq
   org-auto-align-tags nil
   org-tags-column 0
   org-catch-invisible-edits 'show-and-error
   org-special-ctrl-a/e t
   org-insert-heading-respect-content t

   ;; Org styling, hide markup etc.
   org-hide-emphasis-markers t
   org-pretty-entities t

   ;; Agenda styling
   org-agenda-tags-column 0
   org-agenda-block-separator ?─
   org-agenda-time-grid
   '((daily today require-timed)
     (800 1000 1200 1400 1600 1800 2000)
     " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
   org-agenda-current-time-string
   "◀── now ─────────────────────────────────────────────────"
   org-ellipsis " ▾"
   org-src-fontify-natively t
   org-fontify-quote-and-verse-blocks t
   org-src-tab-acts-natively t
   org-edit-src-content-indentation 2
   org-hide-block-startup nil
   org-src-preserve-indentation nil
   org-startup-folded 'content
   org-cycle-separator-lines 2
   fill-column 80
   org-export-with-title nil
   org-html-content-class "container"
   org-modern-fold-stars '(("◉" . "○")
                           ("◉" . "○")
                           ("●" . "○")
                           ("●" . "○")
                           ("●" . "○"))
   )
  (set-face-attribute 'org-ellipsis nil :inherit 'default :box nil)
  (global-org-modern-mode)
  )

(use-package org-modern-indent
  :ensure (:protocol https :host github :repo "jdtsmith/org-modern-indent")
  :config ; add late to hook
  (add-hook 'org-mode-hook #'org-modern-indent-mode 90))

;; TODO: Cleanup - setted up on org-modern
(use-package org-superstar
  :ensure t
  :after org
  :hook (org-mode . org-superstar-mode)
  :custom
  (org-superstar-remove-leading-stars t)
  (org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●")))

;; Pomodoro technique
(use-package org-pomodoro
  :ensure t
  :after org
  :config
  (setq org-pomodoro-start-sound "~/.dotfiles/.emacs.d/sounds/focus_bell.wav")
  (setq org-pomodoro-short-break-sound "~/.dotfiles/.emacs.d/sounds/three_beeps.wav")
  (setq org-pomodoro-long-break-sound "~/.dotfiles/.emacs.d/sounds/three_beeps.wav")
  (setq org-pomodoro-finished-sound "~/.dotfiles/.emacs.d/sounds/meditation_bell.wav")
  )

(use-package emacsql-sqlite
  :ensure t)

(use-package toc-org
  :ensure t)

(use-package org-ref
  :ensure t)

(use-package org-cliplink
  ;; Insert links with org-mode format from the clipboard
  :ensure t
  :config
  (global-set-key (kbd "C-x p i") 'org-cliplink))

(use-package org-download
  ;;; Files customization
  ;;;  -*- mode: Org; org-download-image-dir: "~/Pictures/foo"; -*-
  :ensure t
  :hook (dired-mode-hook . org-download-enable))

(use-package org-transclusion
  :ensure t
  :after org
  :bind (:map global-map
              ("<f12>" . org-transclusion-add)
              ;; ("C-n t" . org-transclusion-mode)
              ))

(use-package org-super-agenda
  :ensure t
  :custom
  (org-super-agenda-groups
   '((:auto-map (lambda (item)
                  (-when-let* ((marker (or (get-text-property 0 'org-marker item)
                                           (get-text-property 0 'org-hd-marker item)))
                               (file-path (->> marker marker-buffer buffer-file-name))
                               (directory-name (->> file-path file-name-directory directory-file-name file-name-nondirectory)))
                    (concat "Directory: " directory-name))))))
  (org-super-agenda-mode t)
  )


(use-package ob-typescript
  :ensure t
  :config
  (add-to-list 'org-babel-load-languages
               '(typescript . t))
  )

(use-package ob-kotlin
  :ensure t
  :config
  (add-to-list 'org-babel-load-languages
               '(kotlin . t))
  )

(use-package ob-php
  :ensure t
  :config
  (add-to-list 'org-babel-load-languages
               '(php . t))
  )

(use-package ob-redis
  :ensure t
  :config
  (add-to-list 'org-babel-load-languages
               '(redis . t))
  )

;; TODO: Check
(use-package ob-browser
  :ensure t
  :config
  (add-to-list 'org-babel-load-languages
               '(browser . t))
  )

(use-package ob-mermaid
  :ensure t)

(use-package restclient
  :ensure t)

(use-package ob-restclient
  :ensure t
  :config
  (add-to-list 'org-babel-load-languages
               '(restclient . t))
  )

(use-package ob-async
  :ensure t)

;; TODO: Integrate with personal yat.sh sessions
(use-package ob-tmux
  :ensure t
  :custom
  ;; (org-babel-default-header-args:tmux
  ;;  '((:results . "silent")         ;
  ;;    (:session . "default")        ; The default tmux session to send code to
  ;;    (:socket  . nil)))            ; The default tmux socket to communicate with
  ;; The tmux sessions are prefixed with the following string.
  ;; You can customize this if you like.
  (org-babel-tmux-session-prefix nil)
  ;; The terminal that will be used.
  ;; You can also customize the options passed to the terminal.
  ;; The default terminal is "gnome-terminal" with options "--".
  ;; (org-babel-tmux-terminal "xterm") ????
  (org-babel-tmux-terminal-opts nil)
  :config
  (add-to-list 'org-babel-load-languages
               '(tmux . t))
  ;; Don't open a window after the execution
  (add-to-list 'display-buffer-alist
               (cons "\\*Async Shell Command\\*.*" (cons #'display-buffer-no-window nil)))
  )

;; Writing beamer presentations in org-mode
;;https://orgmode.org/worg/exporters/beamer/tutorial.html
(require 'ox-beamer)

;; TODO: review enable elpaca
(use-package ox-gfm
  ;; Github Flavored Markdown exporter for Org Mode
  :ensure (:wait t))

(use-package org-sidebar
  :ensure (:protocol https :host github :repo "alphapapa/org-sidebar"))

(provide 'my-org-addons)
;;; my-org-addons.el ends here
