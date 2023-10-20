;; terminal
(defvar my-term-shell "/usr/bin/zsh")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)

;; (defadvice term-sentinel (around my-advice-term-sentinel (proc msg))
;;   "Remove terminal buffer when exit"
;;   (if (memq (process-status proc) '(signal exit))
;;       (let ((buffer (process-buffer proc)))
;;         ad-do-it
;;         (kill-buffer buffer))
;;     ad-do-it))
;; (ad-activate 'term-sentinel)

(defun my-term-paste (&optional string)
  (interactive)
  (process-send-string
   (get-buffer-process (current-buffer))
   (my-inhibit-global-linum-mode)
   (if string string (current-kill 0)))
  )

(defun yat-hook ()
  "Add customs to term"
  (setenv "EMACS_DAEMON" (daemonp))
  ;; (setenv "TERM" "eterm-color")
  (goto-address-mode)
  (my-inhibit-global-linum-mode)
  (rename-buffer (concat "ys-" (daemonp)))
  )


(defun kill-buffer-exec-hook ()
  "Remove terminal buffer when exit"
  (let* ((buff (current-buffer))
         (proc (get-buffer-process buff)))
    (set-process-sentinel
     proc
     `(lambda (process event)
        (if (string= event "finished\n")
            (kill-buffer ,buff))))))

(defun yat-exec-hook ()
  "Load my term hooks"
  (kill-buffer-exec-hook)
  )

(defun my-inhibit-global-linum-mode ()
  "Counter-act `global-linum-mode'."
  (add-hook 'after-change-major-mode-hook
            (lambda () (linum-mode 0))
            :append :local)
  )

;;(add-hook 'term-exec-hook 'yat-exec-hook)
;;(add-hook 'term-mode-hook 'yat-hook)


(defun yat-vterm-mode-hook ()
  "Load my term hooks"
  (kill-buffer-exec-hook)
  (goto-address-mode)
  (my-inhibit-global-linum-mode)
  (setq emacs (concat "EMACS_DAEMON=" (daemonp)))
  (vterm-send-string emacs)
  (vterm-send-return)
  (vterm-send-string "TERM=eterm-color; ys")
  (vterm-send-return)
  )

(add-hook 'vterm-mode-hook 'yat-vterm-mode-hook)

(defun myterm ()
  "Lunch terminal."
  (interactive)
  (setq buffer (concat "ys-" (daemonp)))
  (if (get-buffer buffer)
      (switch-to-buffer (get-buffer buffer) nil t)
    (vterm buffer)
    ))

(defun myshell ()
  "Lunch shell."
  (interactive)
  (setq buffer (concat "ys-" (daemonp)))
  (if (get-buffer buffer)
      (switch-to-buffer (get-buffer buffer) nil t)
    (shell  buffer)
    ))



;; Bookmarks
(defadvice bookmark-write-file
    (after local-directory-bookmarks-to-zsh-advice activate)
  (local-directory-bookmarks-to-zsh))
(defun local-directory-bookmarks-to-zsh ()
  (interactive)
  (when (and (require 'tramp nil t)
             (require 'bookmark nil t))
    (set-buffer (find-file-noselect "~/.zsh.bmk" t t))
    (delete-region (point-min) (point-max))
    (insert "# -*- mode:sh -*-\n")
    (let (collect-names)
      (mapc (lambda (item)
              (let ((name (replace-regexp-in-string "-" "_" (car item)))
                    (file (cdr (assoc 'filename
                                      (if (cddr item) item (cadr item))))))
                (when (and (not (tramp-tramp-file-p file))
                           (file-directory-p file))
                  (setq collect-names (cons (concat "~" name) collect-names))
                  (insert (format "%s=\"%s\"\n" name (expand-file-name file) name)))))
            bookmark-alist)
      (insert ": " (mapconcat 'identity collect-names " ") "\n"))
    (let ((backup-inhibited t)) (save-buffer))
    (kill-buffer (current-buffer))))


(provide 'init-ys)
