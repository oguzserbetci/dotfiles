(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(conda-anaconda-home "/usr/local/Caskroom/miniconda/base/")
 '(conda-env-autoactivate-mode t t)
 '(safe-local-variable-values
   '((org-startup-latex-with-latex-preview . t)
     (org-latex-caption-above)
     (TeX-engine quote xetex)
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
     (eval let
           ((emb-path "embeddings/sentences.mimic3.hourly.random.binned.100d.Fasttext.15ws.10neg.vec")
            (vocab-path "embeddings/sentences.mimic3.hourly.random.binned.train.counts")
            (suffix ".mimic3.train"))
           (dap-register-debug-template "Python :: Finetune FastText"
                                        (list :type "python" :args
                                              (concat "debug_train" " --dev" " -e 2" " --emb_path=" emb-path " --vocab_file=" vocab-path " --suffix=" suffix " --n_bins=9")
                                              :target-module "finetune.py" :request "launch" :name "Python :: Finetune FastText"))
           (dap-register-debug-template "Python :: Pretrain MSE"
                                        (list :type "python" :args
                                              (concat "debug_train" " --dev" " -e 2" " --emb_path=" emb-path " --vocab_file=" vocab-path " --suffix=" suffix " --n_bins=9" " --tasks=pred" " --modelcls=models.PredictionModel")
                                              :target-module "finetune.py" :request "launch" :name "Python :: Finetune FastText")))
     (eval let
           ((emb-path "embeddings/sentences.mimic3.hourly.random.binned.100d.Fasttext.15ws.10neg.vec")
            (vocab-path "embeddings/sentences.mimic3.hourly.random.binned.train.counts")
            (suffix ".mimic3"))
           (dap-register-debug-template "Python :: Finetune FastText"
                                        (list :type "python" :args
                                              (concat "debug_train" " --dev" " -e 2" " --emb_path=" emb-path " --vocab_file=" vocab-path " --suffix=" suffix " --n_bins=9")
                                              :target-module "finetune.py" :request "launch" :name "Python :: Finetune FastText"))
           (dap-register-debug-template "Python :: Pretrain MSE"
                                        (list :type "python" :args
                                              (concat "debug_train" " --dev" " -e 2" " --emb_path=" emb-path " --vocab_file=" vocab-path " --suffix=" suffix " --n_bins=9" " --tasks=pred" " --modelcls=models.PredictionModel")
                                              :target-module "finetune.py" :request "launch" :name "Python :: Finetune FastText")))
     (let
         ((emb-path "embeddings/sentences.mimic3.hourly.random.binned.100d.Fasttext.15ws.10neg.vec")
          (vocab-path "embeddings/sentences.mimic3.hourly.random.binned.train.counts")
          (suffix ".mimic3"))
       (eval dap-register-debug-template "Python :: Finetune FastText"
             (list :type "python" :args
                   (concat "debug_train" " --dev" " -e 2" " --emb_path=" emb-path " --vocab_file=" vocab-path " --suffix=" suffix " --n_bins=9")
                   :target-module "finetune.py" :request "launch" :name "Python :: Finetune FastText"))
       (eval dap-register-debug-template "Python :: Pretrain MSE"
             (list :type "python" :args
                   (concat "debug_train" " --dev" " -e 2" " --emb_path=" emb-path " --vocab_file=" vocab-path " --suffix=" suffix " --n_bins=9" " --tasks=pred" " --modelcls=models.PredictionModel")
                   :target-module "finetune.py" :request "launch" :name "Python :: Finetune FastText")))
     (let
         ((emb-path "embeddings/sentences.mimic3.hourly.random.binned.100d.Fasttext.15ws.10neg.vec")
          (vocab-path "embeddings/sentences.mimic3.hourly.random.binned.train.counts")
          (suffix ".mimic3"))
       (dap-register-debug-template "Python :: Finetune FastText"
                                    (list :type "python" :args
                                          (concat "debug_train" " --dev" " -e 2" " --emb_path=" emb-path " --vocab_file=" vocab-path " --suffix=" suffix " --n_bins=9")
                                          :target-module "finetune.py" :request "launch" :name "Python :: Finetune FastText"))
       (dap-register-debug-template "Python :: Pretrain MSE"
                                    (list :type "python" :args
                                          (concat "debug_train" " --dev" " -e 2" " --emb_path=" emb-path " --vocab_file=" vocab-path " --suffix=" suffix " --n_bins=9" " --tasks=pred" " --modelcls=models.PredictionModel")
                                          :target-module "finetune.py" :request "launch" :name "Python :: Finetune FastText"))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
