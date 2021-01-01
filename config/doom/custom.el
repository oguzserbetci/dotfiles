(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(conda-anaconda-home "/usr/local/Caskroom/miniconda/base/")
 '(conda-env-autoactivate-mode t t)
 '(safe-local-variable-values
   '((ispell-personal-dictionary concat doom-modeline--project-root "personal-dict.pws")
     (ispell-personal-dictionary . "personal-dict.pws")
     (eval let
           ((emb-path "embeddings/sentences.mimic3.hourly.random.binned.100d.Fasttext.15ws.10neg.vec")
            (vocab-path "embeddings/sentences.mimic3.hourly.random.binned.train.counts"))
           (dap-register-debug-template "Python :: Finetune FastText"
                                        (list :type "python" :args
                                              (concat "debug_train" " --dev" " -e 2" " --emb_path=" emb-path " --vocab_file=" vocab-path)
                                              :target-module "finetune.py" :request "launch" :name "Python :: Finetune FastText"))
           (dap-register-debug-template "Python :: Pretrain MSE"
                                        (list :type "python" :args
                                              (concat "debug_train" " --dev" " -e 2" " --emb_path=" emb-path " --vocab_file=" vocab-path " --tasks=pred" " --modelcls=models.PredictionModel")
                                              :target-module "finetune.py" :request "launch" :name "Python :: Finetune FastText")))
     (LaTeX-item-indent . 0)
     (org-export-preserve-breaks . t)
     (org-latex-caption-above)
     (TeX-engine quote xetex)
     (org-startup-latex-with-latex-preview . t))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
