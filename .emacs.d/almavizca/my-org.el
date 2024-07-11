;;; my-org -- personal customaization
;;; Commentary: Taken from system crafters

(require 'bookmark)
(setq  roam-directory (bookmark-get-filename "notes"))

;; Turn on indentation and auto-fill mode for Org files
(defun dw/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 1)
  (visual-line-mode 1)
  (diminish 'org-indent-mode)
  )

;; (use-package ox-org
;;   :ensure t
;;   )

;;; TODO
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

(defun org-publish-force ()
  (interactive)
  (org-publish-all t)
  )


(use-package org
  :straight t
  :ensure org-plus-contrib
  :defer t
  :hook
  (org-mode . dw/org-mode-setup)
  :custom
  (org-directory "~/Repository/Notes")
  (org-modules
   '(org-crypt
     org-habit
     ))
  (org-refile-targets '((nil :maxlevel . 1)
                        (org-agenda-files :maxlevel . 1)))
  (org-agenda-files '("~/Repositories/Notes/"))
  (org-agenda-list)
  (org-outline-path-complete-in-steps nil)
  (org-refile-use-outline-path t)
  (epa-file-encrypt-to "aldo.vizcaino87@gmail.com")

  :config
  (setq org-ellipsis " ▾"
        org-hide-emphasis-markers t
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

        )
  ;; org-export-preserve-breaks t

  (global-set-key (kbd "C-c C-p") 'org-publish-force)
  (use-package org-contrib
    :ensure t)

  (require 'ox-freemind)
  (require 'ox-beamer)
  (use-package ox-gfm
    :ensure t)
  (require 'ox-gfm)


  (use-package ob-typescript
    :ensure t)

  (use-package ob-kotlin
    :ensure t)

  (use-package ob-php
    :ensure t)

  (use-package ob-redis
    :ensure t)

  (use-package ob-browser
    :ensure t)

  (use-package ob-mermaid
    :ensure t)

  (use-package restclient
    :ensure t)

  (use-package ob-restclient
    :ensure t)


  (use-package ob-tmux
    :ensure t
    :custom
    (org-babel-default-header-args:tmux
     '((:results . "silent")       ;
       (:session . "default")      ; The default tmux session to send code to
       (:socket  . nil)))          ; The default tmux socket to communicate with
    ;; The tmux sessions are prefixed with the following string.
    ;; You can customize this if you like.
    (org-babel-tmux-session-prefix "ob-")
    ;; The terminal that will be used.
    ;; You can also customize the options passed to the terminal.
    ;; The default terminal is "gnome-terminal" with options "--".
    (org-babel-tmux-terminal "xterm")
    (org-babel-tmux-terminal-opts '("-T" "ob-tmux" "-e"))
    ;; Finally, if your tmux is not in your $PATH for whatever reason, you
    ;; may set the path to the tmux binary as follows:
    (org-babel-tmux-location "/usr/bin/tmux"))

  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (browser . t)
     (emacs-lisp . t)
     (kotlin . t)
     (makefile . t)
     (php . t)
     (python . t)
     (redis . t)
     (restclient . t)
     (sql . t)
     (sqlite . t)
     (typescript . t)
     ))

  (push '("conf-unix" . conf-unix) org-src-lang-modes)

  ;; NOTE: Subsequent sections are still part of this use-package block!

  (use-package org-superstar
    :ensure t
    :after org
    :hook (org-mode . org-superstar-mode)
    :custom
    (org-superstar-remove-leading-stars t)
    (org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●")))

  ;; Replace list hyphen with dot
  ;; (font-lock-add-keywords 'org-mode
  ;;                         '(("^ *\\([-]\\) "
  ;;                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Increase the size of various headings
  ;; ttc-iosevka-aile
  (set-face-attribute 'org-document-title t :font "Iosevka Aile" :weight 'bold :height 1.3)
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "Iosevka Aile" :weight 'medium :height (cdr face)))

  ;; Make sure org-indent face is available
  (require 'org-indent)

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :foreground "unspecified" :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

  ;; Get rid of the background on column views
  (set-face-attribute 'org-column nil :background "unspecified")
  (set-face-attribute 'org-column-title nil :background "unspecified")

  ;; TODO: Others to consider
  ;; '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
  ;; '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
  ;; '(org-property-value ((t (:inherit fixed-pitch))) t)
  ;; '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
  ;; '(org-table ((t (:inherit fixed-pitch :foreground "#83a598"))))
  ;; '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
  ;; '(org-verbatim ((t (:inherit (shadow fixed-pitch))))))

  ;; This is needed as of Org 9.2
  (require 'org-tempo)

  (add-to-list 'org-structure-template-alist '("sh" . "src sh"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("sc" . "src scheme"))
  (add-to-list 'org-structure-template-alist '("ts" . "src typescript"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("go" . "src go"))
  (add-to-list 'org-structure-template-alist '("yaml" . "src yaml"))
  (add-to-list 'org-structure-template-alist '("json" . "src json"))


  (use-package org-pomodoro
    :ensure t
    :after org
    :config
    (setq org-pomodoro-start-sound "~/.dotfiles/.emacs.d/sounds/focus_bell.wav")
    (setq org-pomodoro-short-break-sound "~/.dotfiles/.emacs.d/sounds/three_beeps.wav")
    (setq org-pomodoro-long-break-sound "~/.dotfiles/.emacs.d/sounds/three_beeps.wav")
    (setq org-pomodoro-finished-sound "~/.dotfiles/.emacs.d/sounds/meditation_bell.wav")
    )

  (defun dw/search-org-files ()
    (interactive)
    (counsel-rg "" roam-directory nil "Search Notes: "))
  )

(defun org-roam-folders ()

  (setq
   roam-journal (concat roam-directory "journal")
   roam-main (concat roam-directory "main")
   roam-personal (concat roam-directory "personal")
   roam-nature (concat roam-directory "nature")
   roam-blog (bookmark-get-filename "blog")
   )

  (unless (file-exists-p roam-directory)
    (make-directory roam-directory))
  (unless (file-exists-p roam-journal)
    (make-directory roam-journal))
  (unless (file-exists-p roam-main)
    (make-directory roam-main))
  (unless (file-exists-p roam-personal)
    (make-directory roam-personal))
  (unless (file-exists-p roam-nature)
    (make-directory roam-nature))
  (unless (file-exists-p roam-blog)
    (make-directory roam-blog))

  )
(org-roam-folders)



(use-package org-roam
  :ensure t
  :defer t
  :init
  ;; defined in my daemon
  (org-roam-folders)
  (require 'bookmark)
  :config
  (org-roam-db-autosync-mode)

  (use-package emacsql-sqlite
    :ensure t)

  :bind (
         ("C-c n l"   . org-roam-buffer-toggle)
         ("C-c n f"   . org-roam-node-find)
         ("C-c n i"   . org-roam-node-insert)
         ("C-c n c"   . org-roam-capture)
         ("C-c n g"   . org-roam-graph)

         ("C-c n d"   . org-roam-dailies-goto-date)
         ("C-c n j"   . org-roam-dailies-capture-today)
         ("C-c n C r" . org-roam-dailies-capture-tomorrow)
         ("C-c n t"   . org-roam-dailies-goto-today)
         ("C-c n y"   . org-roam-dailies-goto-yesterday)
         ("C-c n r"   . org-roam-dailies-goto-tomorrow)


         ("C-c n I"   . org-roam-insert-immediate)
         )
  :custom
  (org-roam-directory roam-directory)
  (org-roam-db-location  (concat roam-directory ".org-roam.db"))
  (org-roam-completion-everywhere t)
  (org-roam-completion-system 'default)
  ;; (org-roam-node-display-template ((concat "${type:15} ${title:*} " )))
  ;; (propertize "${tags:10}" 'face 'org-tag)
  ;; (("d" "default" plain "%?"
  ;;   :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
  ;;                      "#+title: ${title}\n")
  ;;   :unnarrowed t))
  (org-roam-capture-templates
   '(
     ("b" "blog" plain "%?"
      :target (file+head "blog/${slug}.org"
                         "#+title: ${title}\n"))

     ("d" "Default" plain "%?"
      :target (file+head "main/${slug}.org"
                         "#+title: ${title}\n")
      :unnarrowed t)
     ("e" "Education" plain "%?"
      :target (file+head "education/${slug}.org"
                         "#+title: ${title}\n")
      :unnarrowed t)
     ("g" "glm" plain "%?"
      :target (file+head "glm/${slug}.org"
                         "#+title: ${title}\n")
      :unnarrowed t)
     ("n" "Nature" plain "%?"
      :target (file+head "nature/${slug}.org"
                         "#+title: ${title}\n")
      :unnarrowed t)
     ("p" "Personal" plain "%?"
      :target (file+head "personal/${slug}.org"
                         "#+title: ${title}\n")
      :unnarrowed t)
     ("P" "Projects" plain "%?"
      :target (file+head "projects/${slug}.org"
                         "#+title: ${title}\n")
      :unnarrowed t)

     ("t" "Tech" plain "%?"
      :target (file+head "Tech/${slug}.org"
                         "#+title: ${title}\n")
      :unnarrowed t)
     ("s" "Social" plain "%?"
      :target (file+head "Social/${slug}.org"
                         "#+title: ${title}\n")
      :unnarrowed t)

     ("n" "note" entry  (file "braindump.org")
      "* %?\n")
     ("ll" "link note" plain
      #'org-roam-capture--get-point
      "* %^{Link}"
      :target (file "Inbox")
      :olp ("Links")
      :unnarrowed t
      :immediate-finish)
     ("lt" "link task" entry
      #'org-roam-capture--get-point
      "* TODO %^{Link}"
      :target (file "Inbox")
      :olp ("Tasks")
      :unnarrowed t
      :immediate-finish)))
  (org-roam-dailies-directory roam-journal)
  (org-roam-dailies-capture-templates
   '(("d" "default" entry
      "* %?"
      :target (file+head
               "%<%Y%m%d>.org"
               "#+title: %<%Y-%m-%d>\n\n[[roam:%<%Y-%B>]]\n\n")
      :olp ("Log")
      )
     ("t" "Task" entry
      #'org-roam-capture--get-point
      "* TODO %?\n  %U\n  %a\n  %i"
      :target (file+head
               "Journal/%<%Y-%m-%d>"
               "#+title: %<%Y-%m-%d %a>\n\n[[roam:%<%Y-%B>]]\n\n")
      :olp ("Tasks")
      :empty-lines 1
      )
     ("l" "log entry" entry
      #'org-roam-capture--get-point
      "* %<%I:%M %p> - %?"
      :target (file+head
               "Journal/%<%Y-%m-%d>"
               "#+title: %<%Y-%m-%d %a>\n\n[[roam:%<%Y-%B>]]\n\n")
      :olp ("Log")
      )
     ("m" "meeting" entry
      #'org-roam-capture--get-point
      "* %<%I:%M %p> - %^{Meeting Title}  :meetings:\n\n%?\n\n"
      :target (file+head
               "Journal/%<%Y-%m-%d>"
               "#+title: %<%Y-%m-%d %a>\n\n[[roam:%<%Y-%B>]]\n\n")
      :olp ("Log")
      ))
   )
  )

(use-package toc-org
  :ensure t
  )

(use-package org-ref
  :ensure t)

;; TODO
;; (use-package org-sidebar
;;   :ensure t)

;; (cl-defmethod org-roam-node-type ((node org-roam-node))
;;   "Return the TYPE of NODE."
;;   (condition-case nil
;;       (file-name-nondirectory
;;        (directory-file-name
;;         (file-name-directory
;;          (file-relative-name (org-roam-node-file node) org-roam-directory))))
;;     (error "")))



(provide 'my-org)
;;; my-org ends here
