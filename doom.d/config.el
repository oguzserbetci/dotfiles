;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(add-to-list 'exec-path "~/.pyenv/shims")
(setq frame-resize-pixelwise t)

(load-theme 'doom-dracula t)

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)

;; use gnu-ls https://stackoverflow.com/questions/25125200/emacs-error-ls-does-not-support-dired
(when (string= system-type "darwin")
  (setq dired-use-ls-dired t
        insert-directory-program "/usr/local/bin/gls"
        dired-listing-switches "-aBhl --group-directories-first"))

;; deft
(setq deft-extensions '("org"))
(setq deft-directory "~/org")

(def-package! org-ref
    :after org
    :init
    ; code to run before loading org-ref
    :config
    (setq reftex-default-bibliography '("~/Resources/Papers/Library.bib"))
    (setq org-ref-bibliography-notes "~/org/papers.org"
          org-ref-default-bibliography '("~/Resources/Papers/Library.bib")
          org-ref-pdf-directory "~/Resources/Papers/")
    ; code to run after loading org-ref
    )

(def-package! org-brain
    :after org
    :init
    ; code to run before loading org-ref
    (setq org-brain-path "~/org/brain")
    ;; For Evil users
    (with-eval-after-load 'evil
      (evil-set-initial-state 'org-brain-visualize-mode 'emacs))
    :config
    (setq org-id-track-globally t)
    (setq org-id-locations-file "~/.emacs.d/.org-id-locations")
    (push '("b" "Brain" plain (function org-brain-goto-end)
            "* %i%?" :empty-lines 1)
          org-capture-templates)
    (setq org-brain-visualize-default-choices 'all)
    (setq org-brain-title-max-length 12)
    (setq org-brain-include-file-entries nil
          org-brain-file-entries-use-title nil)
)

(setq org-directory "~/org")

; wrapping
(setq visual-line-mode t
      truncate-lines nil
      auto-fill-mode nil)

(defun oguz/timestamped-file ()
  (interactive)
  (let ((filename (expand-file-name (format "%s-%s.txt"
                              (format-time-string "%Y-%m-%d")
                              (read-string "Name: ")) "~/org/blog")))
    (if (called-interactively-p)
        (insert filename)
      filename)))


(after! org
  (add-to-list 'org-capture-templates '("l" "Blog" plain (file (oguz/timestamped-file))
          "hello")))

(require 'ox-publish)
(setq org-publish-project-alist
    '(("org-notes"
       :base-directory "~/org/blog"
       :base-extension "org"
       :publishing-directory "~/Workspace/oguzserbetci.github.io/_posts/"
       :recursive t
       :publishing-function org-html-publish-to-html
       :headline-levels 4             ; Just the default for this project.
       :auto-preamble t
       )
      ("org-static"
       :base-directory "~/org/blog"
       :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
       :publishing-directory "~/Workspace/oguzserbetci.github.io/assets/"
       :recursive t
       :publishing-function org-publish-attachment
       )))


(menu-bar-mode t)

(server-start)

(provide 'config)
;;; config.el ends here
