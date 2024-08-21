;; my-bookmarks --- customizations with bookmarks
;;; Commentary: make bookmarks accesible by the shell
;;; Code:
(require 'bookmark)
(setq-default bookmark-default-file "~/.dotfiles-secrets/.local/emacs.d/bookmarks.el")
(setq bookmark-save-flag 1
      ;;; Don't populate file-name-history with recentf
      history-files-length 1
      recentf-initialize-file-name-history nil
      recentf-max-saved-items history-files-length
      history-length history-files-length
      )
(bookmark-load bookmark-default-file t)

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

;;(advice-add 'bookmark-write-file :after #'local-directory-bookmarks-to-zsh)
(defadvice bookmark-write-file
    (after local-directory-bookmarks-to-zsh-advice last activate)
  (local-directory-bookmarks-to-zsh)
  )

;; TODO
;; Review load bookmars from C-x C-f
;; (defun bookmark-to-abbrevs ()
;;   "Create abbrevs based on `bookmark-alist'."
;;   (dolist (bookmark bookmark-alist)
;;     (let* ((name (car bookmark))
;;            (file (bookmark-get-filename name)))
;;       (define-abbrev global-abbrev-table name file))))

(defadvice bookmark-jump (after bookmark-jump activate)
  (let ((latest (bookmark-get-bookmark bookmark)))
    (setq bookmark-alist (delq latest bookmark-alist))
    (add-to-list 'bookmark-alist latest)))

(provide 'my-bookmarks)
;;; my-bookmarks ends here
