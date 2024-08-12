;;; my-keybindings --- Global shortcuts
;;; Commentary:
;;  Shortcuts to avoid leaving the working buffer
;;; Code:
(defun NoSqlClient ()
  (call-process "docker" nil 0 nil "run" "--rm" "-d" "--name" "mongoclient" "-p" "3000:3000" "-e" "MONGO_URL=mongodb://10.0.201.239/ws1"  "mongoclient/mongoclient")
  )

(defun my-keys-ssh-flush ()
  (call-process "assh" nil 0 nil "sockets" "flush")
  )

(global-set-key (kbd "C-x p n") (lambda () () (interactive) (NoSqlClient)))
(global-set-key (kbd "M-s s") (lambda () () (interactive) (my-keys-ssh-flush)))

(provide 'my-keybindings)
;;; my-keybindings.el ends here
