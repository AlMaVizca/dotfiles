;;; my-makefile-runner.el --- Searches for Makefile and fetches targets

(use-package helm-make
  :ensure t
  :custom
  (helm-make-comint t)
  (helm-make-named-buffer t)
  (helm-make-arguments "-j%d")
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
