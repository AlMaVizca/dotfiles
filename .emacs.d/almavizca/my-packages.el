;;; my-packages --- custom package managers and sources
;;; Commentary: Personal choices to manage packages

;; (add-to-list 'package-archives
;;              '("melpa-stable" . "https://stable.melpa.org/packages/"))

;; (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
;; (add-to-list 'package-archives '( "jcs-elpa" . "https://jcs-emacs.github.io/jcs-elpa/packages/") t)
;; (setq package-archive-priorities '(("melpa"    . 5)
;;                                    ("jcs-elpa" . 0)))
;; (setq package-list '(diary-manager add-node-modules-path affe aggressive-indent ansible ansible-doc anzu auto-compile avy bash-completion beacon browse-at-remote browse-kill-ring bug-reference-github bundler cask-mode cl-libify cljsbuild-mode cmd-to-echo coffee-mode color-theme-sanityinc-solarized color-theme-sanityinc-tomorrow command-log-mode company-anaconda anaconda-mode company-nixos-options company-php ac-php-core company-quickhelp company-terraform consult-eglot consult-flycheck counsel crontab-mode css-eldoc csv-mode daemons darcsum dash-functional dashboard default-text-scale dhall-mode diff-hl diminish dimmer dired-icon dired-sidebar dired-subtree dired-hacks-utils dired-toggle diredfl direx dirtree disable-mouse docker aio docker-compose-mode docker-tramp dockerfile-mode dotenv-mode dsvn dune dune-format eglot elein elisp-slime-nav elm-mode elm-test-runner elpy embark-consult consult embark envrc erlang eterm-256color exec-path-from-shell expand-region fill-column-indicator find-file-in-project fish-completion fish-mode flycheck-clojure cider clojure-mode flycheck-color-mode-line flycheck-elm flycheck-ledger flycheck-nim flycheck-package flycheck-relint flycheck-rust flymake-flycheck forge closql emacsql-sqlite emacsql fullframe git-blamed git-link git-messenger git-modes git-timemachine github-clone gh github-review a gnu-elpa-keyring-update gnuplot graphql guide-key haskell-mode highlight-escape-sequences highlight-indentation highlight-quoted hindent hippie-expand-slime htmlize httprepl ibuffer-projectile ibuffer-vc immortal-scratch info-colors inheritenv ipretty ivy-historian flx historian ivy-xref j-mode js-comint json-mode json-reformat json-snatcher k8s-mode kubernetes-helm ledger-mode list-unicode-display logito lua-mode magit-todos hl-todo async magithub ghub+ apiwrap ghub magit git-commit marginalia markdown-mode marshal ht mmm-mode mode-line-bell moody move-dup multi-term multiple-cursors nginx-mode nim-mode flycheck-nimsuggest commenter epc ctable concurrent deferred nix-buffer nix-mode magit-section nix-sandbox nixos-options nixpkgs-fmt npm jest magit-popup ob-restclient orderless org-bullets org-cliplink org-pomodoro alert log4e gntp origami package-lint-flymake package-lint packed page-break-lines paredit-everywhere paredit parseedn parseclj pass password-store-otp password-store pcache pcre2el php-mode pip-requirements popup popwin prettier-js projectile-rails inflections projectile psc-ide psci purescript-mode pythonic pyvenv racer pos-tip rainbow-delimiters rainbow-mode rake f regex-tool relint restclient rg robe rspec-mode ruby-compilation inf-ruby ruby-hash-syntax rust-mode sass-mode haml-mode scratch sesman session shell-split-string shfmt skewer-less skewer-mode simple-httpd slime-company company company-tabnine slime macrostep smarty-mode smex solarized-theme spinner sqlformat reformatter sudo-edit swiper ivy switch-window symbol-overlay tablist tagedit terraform-mode hcl-mode textile-mode tide flycheck pkg-info epl s dash toml-mode transient tree-mode treepy tuareg caml typescript-mode undo-tree queue unfill uptimes use-package bind-key vc-darcs vertico vlf vterm wgrep which-key whitespace-cleanup-mode whole-line-or-region windata windswap with-editor writeroom-mode visual-fill-column xcscope xr xref-js2 js2-mode xterm-color yagist yaml yaml-mode yard-mode yari yasnippet zlc jiralib2 ox-jira language-detection focus))


(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


(straight-use-package 'use-package)


(use-package helm
  :straight t
  )

(straight-use-package 'org)

(use-package mermaid-mode
  :ensure t)


(provide 'my-packages)
;;; my-packages ends here
