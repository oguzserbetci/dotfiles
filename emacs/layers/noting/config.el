; ORG
(setq org-capture-templates (list))

;; visual
(setq org-startup-indented t)
(setq org-indent-mode t)

(setq org-hide-leading-stars t)

(setq org-ellipsis " ⤵")

;; notes
(push '("n" "note" entry (file "~/org/refile.org")
        "* %? :NOTE:\n%U\n%a\n"
        :clock-in t :clock-resume t)
      org-capture-templates)

; TODO better solution
(push '("a" "Annotate" entry (file "~/org/refile.org")
        "* [[%^{link}][%^{title}]] :NOTE:\n%U\n%a\n%?"
        :clock-in t)
      org-capture-templates)

;; tasks
(setq org-index-file "~/org/home.org")

(push '("t" "todo" entry
        (file+headline org-index-file "Inbox")
        "* TODO %?\n")
      org-capture-templates)

(push '("T" "task" entry
        (file+headline org-index-file "Inbox")
        "* NEXT %?\n"
        :clock-in t :clock-resume
        )
      org-capture-templates)

(setq org-log-done 'time)

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(x)" "CURRENT(c)" "|" "DONE(d)")
              ;; (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)")
              (sequence "QUESTION(q)" "NOTE(n)" "IDEA(i)" "DRAFT(f)")
              )))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("IDEA" :foreground "red" :weight bold)
              ("NEXT" :foreground "deep sky blue" :weight bold)
              ("CURRENT" :foreground "purple" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("QUESTION" :foreground "red" :weight bold)
              ("NOTE" :foreground "yellow" :weight bold)
              ("DRAFT" :foreground "yellow" :weight bold)
              ("IDEA" :foreground "orange" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold))))

(setq org-archive-mark-done nil)
(setq org-archive-location "%s_archive::* Archived Tasks")

(setq reftex-default-bibliography '("~/Resources/Papers/library3.bib"))
(setq org-ref-default-bibliography '("~/Resources/Papers/library3.bib")
      org-ref-pdf-directory ""
      bibtex-completion-pdf-field "file"
      org-ref-get-pdf-filename-function 'org-ref-get-zotero-pdf-filename)

(defun org-ref-get-zotero-pdf-filename (key)
  "Return the pdf filename indicated by zotero file field.
Argument KEY is the bibtex key."
  (let* ((results (org-ref-get-bibtex-key-and-file key))
         (bibfile (cdr results))
         entry)
    (with-temp-buffer
      (insert-file-contents bibfile)
      (bibtex-set-dialect (parsebib-find-bibtex-dialect) t)
      (bibtex-search-entry key nil 0)
      (setq entry (bibtex-parse-entry))
      (let ((e (org-ref-reftex-get-bib-field "file" entry)))
        (if (> (length e) 4)
            (let ((clean-field (replace-regexp-in-string "/+" "/" e)))
              (let ((first-file (car (split-string clean-field ";" t))))
                (concat org-ref-pdf-directory first-file)))
          (message "PDF filename not found.")
          )))))

(defun org-ref-open-bibtex-pdf ()
  "Open pdf for a bibtex entry, if it exists.
assumes point is in
the entry of interest in the bibfile.  but does not check that."
  (interactive)
  (save-excursion
    (bibtex-beginning-of-entry)
    (let* ((bibtex-expand-strings t)
           (entry (bibtex-parse-entry t))
           (key (reftex-get-bib-field "=key=" entry))
           (pdf (org-ref-get-zotero-pdf-filename key)))
      (message "%s" pdf)
      (if (file-exists-p pdf)
          (org-open-link-from-string (format "[[file:%s]]" pdf))
        (ding)))))

(setq bibtex-completion-pdf-open-function
      (lambda (fpath)
        (start-process "open" "*open*" "open" fpath)))

(setq org-download-screenshot-method "/usr/sbin/screencapture")
(setq org-download-image-dir "~/org/image")
(setq org-download-screenshot-file (last (cl-sort (directory-files "~/Desktop" "full" "^Screenshot .*" nil) 'string-lessp)))

(push '("b" "Brain" plain (function org-brain-goto-end)
        "* %i%?" :empty-lines 1)
      org-capture-templates)

(setq org-agenda-files '("~/org" "~/org/brain"))

(setq org-refile-targets '((nil :maxlevel . 9)
                            (org-agenda-files :maxlevel . 9)))

(with-eval-after-load 'org-agenda
  (require 'org-projectile)
  (mapcar #'(lambda (file)
                 (when (file-exists-p file)
                   (push file org-agenda-files)))
          (org-projectile-todo-files)))
