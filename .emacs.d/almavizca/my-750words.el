;;; my-750words --- local settings
;;; Comentary: used with docker
(require '750words)
(require 'ox-750words)

(750words-credentials-setenv t)
(setq 750words-client-command "cat %s | docker run --rm --name 750 -i -e USER_750WORDS -e PASS_750WORDS zzamboni/750words-client")

(provide 'my-750words)
;;; my-750words ends here
