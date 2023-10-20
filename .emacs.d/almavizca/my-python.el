(elpy-enable)
(setenv "WORKON_HOME" "~/.virtualenvs")
(defalias 'workon 'pyvenv-workon)
(defalias 'activate 'pyvenv-activate)
(defalias 'deactivate 'pyvenv-activate)

(defun pyvenv-autoload ()
  "Automatically activates pyvenv version if .venv directory exists."
  (f-traverse-upwards
   (lambda (path)
     (let ((venv-path (f-expand ".venv" path)))
       (if (f-exists? venv-path)
           (progn
             (pyvenv-workon venv-path))
         t)))))


(fset 'pdb_trace
      (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([5 return 105 109 112 111 114 116 32 112 100 98 59 32 112 100 98 95 115 101 116 backspace backspace backspace backspace 46 116 114 97 backspace backspace backspace 115 101 116 95 116 114 97 99 101 40 41 24 19] 0 "%d")) arg)))

(global-set-key (kbd "C-x C-k d") 'pdb_trace)


;; Highlight the call to ipdb
;; src http://pedrokroger.com/2010/07/configuring-emacs-as-a-python-ide-2/
(defun annotate-pdb ()
  (interactive)
  (highlight-lines-matching-regexp "import pdb")
  (highlight-lines-matching-regexp "pdb.set_trace()"))

(add-hook 'python-mode-hook 'annotate-pdb)

(add-hook 'python-mode-hook 'pyvenv-autoload)

(setq elpy-rpc-virtualenv-path (concat (getenv "WORKON_HOME") "/base"))

(setq python-shell-interpreter "jupyter"
      python-shell-interpreter-args "console --simple-prompt"
      python-shell-prompt-detect-failure-warning nil)
(add-to-list 'python-shell-completion-native-disabled-interpreters
             "jupyter")


(use-package py-autopep8
  :ensure t)

(use-package pyvenv-auto
  :ensure t)


(provide 'my-python)
