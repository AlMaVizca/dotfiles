;;; my-docker --- Configurations
;;; Commentary:

;; docker run --rm -d --name mongoclient -p 3000:3000 -e MONGO_URL=mongodb://10.0.201.239/ws1 mongoclient/mongoclient

;; (call-process PROGRAM &optional INFILE BUFFER DISPLAY &rest ARGS)
;; (call-process "docker" nil 0 nil "run" "--rm" "-d" "--name" "mongoclient" "-p" "3000:3000" "-e" "MONGO_URL=mongodb://10.0.201.239/ws1"  "mongoclient/mongoclient")


;;(docker-compose-run-action-for-one-service "--tail=20" "--follow")

(use-package dockerfile-mode
  :ensure t
  )

(use-package docker
  :ensure  t
  :bind
  ("C-c d" . docker)
  :custom
  (docker-container-default-sort-key '("Names" . nil))
  ;; :config
  ;; (defun docker-container-entries ()
  ;;   "Return the docker containers data for `tabulated-list-entries'."
  ;;   (let* ((fmt "[{{json .Names}},{{json .Status}},{{json .Ports}},{{json .Command}}]")
  ;;          (data (docker-run-docker "container ls" (docker-container-ls-arguments) (format "--format=\"%s\" --no-trunc" fmt)))
  ;;          (lines (s-split "\n" data t)))
  ;;     (-map #'docker-container-parse lines)))

  ;; (defun docker-container-parse (line)
  ;;   "Convert a LINE from \"docker container ls\" to a `tabulated-list-entries' entry."
  ;;   (condition-case nil
  ;;       (let* ((data (json-read-from-string line))
  ;;              (status (aref data 1)))
  ;;         (aset data 1 (propertize status 'font-lock-face (docker-container-status-face status)))
  ;;         (list (aref data 0) data))
  ;;     (json-readtable-error
  ;;      (error "Could not read following string as json:\n%s" line))))

  ;; (define-derived-mode docker-container-mode tabulated-list-mode "Containers Menu"
  ;;   "Major mode for handling a list of docker containers."
  ;;   (setq tabulated-list-format [("Names" 20 t)("Status" 15 t) ("Ports" 20 t) ("Command" 30 t)])
  ;;   (setq tabulated-list-padding 2)
  ;;   (setq tabulated-list-sort-key docker-container-default-sort-key)
  ;;   (add-hook 'tabulated-list-revert-hook 'docker-container-refresh nil t)
  ;;   (tabulated-list-init-header)
  ;;   (tablist-minor-mode))
  )

(use-package docker-cli
  :ensure t)

(use-package docker-compose-mode
  :ensure t
  :bind
  (:map docker-compose-mode-map (
                                 ("C-x C-d b" . docker-compose-build)
                                 ("C-x C-d u" . docker-compose-up)
                                 ("C-x C-d r" . docker-compose-run)
                                 ("C-x C-d s" . docker-compose-stop)
                                 ("C-x C-d e" . docker-compose-exec)
                                 )
        )
  :config
  (use-package docker)
  )

(provide 'my-docker)
;;; my-docker.el ends here
