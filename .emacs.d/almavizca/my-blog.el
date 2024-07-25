;;; my-blog --- Personal blog settings
;;; Commentary:
;;; Code:

(require 'bookmark)

(use-package esxml
  :ensure t)

(require 'ox-publish)

(defvar av/blog-name "AlMaVizca")

;; (defvar av/site-url (if (string-equal (getenv "CI") "true")
;;                         "https://almavizca.xyz"
;;                       "http://almavizca.docker")
;;   "The URL for the site being generated.")

(defun av/build-path (path)
  (concat (bookmark-get-filename "blog") path))

(setq
 assets-path (av/build-path "assets")
 content-path (av/build-path "content")
 cv-path (av/build-path "cv")
 news-path (av/build-path "news")
 website-path (av/build-path "public")
 website-assets-path (av/build-path "public/assets")
 website-news-path (av/build-path "public/news")
 org-publish-project-alist  `(
                              ("blog:main"
                               :recursive t
                               :base-directory ,content-path
                               :publishing-directory ,website-path
                               ;; :publishing-function org-html-publish-to-html
                               :with-author nil
                               :with-creator nil
                               :with-toc nil
                               :section-numbers nil
                               :time-stamp-file nil
                               :html-preamble av/website-html-preamble
                               :html-postamble av/website-html-postamble
                               )
                              ;; ("blog:cv"
                              ;;  :base-directory ,cv-path
                              ;;  :publishing-directory ,website-path
                              ;;  :publishing-function org-latex-publish-to-pdf
                              ;;  )
                              ("blog:assets"
                               :base-directory  ,assets-path
                               :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|woff2\\|ttf\\|asc"
                               :publishing-directory ,website-assets-path
                               :recursive t
                               :publishing-function org-publish-attachment
                               )
                              ;; ("blog:news"
                              ;;  :base-directory ,news-path
                              ;;  :publishing-directory ,website-news-path
                              ;;  :publishing-function org-html-publish-to-html
                              ;;  :auto-sitemap t
                              ;;  :sitemap-filename "../news.org"
                              ;;  ;; :sitemap-title "AlMaVizcaSystem Crafters News"
                              ;;  :sitemap-format-entry av/format-news-entry
                              ;;  :sitemap-style list
                              ;;  ;; :sitemap-function dw/news-sitemap
                              ;;  :sitemap-sort-files anti-chronologically
                              ;;  :with-title nil
                              ;;  :with-timestamps nil)
                              ("blog" :components ("blog:main" "blog:assets")))
 webfeeder-title-function #'av/rss-extract-title
 webfeeder-date-function #'av/rss-extract-date
 )

(defun av/website-path ()
  (concat (bookmark-get-filename "blog") "content")
  )

(defun av/website-html-preamble (plist)
  "PLIST: An entry."
  ;; Preamble
  (with-temp-buffer
    (insert-file-contents (concat (bookmark-get-filename "blog") "html/preamble.html" )) (buffer-string)))

(defun av/website-html-postamble (plist)
  "PLIST: An entry."
  ;; Preamble
  (with-temp-buffer
    (insert-file-contents (concat (bookmark-get-filename "blog") "html/postamble.html" )) (buffer-string)))


(defun get-article-output-path (org-file pub-dir)
  (let ((article-dir (concat pub-dir
                             (downcase
                              (file-name-as-directory
                               (file-name-sans-extension
                                (file-name-nondirectory org-file)))))))

    (if (string-match "\\/index.org\\|\\/404.org$" org-file)
        pub-dir
      (progn
        (unless (file-directory-p article-dir)
          (make-directory article-dir t))
        article-dir))))

(defun av/org-html-link (link contents info)
  "Removes file extension and changes the path into lowercase file:// links."
  (when (and (string= 'file (org-element-property :type link))
             (string= "org" (file-name-extension (org-element-property :path link))))
    (org-element-put-property link :path
                              (downcase
                               (file-name-sans-extension
                                (org-element-property :path link)))))

  (let ((exported-link (org-export-custom-protocol-maybe link contents 'html info)))
    (cond
     (exported-link exported-link)
     ((equal contents nil)
      (format "<a href=\"%s\">%s</a>"
              (org-element-property :raw-link link)
              (org-element-property :raw-link link)))
     ((string-prefix-p "/" (org-element-property :raw-link link))
      (format "<a href=\"%s\">%s</a>"
              (org-element-property :raw-link link)
              contents))
     (t (org-export-with-backend 'html link contents info)))))

(defun av/make-heading-anchor-name (headline-text)
  (thread-last headline-text
               (downcase)
               (replace-regexp-in-string " " "-")
               (replace-regexp-in-string "[^[:alnum:]_-]" "")))

(defun av/org-html-headline (headline contents info)
  (let* ((text (org-export-data (org-element-property :title headline) info))
         (level (org-export-get-relative-level headline info))
         (level (min 7 (when level (1+ level))))
         (anchor-name (av/make-heading-anchor-name text))
         (attributes (org-element-property :ATTR_HTML headline))
         (container (org-element-property :HTML_CONTAINER headline))
         (container-class (and container (org-element-property :HTML_CONTAINER_CLASS headline))))
    (when attributes
      (setq attributes
            (format " %s" (org-html--make-attribute-string
                           (org-export-read-attribute 'attr_html `(nil
                                                                   (attr_html ,(split-string attributes))))))))
    (concat
     (when (and container (not (string= "" container)))
       (format "<%s%s>" container (if container-class (format " class=\"%s\"" container-class) "")))
     (if (not (org-export-low-level-p headline info))
         (format "<h%d%s><a id=\"%s\" class=\"anchor\" href=\"#%s\"></a>%s</h%d>%s"
                 level
                 (or attributes "")
                 anchor-name
                 anchor-name
                 text
                 level
                 (or contents ""))
       (concat
        (when (org-export-first-sibling-p headline info) "<ul>")
        (format "<li>%s%s</li>" text (or contents ""))
        (when (org-export-last-sibling-p headline info) "</ul>")))
     (when (and container (not (string= "" container)))
       (format "</%s>" (cl-subseq container 0 (cl-search " " container)))))))

