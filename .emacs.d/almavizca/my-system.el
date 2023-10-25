;;; my-system --- System management
;;; Commentary: system settings

(require 'my-packages)
(require 'my-secrets)
(require 'my-bookmarks)
(require 'my-theme)
(require 'my-daemon)

(require 'my-docker)

(require 'tramp)
(setq
 tramp-default-method "ssh"
 tramp-ssh-controlmaster-options
      (concat
       "-S ~/tmp/.ssh/cm/%%h-%%p-%%r.sock "
       (concat
        "-o ControlPath=~/tmp/.ssh/cm/%%h-%%p-%%r.sock "
        "-o ControlMaster=auto -o ControlPersist=yes"))
 )
(add-to-list 'tramp-default-proxies-alist
             '(nil "\\`root\\'" "/ssh:%h:"))

(add-to-list 'tramp-default-proxies-alist
             '((regexp-quote (system-name)) nil nil))


;; Ctags
(defun build-ctags ()
  (interactive)
  (message "building project tags")
  (let ((root (eproject-root)))
    (shell-command (concat "ctags -e -R --exclude=.git -f " root "TAGS " root)))
  (message "tags built successfully"))


;; (let (
;;       (beancount-repo "~/Repositories/economicsbeancount-mode")
;;       )
;;   (unless (file-directory-p beancount-repo)
;;     (add-to-list 'load-path beancount-repo)
;;     (require 'beancount)
;;     (add-to-list 'auto-mode-alist '("\\.beancount\\'" . beancount-mode))

;;     ))

(require 'my-ide)
(require 'my-org)
(require 'my-email)
(require 'my-langtool)
(require 'my-blog)
;;(require 'my-750words)

(require 'my-keys)


(require 'my-shell)

(use-package proc-net
  :ensure t)

;; TODO
;; (use-package pocket-reader
;;   :ensure t)


(provide 'my-system)
