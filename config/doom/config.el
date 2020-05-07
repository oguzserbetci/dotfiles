;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-
(setq user-mail-address "oguz.serbetci@gmail.com"
      user-full-name "Oğuz Şerbetçi")

;; https://github.com/tecosaur/emacs-config/blob/master/config.org
(setq-default
 delete-by-moving-to-trash t                      ; Delete files to trash
 tab-width 4                                      ; Set width for tabs
 uniquify-buffer-name-style 'forward              ; Uniquify buffer names
 window-combination-resize t                      ; take new window space from all other windows (not just current)
 x-stretch-cursor t)                              ; Stretch cursor to the glyph width

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      inhibit-compacting-font-caches t)           ; When there are lots of glyphs, keep them in memory

(delete-selection-mode 1)                         ; Replace selection when inserting text
(display-time-mode 1)                             ; Enable time in the mode-line
(display-battery-mode 1)                          ; On laptops it's nice to know how much power you have
(global-subword-mode 1)                           ; Iterate through CamelCase words

;; UI
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq ns-auto-hide-menu-bar t)
(setq ns-toggle-toolbar nil)
(setq ns-right-alternate-modifier 'none)

(setq frame-resize-pixelwise t)

;; Performance improvement
(setq display-line-numbers-type nil)
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))
(setq hl-line-mode nil)

(load-theme 'doom-dracula t)

(setq avy-all-windows t
      display-line-numbers nil)

(setq doom-font (font-spec :family "Monaco" :size 12 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Monaco") ; inherits `doom-font''s :size
      doom-unicode-font (font-spec :family "Monaco" :size 12)
      doom-big-font (font-spec :family "Monaco" :size 19))

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

(use-package! org-ref
  :after org
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
  (setq org-latex-compiler "lualatex"
        org-latex-pdf-process (list
   "latexmk -pdflatex='lualatex -shell-escape -interaction nonstopmode' -pdf -f  %f"))
  )

(after! bibtex-completion
  (add-to-list 'bibtex-completion-additional-search-fields "journaltitle")
  (setq bibtex-completion-format-citation-functions
        '((org-mode . bibtex-completion-format-citation-pandoc-citeproc)
          (latex-mode . bibtex-completion-format-citation-cite)
          (default . bibtex-completion-format-citation-default))
        bibtex-completion-pdf-field "file"
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

(doom-themes-set-faces 'user '(org-roam-link :foreground green :slant 'italic :underline t :weight 'medium))

;; (advice-add #'org-journal-update-auto-mode-alist :override #'ignore)

;; (after! org-journal
;;   :custom
;;   (org-journal-file-format "%Y-%M-.org")
;;   (org-journal-dir "~/org/")
;;   :config
;;   (setq org-journal-file-header "#+TITLE: %Y – W%W")
;;   (setq org-journal-file-type 'weekly)
;;   (setq org-journal-date-format "%A, %d %B %Y")
;;   (setq org-journal-cache-file (concat doom-cache-dir "org-journal"))
;;   )
;;

;; TODO
;; (after! org
;;   (add-to-list 'org-capture-templates
;;                '("j" "Journal Entry"
;;                  entry (file+datetree "~/journal.org")
;;                  "* %?"
;;                  :empty-lines 1)
;;                )
;;   )

(after! ivy-bibtex
  (setq ivy-bibtex-default-action 'ivy-bibtex-insert-key)

  (when IS-MAC
    (ivy-bibtex-ivify-action bibtex-completion-quicklook ivy-bibtex-quicklook)
    (ivy-add-actions 'ivy-bibtex '(("SPC" ivy-bibtex-quicklook "Quick look"))))
  )

(custom-set-variables
 '(conda-anaconda-home "/usr/local/Caskroom/miniconda/base/")
 '(conda-env-autoactivate-mode t)
 )

(remove-hook 'text-mode-hook #'auto-fill-mode)
(add-hook 'message-mode-hook #'word-wrap-mode)

(setq +lsp-company-backend 'company-capf)
(after! lsp
  ;; (setq lsp-ui-doc-mode t)
  (setq lsp-print-io t)
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.0)

  ;; Performance
  (setq read-process-output-max (* 1024 1024) ; 1mb
        gc-cons-threshold 100000000
        company-backends '(company-capf company-yasnippet)
        lsp-idle-delay 0.500
        )

  (lsp-register-client
    (make-lsp-client :new-connection (lsp-tramp-connection "pyls")
                     :major-modes '(python-mode)
                     :remote? t
                     :server-id 'pyls-remote))

   (setq lsp-pyls-configuration-sources ["flake8"]
         lsp-pyls-plugins-pylint-enabled t
         lsp-pyls-plugins-pycodestyle-enabled t
         lsp-pyls-plugins-yapf-enabled t
         lsp-pyls-plugins-flake8-enabled t)
    )

(after! pdf-tools
  (setq pdf-annot-list-highlight-type t)
  (setq-default pdf-view-display-size 'fit-width)

  ;; (push '("f1fa8c" "ffb86c" "#50fa7b" "ff5555" "#8be9fd" "bd93f9" "ff79c6") pdf-annot-color-history)
    ;; https://github.com/politza/pdf-tools/issues/35
  ;; (push '(color . "#000000") pdf-annot-default-markup-annotation-properties)
  )

(after! org-pdftools
  (setq org-pdftools-root-dir "~/Resources/Papers"))

(setq org-directory "~/org/")

(after! org
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
           "[X](D)")))                  ; Task was completed
  )

(use-package! org-super-agenda
  :after org
  :config
  (setq org-super-agenda-mode t)

  (add-to-list 'org-agenda-custom-commands
       '("u" "Super view"
          ((agenda "" ((org-super-agenda-groups
                        '((:name "Today"
                                 :time-grid t)))))
           (todo "" ((org-agenda-overriding-header "NEXT")
                     (org-super-agenda-groups
                      '((:name none
                               :todo "NEXT")
                        (:discard (:anything t))
                        )))))))
  )

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
