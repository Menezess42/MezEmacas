(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-center-content t
        dashboard-set-heading-icons t
        dashboard-set-file-icons t
        dashboard-banner-logo-title "WE’RE LEAN, WE’RE GREEN, AND WE’RE MEAN!"
        dashboard-items '((recents . 5))
        dashboard-startup-banner "~/.emacs.d/assets/mezemacs_logo.png"
        dashboard-image-banner-max-height 350)
  :init
  (add-hook 'dashboard-after-initialize-hook
            (lambda ()
              (dashboard-insert-startupify-lists))))
