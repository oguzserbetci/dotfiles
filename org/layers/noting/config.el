(with-eval-after-load 'org
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
        (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
                (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)")
                )))

  (setq org-todo-keyword-faces
        (quote (("TODO" :foreground "red" :weight bold)
                ("IDEA" :foreground "red" :weight bold)
                ("NEXT" :foreground "deep sky blue" :weight bold)
                ("DRAFT" :foreground "deep sky blue" :weight bold)
                ("DONE" :foreground "forest green" :weight bold)
                ("WAITING" :foreground "orange" :weight bold)
                ("HOLD" :foreground "magenta" :weight bold)
                ("PUBLISHED" :foreground "forest green" :weight bold)
                ("CANCELLED" :foreground "forest green" :weight bold))))

  (setq org-archive-mark-done nil)
  (setq org-archive-location "%s_archive::* Archived Tasks")
)

(with-eval-after-load 'org-ref
  (setq reftex-default-bibliography '("~/Resources/Papers/library.bib"))
  ;; (setq org-ref-open-pdf-function 'org-ref-get-mendeley-filename)
  (setq org-ref-default-bibliography '("~/Resources/Papers/library.bib")
        org-ref-pdf-directory "~/Resources/Papers/"
        org-ref-bibliography-notes "~/org/papers.org")

  ;; open pdf with system pdf viewer (works on mac)
  (setq bibtex-completion-pdf-open-function
        (lambda (fpath)
          (start-process "open" "*open*" "open" fpath)))
)

(with-eval-after-load 'org-download
  (setq org-download-screenshot-method "/usr/sbin/screencapture")
  (setq org-download-image-dir "~/org/image")
  (setq org-download-screenshot-file (last (cl-sort (directory-files "~/Desktop" "full" "^Screenshot .*" nil) 'string-lessp)))
)

(with-eval-after-load 'org-brain
  (push '("b" "Brain" plain (function org-brain-goto-end)
          "* %i%?" :empty-lines 1)
        org-capture-templates)
)

(with-eval-after-load 'org-agenda
  (setq org-agenda-files '("~/org"))

  (setq org-refile-targets '((nil :maxlevel . 9)
                             (org-agenda-files :maxlevel . 9)))

  ;; projectile
  (with-eval-after-load 'org-projectile
    (setq org-agenda-files (append org-agenda-files (org-projectile-todo-files)))
  )
)