(defun av/org-html-src-block (src-block _contents info)
  (let* ((lang (org-element-property :language src-block))
         (code (org-html-format-code src-block info)))
    (format "<pre>%s</pre>" (string-trim code))))

(defun av/org-html-special-block (special-block contents info)
  "Transcode a SPECIAL-BLOCK element from Org to HTML.
CONTENTS holds the contents of the block.  INFO is a plist
holding contextual information."
  (let* ((block-type (org-element-property :type special-block))
         (attributes (org-export-read-attribute :attr_html special-block)))
    (format "<div class=\"%s center\">\n%s\n</div>"
            block-type
            (or contents
                (if (string= block-type "cta")
                    "If you find this guide helpful, please consider supporting System Crafters via the links on the <a href=\"/how-to-help/#support-my-work\">How to Help</a> page!"
                  "")))))

(defun av/rss-extract-title (html-file)
  "Extract the title from an HTML file."
  (with-temp-buffer
    (insert-file-contents html-file)
    (let ((dom (libxml-parse-html-region (point-min) (point-max))))
      (dom-text (car (dom-by-class dom "site-post-title"))))))

(defun av/rss-extract-date (html-file)
  "Extract the post date from an HTML file."
  (with-temp-buffer
    (insert-file-contents html-file)
    (let* ((dom (libxml-parse-html-region (point-min) (point-max)))
           (date-string (dom-text (car (dom-by-class dom "site-post-meta"))))
           (parsed-date (parse-time-string date-string))
           (day (nth 3 parsed-date))
           (month (nth 4 parsed-date))
           (year (nth 5 parsed-date)))
      ;; NOTE: Hardcoding this at 8am for now
      (encode-time 0 0 8 day month year))))


