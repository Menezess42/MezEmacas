(setq inhibit-startup-message t)
(setq visual-line-mode t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)
(setq visible-bell 1)
;; Enable relative line numbers
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)


;; open my color-config and ocult some stufs
(load-file "~/.emacs.d/configs/tmnt_theme_color.el")

;;define vars for font size
(defvar efs/default-font-size 150)
(defvar efs/default-variable-font-size 150)
(load-file "~/.emacs.d/configs/fonts.el")
;;open and closee
(electric-pair-mode t)
;;set ident tab
(setq-default indent-tabs-mode nil)

;;change yes or no to y or n
(defalias 'yes-or-no-p 'y-or-n-p)

;; set codign-system to utf-8
(prefer-coding-system 'utf-8)

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
(package-refresh-contents))

(require 'use-package)
(setq use-package-always-ensure t)

  (use-package general
    :config
    (general-create-definer rune/leader-keys
      :keymaps '(normal insert visual emacs)
      :prefix "SPC"
      :global-prefix "C-SPC")

    (rune/leader-keys
      "t"  '(:ignore t :which-key "toggles")
      ))
(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)) 

(use-package evil-collection
  :after evil
  :config
  (setq evil-want-intergration t)
  (evil-collection-init))

(add-hook 'window-setup-hook 'toggle-frame-maximized t)

