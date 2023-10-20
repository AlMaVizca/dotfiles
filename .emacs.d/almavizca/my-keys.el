;;; keymaps
(defun bootrap ()
  "Lunch shell."
  (interactive)
  (setq buffer (concat "ys-" (daemonp)))
  (if (get-buffer buffer)
      (switch-to-buffer (get-buffer buffer) nil t)
    (shell  buffer)
    ))

(defun NoSqlClient ()
  (call-process "docker" nil 0 nil "run" "--rm" "-d" "--name" "mongoclient" "-p" "3000:3000" "-e" "MONGO_URL=mongodb://10.0.201.239/ws1"  "mongoclient/mongoclient")
  )

(defun my-keys-ssh-flush ()
  (call-process "assh" nil 0 nil "sockets" "flush")
  )

(global-set-key (kbd "C-x p") (lambda () () (interactive) (NoSqlClient)))
(global-set-key (kbd "C-º") (lambda () () (interactive) (neotree)))
(global-set-key (kbd "M-s s") (lambda () () (interactive) (my-keys-ssh-flush)))








(provide 'my-keys)
