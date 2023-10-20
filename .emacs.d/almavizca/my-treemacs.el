(require 'treemacs)

(defun treemacs-workspace-daemon ()
  (treemacs)
  (treemacs-block
   (treemacs-return-if (= 1 (length treemacs--workspaces))
                       'only-one-workspace)
   (let* ((workspaces (->> treemacs--workspaces
                           (--map (cons (treemacs-workspace->name it) it))))
          (selected (cdr (--first (string= (car it) (daemonp)) workspaces))))
     (setf (treemacs-current-workspace) selected)
     (treemacs--invalidate-buffer-project-cache)
     (treemacs--rerender-after-workspace-change)
     (run-hooks 'treemacs-switch-workspace-hook)
     )
   )
  )

(global-set-key (kbd "C-x t") (lambda () () (interactive) (treemacs-workspace-daemon)))


(provide 'my-treemacs)
