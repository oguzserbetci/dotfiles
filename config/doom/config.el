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

(setenv "LIBRARY_PATH" (concat (getenv "LIBRARY_PATH")
                                 (when (getenv "LIBRARY_PATH") ":")
                                 ;; This is where Homebrew puts gcc libraries.
                                 (car (file-expand-wildcards "/usr/local/opt/gcc/lib/gcc/*"))))

(server-start)

; UI
(load-theme 'doom-dracula t)
;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)

;; Doom modeline
(setq doom-modeline-buffer-encoding nil
      doom-modeline-percent-position nil)

(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Fira Code") ; inherits `doom-font''s :size
      doom-unicode-font (font-spec :family "Fira Code" :size 12)
      doom-big-font (font-spec :family "Fira Code" :size 19))

(setq +treemacs-git-mode 'deferred)

;; Title bar
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq ns-auto-hide-menu-bar t)
(setq ns-toggle-toolbar nil)
(setq ns-right-alternate-modifier nil)

(setq frame-resize-pixelwise t)

(setq which-key-idle-delay 0.5) ;; I need the help, I really do

;; Performance improvement
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))
(setq display-line-numbers-type nil)
(setq smartparens-global-mode nil)
(setq read-process-output-max (* 8 1024 1024) ; 1mb
      gc-cons-threshold (* 8 1024 1024))
(run-with-idle-timer 2 t (lambda () (garbage-collect)))

(setq avy-all-windows t)

;; use gnu-ls https://stackoverflow.com/questions/25125200/emacs-error-ls-does-not-support-dired
(when (string= system-type "darwin")
  (setq dired-use-ls-dired t
        insert-directory-program "/usr/local/bin/gls"
        dired-listing-switches "-aBhl --group-directories-first"))

