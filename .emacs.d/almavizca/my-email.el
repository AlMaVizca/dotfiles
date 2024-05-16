;;; my-email --- Email settings
;;; Commentary:
;;; Code:
(use-package mu4e
  :ensure nil
  ;; :load-path "/usr/share/emacs/site-lisp/mu4e/"
  ;; :defer 60
  :commands mu4e
  :config

  (setq
   ;; This is set to 't' to avoid mail syncing issues when using mbsync
   mu4e-change-filenames-when-moving t
   ;; Refresh mail using isync every 10 minutes
   mu4e-update-interval (* 10 60)
   mu4e-get-mail-command "mbsync -a"
   mu4e-maildir "~/Mail"
   mu4e-mu-debug t
   ;; Folders
   mu4e-drafts-folder "/[Gmail]/Drafts"
   mu4e-sent-folder   "/[Gmail]/Sent Mail"
   mu4e-refile-folder "/[Gmail]/All Mail"
   mu4e-trash-folder  "/[Gmail]/Trash"
   ;; Format
   mu4e-compose-format-flowed t
   ;; Shortcuts
   mu4e-maildir-shortcuts
   '((:maildir "/Inbox"    :key ?i)
     (:maildir "/[Gmail]/Sent Mail" :key ?s)
     (:maildir "/[Gmail]/Trash"     :key ?t)
     (:maildir "/[Gmail]/Drafts"    :key ?d)
     (:maildir "/[Gmail]/All Mail"  :key ?a))
   ;; User
   user-mail-address "aldo.vizcaino87@gmail.com"
   user-full-name "Aldo María Vizcaino"
   ;; smtp
   smtpmail-smtp-server "smtp.gmail.com"
   smtpmail-smtp-user "aldo.vizcaino87@gmail.com"
   smtpmail-smtp-service 465
   smtpmail-stream-type  'ssl
   message-send-mail-function 'smtpmail-send-it
   mml-secure-openpgp-signers '("AA9C5629F91296F6FDC58C3095E7D44EAF29704D")
   )

  (add-hook 'message-send-hook 'mml-secure-message-sign-pgpmime)
  (add-hook 'mu4e-compose-mode-hook
            (defun my-do-compose-stuff ()
              "My settings for message composition."
              (set-fill-column 65)
              (flyspell-mode)))
  )

(use-package mu4e-conversation
  :ensure t
  :after mue4e)

(provide 'my-email)
;;; my-email.el ends here