;; Development-->company-mode
(use-package company
  :ensure t
  :init (global-company-mode)
  :config
  (setq company-selection-wrap-around t) ;;circular selection
  (define-key company-active-map (kbd "TAB")
              'company-select-next)
  (define-key company-active-map (kbd "<tab>")
              'company-select-next)
  )

(defun my-company-tab-or-complete ()
  (interactive)
  (if (eq last-command 'company-complete-selection)
      (company-complete-selection)
    (if (eq company-common (car company-candidates))
        (company-complete-selection)
      (company-select-next))))
  
(defun my-company-backtab-or-complete ()
  (interactive)
  (if (eq last-command 'company-complete-selection)
      (company-complete-selection)
    (if (eq company-common (car (last company-candidates)))
        (company-complete-selection)
      (company-select-previous))))

(define-key company-active-map (kbd "TAB") 'my-company-tab-or-complete)
(define-key company-active-map (kbd "<tab>") 'my-company-tab-or-complete)
(define-key company-active-map (kbd "S-TAB") 'my-company-backtab-or-complete)
(define-key company-active-map (kbd "<backtab>") 'my-company-backtab-or-complete)
;; Minimize garbage collection during startup
(setq gc-cons-threshold most-positive-fixnum)
;; Lower threshold back to 8 MiB (default is 800kB)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (expt 2 23))))

(load "~/.emacs.d/configs/dashBoard_config.el")

(defun kill-current-buffer ()
  "Kill the current buffer."
  (interactive)
  (kill-buffer (buffer-name)))
(global-set-key [remap evil-quit] 'kill-current-buffer)
(defun kill-current-buffer ()
  "Kill the current buffer."
  (interactive)
  (kill-buffer (buffer-name)))

(defun my-quit-emacs ()
  "Quit Emacs, or close current frame if there are multiple frames."
  (interactive)
  (if (eq window-system 'x)
      (if (cdr (frame-list))
          (delete-frame)
        (message "Can't quit Emacs with only one graphical frame"))
    (kill-emacs)))

(global-set-key [remap evil-quit] 'kill-current-buffer)
(global-set-key [remap evil-save-and-quit] 'my-quit-emacs)
(global-set-key [remap evil-quit] 'kill-current-buffer)

(use-package which-key
  :commands (which-key-mode)
  :hook ((after-init . which-key-mode)
	 (pre-command . which-key-mode))
  :config
  (setq which-key-idle-delay 1)
  :diminish which-key-mode)

;;ivy rich
    (use-package ivy
      :diminish
      :bind (;("C-s" . swiper)
             :map ivy-minibuffer-map
             ("TAB" . ivy-alt-done)
             ("C-l" . ivy-alt-done)
             ("C-j" . ivy-next-line)
             ("C-k" . ivy-previous-line)
             :map ivy-switch-buffer-map
             ("C-k" . ivy-previous-line)
             ("C-l" . ivy-done)
             ("C-d" . ivy-switch-buffer-kill)
             :map ivy-reverse-i-search-map
             ("C-k" . ivy-previous-line)
             ("C-d" . ivy-reverse-i-search-kill))
      :config
      (ivy-mode 1))

    (use-package ivy-rich
      :init
      (ivy-rich-mode 1))

(use-package counsel
  :bind (("C-x C-b" . 'counsel-switch-buffer)  ; Nova associação de teclas
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :config
  (counsel-mode 1))

;; Improved candidate sorting with presciente.el
(use-package ivy-prescient
  :after counsel
  :custom
  (ivy-prescient--enable-filtering nil)
  :config
  (ivy-prescient-mode 1))

;; helpful help commands
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-funciton #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;;;;;;;;;;Eshelll;;;;;;;;;;
(defun my-eshell-config ()
  (setq eshell_config "~/.emacs.d/configs/eshel_config.el")
  (load eshell_config))

(add-hook 'eshell-mode-hook #'my-eshell-config)


;;Keep folders clean
(use-package no-littering)
  (setq auto-save-file-name-transforms
        `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

;;; dired config

  (use-package dired
    :ensure nil
    :commands (dired dired-jump)
    :bind (("C-x C-j" . dired-jump))
    :custom ((dired-listing-switches "-agho --group-directories-first"))
    :config
    (evil-collection-define-key 'normal 'dired-mode-map
      "h" 'dired-single-up-directory
      "l" 'dired-single-buffer))

  (use-package dired-single)

  (use-package all-the-icons-dired
    :hook (dired-mode . all-the-icons-dired-mode))

  (use-package dired-open
    :config
    ;; Doesn't work as expected!
    ;;(add-to-list 'dired-open-functions #'dired-open-xdg t)
    (setq dired-open-extensions '(("png" . "feh")
                                  ("mkv" . "mpv"))))

  (use-package dired-hide-dotfiles
    :hook (dired-mode . dired-hide-dotfiles-mode)
    :config
    (evil-collection-define-key 'normal 'dired-mode-map
      "H" 'dired-hide-dotfiles-mode))

;;;;;;;;Center;;;;;
(use-package centered-window
  :ensure t
  :config
  (centered-window-mode t))

(use-package centered-cursor-mode
  :demand
  :config
  ;; Optional, enables centered-cursor-mode in all buffers.
  (global-centered-cursor-mode))

;;;;;;;;;;;;;rainbow mode
(use-package rainbow-mode
  :hook ((prog-mode . rainbow-mode)
         (after-init . rainbow-mode))
  :config
  (setq rainbow-x-colors nil ; disable color names
        rainbow-identifiers-choose-face-function 'rainbow-identifiers-cie-l*a*b*-choose-face
        rainbow-identifiers-cie-l*a*b*-lightness 45 ; set lightness
        rainbow-identifiers-cie-l*a*b*-saturation 70 ; set saturation
        rainbow-identifiers-rgb-faces t)) ; use RGB colors



;;;;;;;rainbow delimiters
    (use-package rainbow-delimiters
      :hook ((prog-mode . rainbow-delimiters-mode)
             (org-mode . rainbow-delimiters-mode))
      :custom-face
  (rainbow-delimiters-depth-1-face ((t (:foreground "#ff2600"))))
  (rainbow-delimiters-depth-2-face ((t (:foreground "#f0a000"))))
  (rainbow-delimiters-depth-3-face ((t (:foreground "#ffdf00"))))
  (rainbow-delimiters-depth-4-face ((t (:foreground "#40ff00"))))
  (rainbow-delimiters-depth-5-face ((t (:foreground "#00f0a0"))))
  (rainbow-delimiters-depth-6-face ((t (:foreground "#0080ff"))))
  (rainbow-delimiters-depth-7-face ((t (:foreground "#bf00ff"))))
  (rainbow-delimiters-depth-8-face ((t (:foreground "#ff00bf"))))
  (rainbow-delimiters-depth-9-face ((t (:foreground "#ff0080")))))

;; set transparency
(setq transparency-file "~/.emacs.d/configs/transparency_config.el")
(load transparency-file)

;;;;;;;;org mode
(defun my-org-config ()
  (setq orgConfig-file "~/.emacs.d/configs/org_config.el")
  (load orgConfig-file))
(add-hook 'org-mode-hook #'my-org-config)

;; Doom modeline
(use-package all-the-icons)
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package treemacs
  :ensure t
  :config
  (with-eval-after-load 'treemacs
    (treemacs-project-follow-mode t))
  (setq tree-macs-show-icons t) ; Enable icons in the tree view
  (setq tree-macs-width 30) ; Set the width of the tree view
  
  ;; Customize keybindings (optional)
  (global-set-key (kbd "C-c t") 'tree-macs-toggle)

  ;; Define custom file filter
  (setq tree-macs-file-filters
        '(;; Exclude some file types
          (not (name . "\\.git"))
          (not (name . "\\.DS_Store"))
          (not (name . "\\.pyc")))))


(defun my-python-config ()
  (setq pythonConfig-file "~/.emacs.d/configs/python_config.el")
  (load pythonConfig-file))
(add-hook 'python-mode-hook #'my-python-config)

(require 'ivy-posframe)
;; display at `ivy-posframe-style'
(setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display)))
(set-face-attribute 'ivy-posframe nil :foreground "white" :background "#301934")
(setq ivy-posframe-hide-minibuffer t)
(ivy-posframe-mode 1)


(setq custom-config "~/.emacs.d/configs/custom.el")
(load custom-config)

(defun my-disable-line-numbers ()
  "Disable line numbers."
  (display-line-numbers-mode 0))

(add-hook 'org-mode-hook 'my-disable-line-numbers)
(add-hook 'term-mode-hook 'my-disable-line-numbers)

;; Avaliar o conteúdo do init.el quando a janela do Emacs for aberta
(defvar my-init-el-start-time (current-time) "Time when init.el was started")
(defun display-startup-echo-area-message ()
  (message  " ★ Emacs initialized in %.2fs ★ " (float-time (time-subtract (current-time) my-init-el-start-time))))

(use-package company-quickhelp
  :ensure t
  :after company
  :config
  (company-quickhelp-mode 1))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(connection-local-criteria-alist
   '(((:application eshell)
      eshell-connection-default-profile)
     ((:application tramp)
      tramp-connection-local-default-system-profile tramp-connection-local-default-shell-profile)))
 '(connection-local-profile-alist
   '((eshell-connection-default-profile
      (eshell-path-env-list))
     (tramp-connection-local-darwin-ps-profile
      (tramp-process-attributes-ps-args "-acxww" "-o" "pid,uid,user,gid,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" "-o" "state=abcde" "-o" "ppid,pgid,sess,tty,tpgid,minflt,majflt,time,pri,nice,vsz,rss,etime,pcpu,pmem,args")
      (tramp-process-attributes-ps-format
       (pid . number)
       (euid . number)
       (user . string)
       (egid . number)
       (comm . 52)
       (state . 5)
       (ppid . number)
       (pgrp . number)
       (sess . number)
       (ttname . string)
       (tpgid . number)
       (minflt . number)
       (majflt . number)
       (time . tramp-ps-time)
       (pri . number)
       (nice . number)
       (vsize . number)
       (rss . number)
       (etime . tramp-ps-time)
       (pcpu . number)
       (pmem . number)
       (args)))
     (tramp-connection-local-busybox-ps-profile
      (tramp-process-attributes-ps-args "-o" "pid,user,group,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" "-o" "stat=abcde" "-o" "ppid,pgid,tty,time,nice,etime,args")
      (tramp-process-attributes-ps-format
       (pid . number)
       (user . string)
       (group . string)
       (comm . 52)
       (state . 5)
       (ppid . number)
       (pgrp . number)
       (ttname . string)
       (time . tramp-ps-time)
       (nice . number)
       (etime . tramp-ps-time)
       (args)))
     (tramp-connection-local-bsd-ps-profile
      (tramp-process-attributes-ps-args "-acxww" "-o" "pid,euid,user,egid,egroup,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" "-o" "state,ppid,pgid,sid,tty,tpgid,minflt,majflt,time,pri,nice,vsz,rss,etimes,pcpu,pmem,args")
      (tramp-process-attributes-ps-format
       (pid . number)
       (euid . number)
       (user . string)
       (egid . number)
       (group . string)
       (comm . 52)
       (state . string)
       (ppid . number)
       (pgrp . number)
       (sess . number)
       (ttname . string)
       (tpgid . number)
       (minflt . number)
       (majflt . number)
       (time . tramp-ps-time)
       (pri . number)
       (nice . number)
       (vsize . number)
       (rss . number)
       (etime . number)
       (pcpu . number)
       (pmem . number)
       (args)))
     (tramp-connection-local-default-shell-profile
      (shell-file-name . "/bin/sh")
      (shell-command-switch . "-c"))
     (tramp-connection-local-default-system-profile
      (path-separator . ":")
      (null-device . "/dev/null"))))
 '(package-selected-packages
   '(golden-ratio company-quickhelp company-jedi key-chord py-autopep8 jupyter tree-macs treemacs lsp-treemacs jedi flycheck blacken elpy lsp-python-ms ivy-posframe posframe doom-modeline org-bullets rainbow-delimiters rainbow-mode centered-window dired-hide-dotfiles dired-open all-the-icons-dired dired-single eshell-git-prompt helpful ivy-prescient counsel ivy-rich ivy which-key dashboard projectile all-the-icons company evil-collection)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background "#1d1f21" :foreground "#9966cc"))))
 '(cursor ((t (:background "#FFFFFF"))))
 '(flycheck-error ((t (:underline (:style wave :color "#FF4500")))))
 '(flycheck-warning ((t (:underline (:style wave :color "#FFD300")))))
 '(font-lock-builtin-face ((t (:foreground "#e58d62"))))
 '(font-lock-comment-delimiter-face ((t (:foreground "#b9b9b9"))))
 '(font-lock-comment-face ((t (:foreground "#b9b9b9"))))
 '(font-lock-constant-face ((t (:foreground "#e58d62"))))
 '(font-lock-function-name-face ((t (:foreground "#82b47d"))))
 '(font-lock-keyword-face ((t (:foreground "#b94d8b"))))
 '(font-lock-string-face ((t (:foreground "#e6a75e"))))
 '(font-lock-type-face ((t (:foreground "#c3c080"))))
 '(font-lock-variable-name-face ((t (:foreground "#6fb4d6"))))
 '(line-number ((t (:foreground "#FFA500"))))
 '(line-number-current-line ((t (:foreground "#00FF7F" :background "#2E2E2E"))))
 '(region ((t (:background "#3d3d3d" :foreground "#FFFFFF")))))
