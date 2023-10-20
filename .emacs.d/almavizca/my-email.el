;;; package --- my-email
;;; Commentary: My email package

(use-package mu4e
  :ensure nil
  ;; :load-path "/usr/share/emacs/site-lisp/mu4e/"
  ;; :defer 60
  :config

  ;; This is set to 't' to avoid mail syncing issues when using mbsync
  (setq mu4e-change-filenames-when-moving t)

  ;; Refresh mail using isync every 10 minutes
  (setq mu4e-update-interval (* 10 60))
  (setq mu4e-get-mail-command "mbsync -a")
  (setq mu4e-maildir "~/Mail")
  (setq mu4e-drafts-folder "/[Gmail]/Drafts")
  (setq mu4e-sent-folder   "/[Gmail]/Sent Mail")
  (setq mu4e-refile-folder "/[Gmail]/All Mail")
  (setq mu4e-trash-folder  "/[Gmail]/Trash")

  (setq mu4e-maildir-shortcuts
        '((:maildir "/Inbox"    :key ?i)
          (:maildir "/[Gmail]/Sent Mail" :key ?s)
          (:maildir "/[Gmail]/Trash"     :key ?t)
          (:maildir "/[Gmail]/Drafts"    :key ?d)
          (:maildir "/[Gmail]/All Mail"  :key ?a)))

  (setq
   user-mail-address "aldo.vizcaino87@gmail.com"
   user-full-name "Aldo María Vizcaino"
   )

  (setq smtpmail-smtp-server "smtp.gmail.com"
        smtpmail-smtp-user "aldo.vizcaino87@gmail.com"
        smtpmail-smtp-service 465
        smtpmail-stream-type  'ssl
        message-send-mail-function 'smtpmail-send-it
        mml-secure-openpgp-signers '("AA9C5629F91296F6FDC58C3095E7D44EAF29704D"
                                     )
        )
  ;; formats
  (setq mu4e-compose-format-flowed t)

  (add-hook 'message-send-hook 'mml-secure-message-sign-pgpmime)
  (add-hook 'mu4e-compose-mode-hook
            (defun my-do-compose-stuff ()
              "My settings for message composition."
              (set-fill-column 65)
              (flyspell-mode)))
  )



(provide 'my-email)
