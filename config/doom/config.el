;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; UI
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq ns-auto-hide-menu-bar t)
(setq ns-toggle-toolbar nil)
(setq ns-right-alternate-modifier 'none)

(setq frame-resize-pixelwise t)

(fset 'battery-update #'ignore)

(load-theme 'doom-dracula t)

(setq avy-all-windows t
      display-line-numbers nil)

(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Noto Sans") ; inherits `doom-font''s :size
      doom-unicode-font (font-spec :family "Fira Code" :size 12)
      doom-big-font (font-spec :family "Fira Code" :size 19))

(setq org-ellipsis " ↩")

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)

;; use gnu-ls https://stackoverflow.com/questions/25125200/emacs-error-ls-does-not-support-dired
(when (string= system-type "darwin")
  (setq dired-use-ls-dired t
        insert-directory-program "/usr/local/bin/gls"
        dired-listing-switches "-aBhl --group-directories-first"))

; LAYER CONFIG
;; :tools
;; ein
(map! :map ein:notebook-mode-map
      :localleader
      "," #'+ein/hydra/body)
;; (setq ein:console-args '("--simple-prompt" "--ssh" "jupyter-remote"))

(use-package! org-ref
  :after bibtex-completion
  :init
  (setq org-ref-completion-library 'org-ref-ivy-cite)

  :config
  (setq
   orhc-bibtex-cache-file (concat doom-cache-dir "org-ref.cache")
   org-ref-get-pdf-filename-function
   (lambda (key) (car (bibtex-completion-find-pdf key)))
   org-ref-notes-function
   (lambda (thekey)
     (let ((bibtex-completion-bibliography (org-ref-find-bibliography)))
       (bibtex-completion-edit-notes
        (list (car (org-ref-get-bibtex-key-and-file thekey))))))
   org-ref-show-broken-links nil)

  (setq org-ref-bibtex-hydra-key-binding "\C-c j")
  (global-set-key (kbd "\C-c l") #'org-ref-bibtex-hydra/body)
  (global-set-key (kbd "\C-c j") #'org-ref-open-pdf-at-point)
  (global-set-key (kbd "\C-c k") #'org-ref-open-notes-at-point)

  (setq org-ref-bibliography-notes org-directory
        org-ref-default-bibliography '("~/Resources/Papers/Library.bib")
        org-ref-pdf-directory "~/Resources/Papers/")

  (setq orhc-candidate-formats
   '(("article" . "${pdf}${note} ${author} ${year} ${title} ${keywords}")
     ("book" . "${pdf}${note} ${author} ${year} ${title} ${keywords}")
     ("inbook" . "${pdf}${note} ${author} ${year} ${title} ${keywords}")
     ("techreport" . "${pdf}${note} ${author} ${year} ${title} ${keywords}")
     ("inproceedings" . "${pdf}${note} ${author} ${year} ${title} ${keywords}")
     ("incollection" . "${pdf}${note} ${author} ${year} ${title} ${keywords}")
     ("phdthesis" . "${pdf}${note} ${author} ${year} ${title} ${keywords}")
     ("mastersthesis" . "${pdf}${note} ${author} ${year} ${title} ${keywords}")
     ("misc" . "${pdf}${note} ${author} ${year} ${title} ${keywords}")
     ("unpublished" . "${pdf}${note} ${author} ${year} ${title} ${keywords}"))
   )
  )

(use-package! bibtex
  :defer t
  :config
  (setq bibtex-dialect 'biblatex)
  (map! :map bibtex-mode-map
        [fill-paragraph] #'bibtex-fill-entry))

(use-package! bibtex-completion
  :after org
  :config
  (setq bibtex-completion-format-citation-functions
        '((org-mode . bibtex-completion-format-citation-pandoc-citeproc)
          (latex-mode . bibtex-completion-format-citation-cite)
          (default . bibtex-completion-format-citation-default))
        bibtex-completion-pdf-field "file"
        bibtex-completion-additional-search-fields '("journaltitle")
        bibtex-completion-pdf-symbol "@"
        bibtex-completion-notes-symbol "#"
        bibtex-completion-display-formats '((t . "${=has-pdf=:1}${=has-note=:1} ${author:20} ${year:4} ${title:*} ${=type=:3} ${journaltitle:10}")))

  (setq bibtex-completion-bibliography '("~/Resources/Papers/Library.bib")
        bibtex-completion-library-path "~/Resources/Papers/"
        bibtex-completion-notes-path org-directory)

  (setq bibtex-completion-notes-template-multiple-files
        "${author-abbrev} – ${title}
#+ROAM_KEY: cite:${=key=}
- tags ::
- keywords :: ${keywords}
* cite:${=key=}
  :PROPERTIES:
  :Custom_ID: ${=key=}
  :URL: ${url}
  :NOTER_DOCUMENT: ~/Resources/Papers/${file}
  :NOTER_PAGE:
  :END:\n\n")

  (cond
   (IS-MAC
    (setq bibtex-completion-pdf-open-function
          (lambda (fpath)
            (async-start-process "open" "open" "open" fpath))))
   (IS-LINUX
    (setq bibtex-completion-pdf-open-function
          (lambda (fpath)
            (async-start-process "open-pdf" "/usr/bin/xdg-open" nil fpath))))))

(setq reftex-default-bibliography '("~/Resources/Papers/Library.bib"))

(use-package! ivy-bibtex
  :when (featurep! :completion ivy)
  :commands (ivy-bibtex)
  :config
  (setq ivy-bibtex-default-action 'ivy-bibtex-insert-key)
  (add-to-list 'ivy-re-builders-alist '(ivy-bibtex . ivy--regex-plus))
  (global-set-key (kbd "\C-c \C-]") ivy-bibtex)
  (when IS-MAC
    (ivy-bibtex-ivify-action bibtex-completion-quicklook ivy-bibtex-quicklook)
    (ivy-add-actions 'ivy-bibtex '(("SPC" ivy-bibtex-quicklook "Quick look")))))

(use-package! org-noter
  :defer t
  :init
  :config
  (setq org-noter-notes-search-path '("~/org")))

(custom-set-variables
 '(conda-anaconda-home "/usr/local/Caskroom/miniconda/base/")
 '(conda-env-autoactivate-mode t)
 )

(remove-hook 'text-mode-hook #'auto-fill-mode)
(add-hook 'message-mode-hook #'word-wrap-mode)

(after! lsp
  (setq lsp-print-io t)
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.0)
  ;; Performance
  (setq read-process-output-max (* 1024 1024) ; 1mb
        lsp-prefer-capf t
        lsp-idle-delay 0.500
        )

  (add-hook 'lsp-mode #'lsp-ui-doc-mode)

  (setq ;; lsp-pyls-configuration-sources ["flake8"]
   ;; lsp-pyls-plugins-pylint-enabled t
   ;; lsp-pyls-plugins-pycodestyle-enabled t
   ;; lsp-pyls-plugins-yapf-enabled t
   ;; lsp-pyls-plugins-flake8-enabled t
   lsp-ui-doc-enable t
   lsp-ui-sideline-enable t)

  ;; (defun get-python-ver-and-syspath (workspace-root)
  ;;   "return list with pyver-string and json-encoded list of python search paths."
  ;;   (let ((python (executable-find python-shell-interpreter))
  ;;         (init "from __future__ import print_function; import sys; import json;")
  ;;         (ver "print(\"%s.%s\" % (sys.version_info[0], sys.version_info[1]));")
  ;;         (sp (concat "sys.path.insert(0, '" workspace-root "'); print(json.dumps(sys.path))")))
  ;;     (with-temp-buffer
  ;;       (call-process python nil t nil "-c" (concat init ver sp))
  ;;       (subseq (split-string (buffer-string) "\n") 0 2))))

  ;; (defun ms-pyls-extra-init-params (workspace)
  ;;   (destructuring-bind (pyver pysyspath) (get-python-ver-and-syspath (lsp--workspace-root workspace))
  ;;     `(:interpreter (
  ;;                     :properties (
  ;;                                  :InterpreterPath ,(executable-find python-shell-interpreter)
  ;;                                                   ;; this database dir will be created if required
  ;;                                  :DatabasePath ,(expand-file-name (concat ms-pyls-dir "db/"))
  ;;                                  :Version ,pyver))
  ;;                    ;; preferredFormat "markdown" or "plaintext"
  ;;                    ;; experiment to find what works best -- over here mostly plaintext
  ;;                    :displayOptions (
  ;;                                     :preferredFormat "plaintext"
  ;;                                     :trimDocumentationLines :json-false
  ;;                                     :maxDocumentationLineLength 0
  ;;                                     :trimDocumentationText :json-false
  ;;                                     :maxDocumentationTextLength 0)
  ;;                    :searchPaths ,(json-read-from-string pysyspath))))

  )

(defun oguz/timestamped-file ()
  (interactive)
  (let ((filename (expand-file-name (format "%s-%s.txt"
                              (format-time-string "%Y-%m-%d")
                              (read-string "Name: ")) "~/org/blog")))
    (if (called-interactively-p)
        (insert filename)
      filename)))

(after! pdf-tools
  (setq pdf-annot-list-highlight-type t)
  (setq-default pdf-view-display-size 'fit-width)

  ;; (push '("f1fa8c" "ffb86c" "#50fa7b" "ff5555" "#8be9fd" "bd93f9" "ff79c6") pdf-annot-color-history)
    ;; https://github.com/politza/pdf-tools/issues/35
  ;; (push '(color . "#000000") pdf-annot-default-markup-annotation-properties)
  )

(use-package! org-pdftools
  :config (setq org-pdftools-root-dir "/Users/oguz/Library/Mobile Documents/com~apple~CloudDocs/Resources/Papers"))


  (setq org-todo-keywords
        '((sequence
           "TODO(t)"   ; A task that needs doing & is ready to do
           "NEXT(n)"   ; A task that is to be started ASAP
           "STRT(s)"   ; A task that is in progress
           "PROJ(p)"   ; An ongoing project that cannot be completed in one step
           "WAIT(w)"   ; Something is holding up this task; or it is paused
           "|"
           "DONE(d)"    ; Task successfully completed
           "KILL(k)")   ; Task was cancelled, aborted or is no longer applicable
          (sequence
           "[ ](T)"                     ; A task that needs doing
           "[-](S)"                     ; Task is in progress
           "[?](W)"                     ; Task is being held up or paused
           "|"
           "[X](D)"))                   ; Task was completed
        )

;; (add-to-list 'org-capture-templates '("l" "Blog" plain (file (oguz/timestamped-file))
  ;;         "hello"))

(after! org
  (setq org-directory "~/org/"
        org-refile-targets '((org-agenda-files :maxlevel  3))))

(use-package! org-super-agenda
  :config
  (setq org-super-agenda-groups '((:name "Today"
                                         :time-grid t
                                         :scheduled today)
                                  (:name "Due today"
                                         :deadline today)
                                  (:name "Important"
                                         :priority "A")
                                  (:name "Overdue"
                                         :deadline past)
                                  (:name "Computer"
                                         :tag "@computer")
                                  (:name "Due soon"
                                         :deadline future)
                                  (:name "Big Outcomes"
                                         :tag "bo"))))

(setq org-publish-project-alist
      '(("org-notes"
         :base-directory (concat org-directory "/blog")
         :base-extension "org"
         :publishing-directory "~/Workspace/oguzserbetci.github.io/_posts/"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4             ; Just the default for this project.
         :auto-preamble t
         )
        ("org-static"
         :base-directory (concat org-directory "/blog")
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "~/Workspace/oguzserbetci.github.io/assets/"
         :recursive t
         :publishing-function org-publish-attachment
         )))

(setq magit-repository-directories '(("~/Workspace" . 2)
                                     ("~/.dotfiles" . 0)))

(add-hook! '(text-mode-hook
             org-mode-hook
             org-capture-mode-hook
             elisp-mode-hook
             python-mode-hook)
           +word-wrap-mode)

(setq +latex-viewers '(skim))

(provide 'config)
;;; config.el ends here
