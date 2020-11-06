;; -*- no-byte-compile: t; -*-
;;; ~/.dotfiles/config/doom/packages.el

(package! org-ref)

(package! org-roam-bibtex
  :recipe (:host github :repo "org-roam/org-roam-bibtex"))

;; When using org-roam via the `+roam` flag
(unpin! org-roam company-org-roam)

;; When using bibtex-completion via the `biblio` module
(unpin! bibtex-completion helm-bibtex ivy-bibtex)

(package! org-fragtog)

;; (package! org-analyzer)

;; (unpin! org-roam-bibtex)

;; When using org-roam via the `+roam` flag
;; (unpin! org-roam company-org-roam org-roam-bibtex org-ref)

;; When using bibtex-completion via the `biblio` module
;; (unpin! bibtex-completion helm-bibtex ivy-bibtex)
