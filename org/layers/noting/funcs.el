(defun capture-file-name ()
  (setq name (read-string "File name: "))
  (expand-file-name (concat name ".org") "~/org"))

(defun org-file-path (name)
  (expand-file-name name "~/org"))
