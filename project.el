(require 'ox-publish)

(setq org-html-htmlize-output-type 'css)  ; default value is ‘inline-css’

(defun my-org-confirm-babel-evaluate (lang body)
  (not (seq-contains '("mermaid" "ditaa" "R") lang)))

(setq org-confirm-babel-evaluate #'my-org-confirm-babel-evaluate)

(setq org-publish-project-alist
      '(("org"
         :base-directory ""
         :publishing-directory "../html"
         :exclude "\\^_"
         :html-postamble nil
         :recursive t
         :publishing-function org-html-publish-to-html
         :html-head-include-default-style nil
         :html-htmlized-css-url "http://gongzhitaao.org/orgcss/org.css")
        ("images"
         :base-directory "images"
         :publishing-directory "../html/images"
         :base-extension ".*"
         :recursive t
         :publishing-function org-publish-attachment)))
