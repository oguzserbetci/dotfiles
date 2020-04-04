;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

(package! jupyter)
(package! emacs-zmq)
(package! org-roam :recipe (:host github :repo "jethrokuan/org-roam" :branch "master"))
(package! org-super-agenda)
(package! poetry)

(package! ivy-bibtex)
(package! org-ref)
(package! org-noter)
(package! org-pdftools :recipe (:host github :repo "fuxialexander/org-pdftools"))

;;; Examples:
;; (package! builtin-package :disable t)
