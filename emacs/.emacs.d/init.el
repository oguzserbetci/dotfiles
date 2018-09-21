(package-initialize)

;; I use =cask= and =pallet= for managing packages. These need to be included in
;; here to ensure that the correct version of =org= is used to render my
;; =configuration.org= file.

(org-babel-load-file "~/.emacs.d/configuration.org")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ido-case-fold nil)
 '(package-selected-packages
   (quote
    (doom-modeline solaire-mode nlinum doom-themes doom auto-compile evil-magit leuven-theme synosaurus use-package smex projectile powerline org-fancy-priorities org-evil org-bullets org-ac markdown-mode magit instapaper ido-vertical-mode flycheck-color-mode-line flx-ido evil-surround evil-org evil-leader evil-indent-textobject evil-escape eterm-256color engine-mode elpy dracula-theme dired-open dired-details diff-hl company-jedi auctex-lua))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
