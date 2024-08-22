;;; my-email --- Email settings
;;; Commentary:
;;; Code:
(use-package mu4e
  :ensure (:repo "djcb/mu"
                 :host github
                 :files (:defaults "/mu4e/*"))
  ;; :load-path "/usr/share/emacs/site-lisp/mu4e/"
  :after password-store
  :config
  (setq
   ;; This is set to 't' to avoid mail syncing issues when using mbsync
   mu4e-change-filenames-when-moving t
   ;; Refresh mail using isync every 10 minutes, settings are on dotfiles-secrets
   mu4e-update-interval (* 10 60)
   mu4e-get-mail-command "mbsync -a"
   mu4e-maildir "~/Mail"
   mu4e-mu-debug nil
   ;; Format
   mu4e-compose-format-flowed t

   ;; Smtp defaults and gpg
   smtpmail-smtp-service 465
   smtpmail-stream-type  'ssl
   message-send-mail-function 'smtpmail-send-it
   mml-secure-openpgp-signers `(,(password-store-get-field "Personal/mail-personal" "key"))


   ;; contexts
   mu4e-context-policy 'pick-first
   mu4e-contexts
   `(
     ;; Work account
     ,(make-mu4e-context
       :name "Personal"
       :match-func
       (lambda (msg)
         (when msg
           (string-prefix-p "/Gmail" (mu4e-message-field msg :maildir))))
       :vars `(
               (user-mail-address . ,(password-store-get-field "Personal/mail-personal" "login"))
               (user-full-name    . ,(password-store-get-field "Personal/mail-personal" "fullname"))
               ;; smtp
               (smtpmail-smtp-server . ,(password-store-get-field "Personal/mail-personal" "smtp"))
               (smtpmail-smtp-user   . ,(password-store-get-field "Personal/mail-personal" "login"))
               (mu4e-drafts-folder . "/Gmail/[Gmail]/Drafts")
               (mu4e-sent-folder   . "/Gmail/[Gmail]/Sent Mail")
               (mu4e-refile-folder . "/Gmail/[Gmail]/All Mail")
               (mu4e-trash-folder  . "/Gmail/[Gmail]/Trash")))
     ,(make-mu4e-context
       :name "Work"
       :match-func
       (lambda (msg)
         (when msg
           (string-prefix-p "/Almavizca" (mu4e-message-field msg :maildir))))
       :vars `(
               (user-mail-address . ,(password-store-get-field "Work/mail-work" "login"))
               (user-full-name . ,(password-store-get-field "Work/mail-work" "fullname"))
               ;; smtp
               (smtpmail-smtp-server . ,(password-store-get-field "Work/mail-work" "smtp"))
               (smtpmail-smtp-user . ,(password-store-get-field "Work/mail-work" "login"))
               (mu4e-drafts-folder  . "/Almavizca/Drafts")
               (mu4e-sent-folder  . "/Almavizca/Sent")
               (mu4e-refile-folder  . "/Almavizca/")
               (mu4e-trash-folder  . "/Almavizca/Trash")))
     )

   ;; Shortcuts
   mu4e-maildir-shortcuts
   '((:maildir "/Gmail/Inbox"    :key ?g)
     (:maildir "/Gmail/[Gmail]/Sent Mail" :key ?s)
     (:maildir "/Gmail/[Gmail]/Trash"     :key ?t)
     (:maildir "/Gmail/[Gmail]/Drafts"    :key ?d)
     (:maildir "/Almavizca/Inbox"  :key ?a))
   ;; User
   )
  (add-to-list 'mu4e-bookmarks '("m:/Almavizca/Inbox or m:/Gmail/Inbox" "All Inboxes" ?i))

  (add-hook 'message-send-hook 'mml-secure-message-sign-pgpmime)
  (add-hook 'mu4e-compose-mode-hook
            (defun my-do-compose-stuff ()
              "My settings for message composition."
              (set-fill-column 65)
              (flyspell-mode)))
  )

;; (use-package mu4e-conversation
;;   :ensure t
;;   :after mu4e)

(use-package mu4e-dashboard
  :ensure (:repo "rougier/mu4e-dashboard"
                 :protocol https
                 :host github)
  )


(provide 'my-email)
;;; my-email.el ends here