; MODULE CONFIG
;; :tools
;; ein
(map! :map ein:notebook-mode-map
      :localleader
      "," #'+ein/hydra/body)

(use-package! org-ref
  :after org
  :preface
  (setq org-ref-completion-library #'org-ref-ivy-cite)
  :config
  (setq bibtex-dialect 'biblatex
        orhc-bibtex-cache-file (concat doom-cache-dir "org-ref.cache")
        ;; org-ref-get-pdf-filename-function (lambda (key)
        ;;                                     (car (bibtex-completion-find-pdf key)))
        org-ref-open-pdf-function 'org-ref-get-pdf-filename-helm-bibtex
        org-ref-notes-function (lambda (thekey)
                                 (let ((bibtex-completion-bibliography (org-ref-find-bibliography)))
                                   (bibtex-completion-edit-notes
                                    (list (car (org-ref-get-bibtex-key-and-file thekey))))))
        org-ref-show-broken-links nil)

  (setq org-ref-bibtex-hydra-key-binding "\C-c j")
  (global-set-key (kbd "\C-c l") #'org-ref-bibtex-hydra/body)
  (global-set-key (kbd "\C-c j") #'org-ref-open-pdf-at-point)
  (global-set-key (kbd "\C-c k") #'org-ref-open-notes-at-point)

  (setq org-ref-bibliography-notes org-directory
        org-ref-default-bibliography '("~/Resources/Papers/Library.bib" "~/Resources/Calibre/My Books.bib")
        org-ref-pdf-directory "~/Resources/Papers/")

  (setq org-latex-compiler "lualatex"
        org-latex-pdf-process (list
                               "latexmk -pdflatex='lualatex -shell-escape -interaction nonstopmode' -pdf -f  %f"))

 )

(after! org-ref
  (setq bibtex-completion-pdf-field "file"
        bibtex-completion-display-formats '((t . "${=has-pdf=:1}${=has-note=:1} ${author:20} ${year:4} ${title:*} ${=type=:3} ${journaltitle:10}")))

  (setq bibtex-completion-bibliography '("~/Resources/Papers/Library.bib"
                                         "~/Resources/Calibre/My Books.bib")
        bibtex-completion-library-path "~/Resources/Papers/"
        bibtex-completion-notes-path (concat org-directory "roam"))

  ;; (setf (cdr (assoc 'org-mode bibtex-completion-format-citation-functions)) 'org-ref-format-citation)

  (add-to-list 'bibtex-completion-additional-search-fields "journaltitle")
  (setq bibtex-completion-notes-template-multiple-files
        "${author-abbrev} – ${title}
#+roam_key: cite:${=key=}
#+roam_tags: paper

Keywords: ${keywords}
Related:
Upon:

* Notes on cite:${=key=}
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
            (async-start-process "open-pdf" "/usr/bin/xdg-open" nil fpath)))))
  )

(after! org-roam
  (setq org-roam-tag-sources '(prop all-directories))
  )

(after! lsp
  (setq lsp-response-timeout 30))

(setq reftex-default-bibliography '("~/Resources/Papers/Library.bib" "~/Resources/Calibre/My Books.bib"))

(after! ivy-bibtex
  ;; (setq ivy-bibtex-default-action 'ivy-bibtex-insert-key)
  (ivy-set-display-transformer 'org-ref-ivy-insert-cite-link
                               'ivy-bibtex-display-transformer)

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
(setq deft-directory org-directory)
(after! org
  (setq org-todo-keywords
        '((sequence
           "[ ](T)"    ; A task that needs proper definition, tagging, etc.
           "TODO(t)"  ; A task that needs doing & is ready to do
           "NEXT(n)"  ; A task that is to be started ASAP
           "STRT(s)" ; A task that is in progress
           "PROJ(p)"   ; An ongoing project that cannot be completed in one step
           "WAIT(w)" ; Something is holding up this task; or it is paused
           "|"
           "DONE(d)"    ; Task successfully completed
           "KILL(k)"))) ; Task was cancelled, aborted or is no longer applicable

  (remove-hook 'org-mode-hook #'org-superstar-mode) ;; performance tip
  (setq org-startup-folded t
        org-hide-block-startup t)

  (defun org-archive-done-in-subtree ()
    (interactive)
    (org-map-entries
     (lambda ()
       (org-archive-subtree)
       (setq org-map-continue-from (org-element-property :begin (org-element-at-point))))
     "/DONE|KILL" 'tree))

  (defun org-archive-done-in-file ()
    (interactive)
    (org-map-entries
     (lambda ()
       (org-archive-subtree)
       (setq org-map-continue-from (org-element-property :begin (org-element-at-point))))
     "/DONE|KILL" 'file))
  )

(after! org-agenda
  (setq org-stuck-projects
        '("/+PROJ" ("NEXT" "WAIT" "STRT") nil "")
        org-agenda-skip-deadline-prewarning-if-scheduled t)

  (add-to-list 'org-agenda-custom-commands
               '("W" "Weekly Review"
                 ((agenda "" ((org-agenda-span 7))) ; review upcoming deadlines and appointments
                                        ; type "l" in the agenda to review logged items
                  (stuck "") ; review stuck projects as designated by org-stuck-projects
                  (todo "STRT")
                  (todo "NEXT")
                  (todo "WAIT")
                  (todo "PROJ")
                  ))
               )
  (add-to-list 'org-agenda-custom-commands
               '("T" "Daily Planing"
                 ((agenda "" ((org-agenda-span 1))) ; review upcoming deadlines and appointments
                                        ; type "l" in the agenda to review logged items
                  (todo "STRT")
                  (todo "NEXT")
                  (todo "WAIT")
                  ))
               )
  (append
   '(("g" . "GTD contexts")
     ("gw" "@unterwegs" tags-todo "@unterwegs")
     ("gu" "@uni" tags-todo "@uni")
     ("go" "@office" tags-todo "@office")
     ("gh" "@home" tags-todo "@home")
     ("gc" "@computer" tags-todo "@computer")
     ("gp" "@phone" tags-todo "@phone")
     ("G" "GTD Block Agenda"
      ((tags-todo "@unterwegs")
       (tags-todo "@uni")
       (tags-todo "@office")
       (tags-todo "@home")
       (tags-todo "@computer")
       (tags-todo "@phone"))
      nil)) ;; i.e., no local settings
   'org-agenda-custom-commands)
  )

(map!
 :prefix "gz"
 :nv "s" #'evil-mc-skip-and-goto-next-match
 :nv "S" #'evil-mc-skip-and-goto-prev-match)

(setq magit-repository-directories '(("~/Workspace" . 2)
                                     ("~/.dotfiles" . 0)))

;; (add-hook! '(text-mode-hook
;;              org-mode-hook
;;              org-capture-mode-hook
;;              elisp-mode-hook
;;              python-mode-hook)
;;            +word-wrap-mode)

(setq +latex-viewers '(skim))

(provide 'config)
;;; config.el ends here
