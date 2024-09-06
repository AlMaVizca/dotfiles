;;; Directory Local Variables            -*- no-byte-compile: t -*-
;;; This file is a template for projectile managment, with pre defined
;;; actions to be performed with keybindings

((nil .(
        (projectile-project-package-cmd . "tmux send-keys -t $SESSION:$SESSION 'make build' ENTER") ;; (C-c p K)
        (projectile-project-compilation-cmd . "tmux send-keys -t $SESSION:$SESSION 'make build' ENTER") ;; (C-c p c)
        (projectile-project-run-cmd . "tmux send-keys -t $SESSION:$SESSION 'make start' ENTER") ;; (C-c p u)
        (projectile-project-test-cmd . "tmux send-keys -t $SESSION:$SESSION 'make test' ENTER") ;; (C-c p P)
        )))
