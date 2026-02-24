((yaml-mode . ((flycheck-checker . yaml-yamllint)
               (lsp-yaml-custom-tags . ["!secret" "!include" "!lambda" "!extend"])
               (eval . (with-eval-after-load 'flycheck
                         (setf (flycheck-checker-get 'yaml-yamllint 'working-directory)
                               (lambda (_checker)
                                 (and buffer-file-name
                                      (locate-dominating-file buffer-file-name ".yamllint")))))))))
