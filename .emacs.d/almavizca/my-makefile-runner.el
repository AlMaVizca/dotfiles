;;; my-makefile-runner.el --- Searches for Makefile and fetches targets

;; ;; Copyright (C) 2009-2012 Dan Amlund Thomsen

;; ;; Author: Dan Amlund Thomsen <dan@danamlund.dk>
;; ;; URL: http://danamlund.dk/emacs/make-runner.html
;; ;; Version: 1.1.3
;; ;; Created: 2009-01-01
;; ;; By: Dan Amlund Thomsen
;; ;; Keywords: makefile, make, ant, build

;; ;;; Commentary:

;; ;; An easy method of running different makefiles. The function searches current
;; ;; and parent directories for a makefile, fetches targets, and asks
;; ;; the user which of the targets to run.

;; ;; The function is `makefile-runner'.

;; ;; By default it supports make's Makefiles and ant's build.xml files.

;; ;;; Installation:

;; ;; Save my-makefile-runner.el to your load path and add the following to
;; ;; your .emacs file:
;; ;;
;; ;; (require 'makefile-runner)

;; ;; You can add a keybinding to run the function, for example:
;; ;;
;; ;; (global-set-key (kbd "C-x C-m u") 'makefile-runner-up)
;; ;; (global-set-key (KBD "C-x C-m l") 'makefile-runner-logs)

;; ;;; Customization:

;; ;; M-x customize-group my-makefile-runner
;; ;;
;; ;; You can add further build systems by changing
;; ;; `makefile-runner--makefiles'.
;; ;;
;; ;; And you can set a specific Makefile to use by changing
;; ;; `makefile-runner--makefile'. A better method is to add a
;; ;; file-variable to the affected files. For example, add to following
;; ;; to the start of foo/src/foo.c:
;; ;;
;; ;; /* -*- my-makefile-runner--makefile: "../Makefile" -*- */

;; ;;; Changelog:
;; ;; (2016-01-23) 1.1.3: Fix searching subdirectories with spaces in them (AdamNiederer)
;; ;; (2012-09-29) 1.1.2: Now also searches for makefiles next to the current file
;; ;; (2012-09-29) 1.1.1: Better handles no-makefile-found.
;; ;; (2012-09-29) 1.1.0: Added ant support. minibuffer now shows
;; ;;                     makefile filename and its directory-name.

;; ;;; Code:

;; ;;;###autoload
;; (defcustom my-makefile-runner--makefile nil
;;   "Use this Makefile instead of searching for one. Intended to be
;;   used as a local variable (e.g. as a file variable:
;;   -*- my-makefile-runner--makefile: \"../../Makefile\" -*-)"
;;   :type 'file
;;   :group 'makefile-runner)

;; ;;;###autoload

;; (defcustom my-makefile-runner--makefiles
;;   '(("Makefile"  my-makefile-runner--get-targets-make "cd \"%s\"; make %s")
;;     ("build.xml" my-makefile-runner--get-targets-ant "cd \"%s\"; ant %s"))
;;   "A list of (MAKEFILE-FILENAME FIND-TARGETS-PROCEDURE MAKEFILE-RUN-STRING)."
;;   :type 'sexp
;;   :group 'makefile-runner)

;; (defvar my-makefile-runner--last-target nil
;;   "Remembers the last target")

;; (defvar my-makefile-runner--hist nil
;;   "History of makefile targets")

;; (defun my-makefile-runner--find-makefile ()
;;   "Search current buffer's directory for makefiles. If no
;; makefiles exists, continue searching in the directory's parent. If
;; no makefiles exists in any directory parents return nil."
;;   (when (buffer-file-name)
;;     (let* ((path (substring (file-name-directory (buffer-file-name)) 0 -1))
;;            (makefile nil)
;;            (path-up (function
;;                      (lambda ()
;;                        (setq path (expand-file-name ".." path))
;;                        (and (> (length path) 2)
;;                             (not (equal ".." (substring path -2)))))))
;;            (find-makefile
;;             (function
;;              (lambda ()
;;                (let ((makefiles (mapcar 'car my-makefile-runner--makefiles)))
;;                  (while (and (not makefile) (not (null makefiles)))
;;                    (let ((makefile-path (concat path "/" (car makefiles))))
;;                      (when (file-exists-p makefile-path)
;;                        (setq makefile makefile-path)))
;;                    (setq makefiles (cdr makefiles)))
;;                  makefile)))))
;;       (while (and (not (funcall find-makefile)) (funcall path-up)) nil)
;;       makefile)))

;; (defun my-makefile-runner--get-targets-make (file)
;;   "Search FILE for Makefile targets and return them as a list of
;; strings. Does not add targets that match the regular expression
;; in \"\\(^\\.\\)\\|[\\$\\%]\"."
;;   (let ((target-exclude-regexp "\\(^\\.\\)\\|[\\$\\%]"))
;;     (with-temp-buffer
;;       (insert-file-contents file)
;;       (goto-char (point-max))
;;       (let ((targets nil))
;;         (while (re-search-backward "^\\([^:\n#[:space:]]+?\\):"
;;                                    (not 'bound) 'noerror)
;;           (unless (string-match target-exclude-regexp
;;                                 (match-string 1))
;;             (setq targets (cons (match-string 1) targets))))
;;         targets))))

;; (defun my-makefile-runner--get-targets-ant (file)
;;   "Search the ant file 'build.xml' in FILE and return a list of
;; targets."
;;   (delq nil
;;         (mapcar (lambda (e) (if (and (listp e) (equal (car e) 'target))
;;                                 (cdr (assoc 'name (cadr e)))
;;                               nil))
;;                 (with-temp-buffer
;;                   (insert-file-contents file)
;;                   (libxml-parse-xml-region (point-min) (point-max))))))


;; (defun my-makefile-runner--get-targets (file)
;;   "Find appropiate get-targets procedure from
;; `makefile-runner--makefiles' and execute it on file. Returns a
;; list of targets."
;;   (let ((get-targets (cadr (assoc (file-name-nondirectory file)
;;                                   my-makefile-runner--makefiles))))
;;     (funcall get-targets file)))

