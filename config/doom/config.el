;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; UI
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq ns-auto-hide-menu-bar t)
(setq ns-toggle-toolbar nil)
(setq ns-right-alternate-modifier 'none)

(setq frame-resize-pixelwise t)

(fset 'battery-update #'ignore)

(load-theme 'doom-opera t)

(setq doom-font (font-spec :family "Fira Code" :size 14 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Fira Sans") ; inherits `doom-font''s :size
      doom-unicode-font (font-spec :family "Fira Code" :size 12)
      doom-big-font (font-spec :family "Fira Code" :size 19))

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

;; org-mode setup
(setq org-directory "~/org")
(use-package! org-ref
    :after org
    :init
    :config
    (setq org-ref-bibliography-notes (concat org-directory "/papers.org")
          org-ref-default-bibliography '("~/Resources/Papers/Library.bib")
          org-ref-pdf-directory "~/Resources/Papers/")

    (setq org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f"))

    (setq bibtex-completion-bibliography "~/Resources/Papers/Library.bib"
          bibtex-completion-library-path "~/Resources/Papers/"
          bibtex-completion-notes-path (concat org-directory "/papers.org"))

    (push '("IEEE Transactions on Visualization and Computer Graphics" "T-VCG") org-ref-bibtex-journal-abbreviations)
    (setq bibtex-dialect 'biblatex
          org-latex-pdf-process '("latexmk -shell-escape -bibtex -pdf %f"))

    (key-chord-define-global "kk" 'org-ref-cite-hydra/body)


    ;; open pdf with system pdf viewer (works on mac)
    (setq bibtex-completion-pdf-open-function
      (lambda (fpath)
        (start-process "open" "*open*" "open" fpath)))
  )

(use-package! org-brain
    :after org
    :init
    (setq org-brain-path (concat org-directory "/brain"))
    ;; For Evil users
    (with-eval-after-load 'evil
      (evil-set-initial-state 'org-brain-visualize-mode 'emacs))
    :config
    (setq org-id-track-globally t)
    (setq org-id-locations-file (concat org-directory "/.org-id-locations"))
    (push '("b" "Brain" plain (function org-brain-goto-end)
            "* %i%?" :empty-lines 1)
          org-capture-templates)
    (setq org-brain-visualize-default-choices 'all)
    (setq org-brain-title-max-length 12)
    (setq org-brain-include-file-entries nil
          org-brain-file-entries-use-title nil)
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
  ;; (push '("f1fa8c" "ffb86c" "#50fa7b" "ff5555" "#8be9fd" "bd93f9" "ff79c6") pdf-annot-color-history)
    ;; https://github.com/politza/pdf-tools/issues/35
  ;; (push '(color . "#000000") pdf-annot-default-markup-annotation-properties)
  )

(use-package! org-pdftools
  :config (setq org-pdftools-root-dir "~/Resources/Papers"))

(after! org
  (add-to-list 'org-capture-templates '("l" "Blog" plain (file (oguz/timestamped-file))
          "hello")))

(require 'ox-publish)
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
