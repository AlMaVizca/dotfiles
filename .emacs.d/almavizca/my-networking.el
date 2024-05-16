;;; my-networking --- Networking configurations
;;; Commentary: Remote files and network analisys

(require 'tramp)
(setq
 tramp-default-method "ssh"
 tramp-ssh-controlmaster-options (concat
                                  "-S ~/tmp/.ssh/cm/%%h-%%p-%%r.sock "
                                  (concat
                                   "-o ControlPath=~/tmp/.ssh/cm/%%h-%%p-%%r.sock "
                                   "-o ControlMaster=auto -o ControlPersist=yes")))

(add-to-list 'tramp-default-proxies-alist
             '(nil "\\`root\\'" "/ssh:%h:"))

(add-to-list 'tramp-default-proxies-alist
             '((regexp-quote (system-name)) nil nil))

(require 'url)

(provide 'my-networking)
;;;my-networking.el ends here