(defun av/org-html-template (contents info)
  "Return complete document string after HTML conversion.
CONTENTS is the transcoded contents string.  INFO is a plist
holding export options."
  (concat
   (when (and (not (org-html-html5-p info)) (org-html-xhtml-p info))
     (let* ((xml-declaration (plist-get info :html-xml-declaration))
            (decl (or (and (stringp xml-declaration) xml-declaration)
                      (cdr (assoc (plist-get info :html-extension)
                                  xml-declaration))
                      (cdr (assoc "html" xml-declaration))
                      "")))
       (when (not (or (not decl) (string= "" decl)))
         (format "%s\n"
                 (format decl
                         (or (and org-html-coding-system
                                  ;; FIXME: Use Emacs 22 style here, see `coding-system-get'.
                                  (coding-system-get org-html-coding-system 'mime-charset))
                             "iso-8859-1"))))))
   (org-html-doctype info)
   "\n"
   (concat "<html"
           (cond ((org-html-xhtml-p info)
                  (format
                   " xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"%s\" xml:lang=\"%s\""
                   (plist-get info :language) (plist-get info :language)))
                 ((org-html-html5-p info)
                  (format " lang=\"%s\"" (plist-get info :language))))
           ">\n")
   "<head>\n"
   (org-html--build-meta-info info)
   (org-html--build-head info)
   (org-html--build-mathjax-config info)
   "</head>\n"
   "<body>\n"
   (let ((link-up (org-trim (plist-get info :html-link-up)))
         (link-home (org-trim (plist-get info :html-link-home))))
     (unless (and (string= link-up "") (string= link-home ""))
       (format (plist-get info :html-home/up-format)
               (or link-up link-home)
               (or link-home link-up))))
   ;; Preamble.
   (org-html--build-pre/postamble 'preamble info)
   ;; Document contents.
   (let ((div (assq 'content (plist-get info :html-divs))))
     ;; replaced first element to avoid nil tag
     (message div)
     (format "<%s id=\"%s\" class=\"%s\">\n"
             "div"
             (nth 2 div)
             (plist-get info :html-content-class)))
   ;; Document title.
   (when (plist-get info :with-title)
     (let ((title (and (plist-get info :with-title)
                       (plist-get info :title)))
           (subtitle (plist-get info :subtitle))
           (html5-fancy (org-html--html5-fancy-p info)))
       (when title
         (format
          (if html5-fancy
              "<header>\n<h1 class=\"title\">%s</h1>\n%s</header>"
            "<h1 class=\"title\">%s%s</h1>\n")
          (org-export-data title info)
          (if subtitle
              (format
               (if html5-fancy
                   "<p class=\"subtitle\" role=\"doc-subtitle\">%s</p>\n"
                 (concat "\n" (org-html-close-tag "br" nil info) "\n"
                         "<span class=\"subtitle\">%s</span>\n"))
               (org-export-data subtitle info))
            "")))))
   contents
   "</div>\n"
   ;; Postamble.
   (org-html--build-pre/postamble 'postamble info)
   ;; Possibly use the Klipse library live code blocks.
   (when (plist-get info :html-klipsify-src)
     (concat "<script>" (plist-get info :html-klipse-selection-script)
             "</script><script src=\""
             org-html-klipse-js
             "\"></script><link rel=\"stylesheet\" type=\"text/css\" href=\""
             org-html-klipse-css "\"/>"))
   ;; Closing document.
   "</body>\n</html>"))



;; (defun av/org-html-template (contents info)
;;   (av/generate-page (org-export-data (plist-get info :title) info)
;;                     contents
;;                     info
;;                     :publish-date (org-export-data (org-export-get-date info "%B %e, %Y") info)))

;; (org-export-get-backend 'html)
(org-export-define-derived-backend 'site-html 'html
  :translate-alist
  '(
    (template . av/org-html-template)
    (link . av/org-html-link)
    (src-block . av/org-html-src-block)
    (special-block . av/org-html-special-block)
    (headline . av/org-html-headline))
  :options-alist
  '(
    (:video "VIDEO" nil nil)
    )
  )

(defun org-html-publish-to-html (plist filename pub-dir)
  "Publish an org file to HTML, using the FILENAME as the output directory."
  (let ((article-path (get-article-output-path filename pub-dir)))
    (cl-letf (((symbol-function 'org-export-output-file-name)
               (lambda (extension &optional subtreep pub-dir)
                 ;; The 404 page is a special case, it must be named "404.html"
                 (concat article-path
                         (if (string= (file-name-nondirectory filename) "404.org") "404" "index")
                         extension))))
      (org-publish-org-to 'site-html
                          filename
                          (concat "." (or (plist-get plist :html-extension)
                                          "html"))
                          plist
                          article-path)))
  )

(defun org-html--build-pre/postamble (type info)
  "Return document preamble or postamble as a string, or nil.
TYPE is either `preamble' or `postamble', INFO is a plist used as a
communication channel."
  (let ((section (plist-get info (intern (format ":html-%s" type))))
        (spec (org-html-format-spec info)))
    (when section
      (let ((section-contents
             (if (functionp section) (funcall section info)
               (cond
                ((stringp section) (format-spec section spec))
                ((eq section 'auto)
                 (let ((date (cdr (assq ?d spec)))
                       (author (cdr (assq ?a spec)))
                       (email (cdr (assq ?e spec)))
                       (creator (cdr (assq ?c spec)))
                       (validation-link (cdr (assq ?v spec))))
                   (concat
                    (and (plist-get info :with-date)
                         (org-string-nw-p date)
                         (format "<p class=\"date\">%s: %s</p>\n"
                                 (org-html--translate "Date" info)
                                 date))
                    (and (plist-get info :with-author)
                         (org-string-nw-p author)
                         (format "<p class=\"author\">%s: %s</p>\n"
                                 (org-html--translate "Author" info)
                                 author))
                    (and (plist-get info :with-email)
                         (org-string-nw-p email)
                         (format "<p class=\"email\">%s: %s</p>\n"
                                 (org-html--translate "Email" info)
                                 email))
                    (and (plist-get info :time-stamp-file)
                         (format
                          "<p class=\"date\">%s: %s</p>\n"
                          (org-html--translate "Created" info)
                          (format-time-string
                           (plist-get info :html-metadata-timestamp-format))))
                    (and (plist-get info :with-creator)
                         (org-string-nw-p creator)
                         (format "<p class=\"creator\">%s</p>\n" creator))
                    (and (org-string-nw-p validation-link)
                         (format "<p class=\"validation\">%s</p>\n"
                                 validation-link)))))
                (t
                 (let ((formats (plist-get info (if (eq type 'preamble)
                                                    :html-preamble-format
                                                  :html-postamble-format)))
                       (language (plist-get info :language)))
                   (format-spec
                    (cadr (or (assoc-string language formats t)
                              (assoc-string "en" formats t)))
                    spec)))))))
        (let ((div (assq type (plist-get info :html-divs))))
          (when (org-string-nw-p section-contents)
            (concat
             (org-element-normalize-string section-contents)
             )))))))


(org-link-set-parameters
 "yt"
 :follow
 (lambda (handle)
   (browse-url
    (concat "https://www.youtube.com/watch?v="
            handle)))
 :export
 (lambda (path desc backend channel)
   (when (eq backend 'html)
     (dw/embed-video path))))

(provide 'my-blog)
