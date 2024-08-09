;;; my-org -- personal customaization
;;; Commentary: Taken from system crafters

(setq
 roam-directory (bookmark-get-filename "notes")
 roam-journal (concat roam-directory "journal")
 roam-personal (concat roam-directory "personal")
 roam-blog (concat roam-directory "blog")
 roam-tech (concat roam-directory "tech")
 roam-project (concat roam-directory "projects")
 )

;;; Create roam folders if they don't exist
(defun org-roam-folders ()
  (unless (file-exists-p roam-directory)
    (make-directory roam-directory))
  (unless (file-exists-p roam-journal)
    (make-directory roam-journal))
  (unless (file-exists-p roam-personal)
    (make-directory roam-personal))
  (unless (file-exists-p roam-blog)
    (make-directory roam-blog))
  (unless (file-exists-p roam-project)
    (make-directory roam-project))
  )

(use-package org
  :ensure (:wait t)
  :init
  (org-roam-folders)
  :custom
  (org-export-use-babel nil)
  (org-directory roam-directory)
  (org-modules
   '(org-crypt
     org-habit
     ))
  (org-refile-targets '((nil :maxlevel . 1)
                        (org-agenda-files :maxlevel . 1)))
  (org-agenda-files
   (list roam-journal roam-personal roam-blog roam-tech roam-project
         (bookmark-get-filename "veanet")))
  (org-outline-path-complete-in-steps nil)
  (org-refile-use-outline-path t)
  (epa-file-encrypt-to "aldo.vizcaino87@gmail.com")

  (org-tag-alist
   '(;; Places
     ("@home" . ?H)
     ("@work" . ?W)
     ;; Devices
     ("@computer" . ?C)
     ("@phone" . ?P)
     ;; Activities
     ("@planning" . ?n)
     ("@programming" . ?p)
     ("@writing" . ?w)
     ("@creative" . ?c)
     ("@email" . ?e)
     ("@calls" . ?a)
     ("@errands" . ?r))
   )
  :config
  (elpaca (general :wait t))

  (global-set-key (kbd "C-c C-p") 'org-publish-force)

  (push '("conf-unix" . conf-unix) org-src-lang-modes)

  ;; Templates expansion of Org structures
  (require 'org-tempo)

  (add-to-list 'org-structure-template-alist '("sh" . "src sh"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("sc" . "src scheme"))
  (add-to-list 'org-structure-template-alist '("ts" . "src typescript"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("go" . "src go"))
  (add-to-list 'org-structure-template-alist '("yaml" . "src yaml"))
  (add-to-list 'org-structure-template-alist '("json" . "src json"))
  )
(setq org-confirm-babel-evaluate nil)
(use-package org-roam
  :ensure t
  :defer t
  :init
  (org-roam-folders)
  (require 'bookmark)
  :config
  (org-roam-db-autosync-mode)
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
     ("e" "Education" plain "%?"
      :target (file+head "education/${slug}.org"
                         "#+title: ${title}\n")
      :unnarrowed t)
     ("j" "Journal" plain "%?"
      :target (file+head "journal/${slug}.org"
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
     ("v" "veanet" plain "%?"
      :target (file+head "projects/veanet/${slug}.org"
                         "#+title: ${title}\n")
      :unnarrowed t)
     ("t" "Tech" plain "%?"
      :target (file+head "tech/${slug}.org"
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
               "#+title: %<%Y-%m-%d>\n\n[[roam:%<%Y-%m>]]\n\n"
               ;; "* Feelings of the day\n"
               ;; "* Feelings after the day\n"
               ;; "** What are the three things I am gratefull?\n"
               ;; "** What are the three things that I have learn?\n"
               ;; "** What things have to happen to feel like I'm crushing the next day?\n"
               ;; (insert-file-contents (bookmark-get-filename "journal_template"))
               )
      :olp ("Log")
      )
     )
   )
  )

(use-package org-roam-ui
  :ensure (:wait t))

(provide 'my-org)
;;; my-org.el ends here
