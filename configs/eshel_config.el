
    (defun efs/configure-eshell ()
      ;; Save command history when commands are entered
      (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

      ;; Truncate buffer for performance
      (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

      ;; Bind some useful keys for evil-mode
      (evil-define-key '(normal insert visual) eshell-mode-map (kbd "C-r") 'counsel-esh-history)
      (evil-define-key '(normal insert visual) eshell-mode-map (kbd "<home>") 'eshell-bol)
      (evil-normalize-keymaps)

      (setq eshell-history-size         10000
            eshell-buffer-maximum-lines 10000
            eshell-hist-ignoredups t
            eshell-scroll-to-bottom-on-input t))

    (use-package eshell-git-prompt)

    (use-package eshell
      :hook (eshell-first-time-mode . efs/configure-eshell)
      :config

      (with-eval-after-load 'esh-opt
        (setq eshell-destroy-buffer-when-process-dies t)
        (setq eshell-visual-commands '("htop" "zsh" "vim")))

      (eshell-git-prompt-use-theme 'powerline))
  
  (setq eshell-ls-use-ls-dired t)
  (add-hook 'eshell-mode-hook
    (lambda ()
      (eshell-ls-register-ext-dir ".")
      (define-key eshell-mode-map (kbd "C-l") 'eshell-clear-buffer)
      (define-key eshell-mode-map (kbd "C-d") 'eshell-send-input)))
