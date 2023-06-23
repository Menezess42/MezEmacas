;; Configure 'elpy' package for Python development
(use-package elpy
  :ensure t
  :init
  (elpy-enable)
  :config
  (setq python-shell-interpreter "python")
  (setq elpy-rpc-python-command "python")
  (add-hook 'python-mode-hook 'pyvenv-mode))

;; Use 'pyvenv' for virtualenv management
(use-package pyvenv
  :ensure t
  :hook (python-mode . pyvenv-mode))

;; Use 'black' for code formatting
(use-package blacken
  :ensure t
  :hook (python-mode . blacken-mode))

;; Enable 'flycheck' for syntax checking
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; Enable 'company' for autocompletion
(use-package company
  :ensure t
  :init (global-company-mode))


;; Bind 'M-.' to 'jedi:goto-definition' for jumping to function definitions
(use-package python
  :ensure t
  :config
  (add-hook 'python-mode-hook
            (lambda ()
              (local-set-key (kbd "M-.") 'jedi:goto-definition))))

;; Enable 'jedi' for autocompletion and code navigation
(use-package jedi
  :ensure t
  :init
  (setq jedi:use-shortcuts t)
  (add-hook 'python-mode-hook 'jedi:setup))

;; ;; Us e IPython if available
(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython")
  (setq python-shell-interpreter-args "-i --simple-prompt"))

;; Use black for code formatting
(setq python-black-command "C:/Users/ariel/AppData/Local/Programs/Python/Python310/Scripts/black.exe")

;; Define a function to set the Python library path
(defun set-python-library-path ()
  "Set the path to the Python libraries for `company-mode`."
  (interactive)
  (setq python-library-path (read-directory-name "Python library path: "))
  (setq python-shell-extra-pythonpaths `(,python-library-path))
  (message "Python library path set to %s" python-library-path))

;; Set the initial Python library path
(setq python-library-path "C:/Users/ariel/AppData/Local/Programs/Python/Python310/Lib/")

;; Set the `python-shell-extra-pythonpaths` variable
(setq python-shell-extra-pythonpaths `(,python-library-path))

;; Add the `company-jedi` backend
(add-to-list 'company-backends 'company-jedi)

;; Add a key binding for `set-python-library-path`
(global-set-key (kbd "C-c p p") 'set-python-library-path)
;; Automatically kill the Python process after running code
(add-hook 'inferior-python-mode-hook
          (lambda ()
            (setq process-query-on-exit-flag nil)))
;; Disable native completion to avoid freezing issues
(setq python-shell-completion-native-enable nil)
(add-hook 'python-mode-hook
          (lambda ()
            (define-key python-mode-map (kbd "C-M-k") 'kill-python-shell)))
(defun kill-python-shell ()
  "Kill the current Python shell process and buffer."
  (interactive)
  (when (get-buffer-process "*Python*")
    (kill-process (get-buffer-process "*Python*")))
  (kill-buffer "*Python*"))

;; Enable `pdb` for debugging
(setq elpy-shell-use-project-root nil)
(add-hook 'elpy-mode-hook (lambda () (highlight-indentation-mode -1)))
(add-hook 'python-mode-hook (lambda ()
                              (setq-local highlight-indentation-mode -1)
                              (elpy-enable)
                              (elpy-mode)
                              (when (require 'dap-python nil t)
                                (require 'dap-ui nil t)
                                (dap-ui-mode t)
                                (dap-mode t))))
;; Define a function to start a `dap-mode` debugging session
(defun my/python-debug()
  (interactive)
  (require 'dap-python)
  (let* ((session-name "my-python-debug")
         (buffer "*dap-python*")
         (port 5678))
    (dap-python-debug
     (list :name session-name
           :type "python"
           :request "launch"
           :program (or (buffer-file-name) "")
           :cwd (projectile-project-root)
           :console "integratedTerminal"
           :env '(("PYTHONPATH" . "C:/Users/ariel/AppData/Local/Programs/Python/Python310/Lib/site-packages"))
           :debugOptions (list "RedirectOutput" "ShowReturnValue"))
     nil)))
(global-set-key (kbd "C-c d d") 'my/python-debug)