;; ;;;###autoload
;; (defun my-makefile-runner (target &optional makefile)
;;   "Run nearest makefile with TARGET.

;; When calling interactively. The targets from the nearest makefile
;; is extracted and the user is asked which target to use.

;; Closest Makefile means first Makefile found when seacrching
;; upwards from the directory of the current buffer.

;; Set `makefile-runner--makefile' to use a specific Makefile rather
;; than search for one.

;; By default it searches for 'Makefile' and 'build.xml' files. To
;; add more makefiles or change the priority ordering see
;; `makefile-runner--makefiles'."
;;   (interactive
;;    (let* ((makefile (or my-makefile-runner--makefile
;;                         (my-makefile-runner--find-makefile)))
;;           (makefile-path (and makefile
;;                               (concat (file-name-nondirectory
;;                                        (substring (file-name-directory makefile)
;;                                                   0 -1))
;;                                       "/" (file-name-nondirectory makefile)))))
;;      (if makefile
;;          (list (completing-read (concat makefile-path ": ")
;;                                 (my-makefile-runner--get-targets makefile)
;;                                 nil nil "" ;;makefile-runner--last-target
;;                                 'makefile-runner--hist "")
;;                makefile)
;;        (progn (message "No makefile found.")
;;               (list nil nil)))))
;;   (when target
;;     (setq my-makefile-runner--last-target target)
;;     (let ((makefile-runstring (car (cddr (assoc (file-name-nondirectory makefile)
;;                                                 my-makefile-runner--makefiles)))))
;;       (compile (concat (format makefile-runstring
;;                                (file-name-directory makefile)
;;                                target)
;;                        "\n")))))


;; (defun my-makefile-runner-buffer-name (name-of-mode)
;;   ;;(my-makefile-runner--find-makefile)
;;   (cond ((or (eq major-mode (intern-soft name-of-mode))
;;              (eq major-mode (intern-soft (concat name-of-mode "-mode"))))
;;          (buffer-name))
;;         (t
;;          (concat "*" (downcase name-of-mode) "-" (file-name-nondirectory (directory-file-name (file-name-directory (my-makefile-runner--find-makefile)))) "*"))))

;; (setq compilation-buffer-name-function 'my-makefile-runner-buffer-name)


;; ;;auto functions
;; (defun my-makefile-runner-up ()
;;   (interactive)
;;   (my-makefile-runner "up" ))

;; (defun my-makefile-caches ()
;;   "Exec caches service."
;;   (interactive)
;;   (my-makefile-runner "services" "/home/krahser/Repositories/inthependiente/caches/Makefile")
;;   )


;; (global-set-key (kbd "C-x m") 'my-makefile-runner)
;; (global-set-key (kbd "M-c") (lambda () () (interactive) (my-makefile-caches)))


(use-package helm-make
  :ensure t
  :custom
  (helm-make-comint t)
  :config
  (defcustom helm-make-parameters ""
    "Pass these parameters as variables to `helm-make'"
    :type 'string
    :group 'helm-make)

  (defun helm--make-construct-command (arg file)
    "Construct the `helm-make-command'.

ARG should be universal prefix value passed to `helm-make' or
`helm-make-projectile', and file is the path to the Makefile or the
ninja.build file."
    (format (concat "%s%s -C %s " helm-make-arguments " %%s")
            (if (= helm-make-niceness 0)
                ""
              (format "nice -n %d " helm-make-niceness))
            (cond
             ((equal helm--make-build-system 'ninja)
              helm-make-ninja-executable)
             (t
              (concat helm-make-parameters " " helm-make-executable)))
            (replace-regexp-in-string
             "^/\\(scp\\|ssh\\).+?:.+?:" ""
             (shell-quote-argument (file-name-directory file)))
            (let ((jobs (abs (if arg (prefix-numeric-value arg)
                               (if (= helm-make-nproc 0) (helm--make-get-nproc)
                                 helm-make-nproc)))))
              (if (> jobs 0) jobs 1))))

  (global-set-key (kbd "C-c C-r") 'helm-make-projectile)
  )




(provide 'my-makefile-runner)

;;; my-makefile-runner.el ends here
