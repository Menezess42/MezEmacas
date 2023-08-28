(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (f)
                ;; set fonts
                (set-face-attribute 'default nil :font "FiraCode Nerd Font" :height 140)
                ;; Set the fixed pitch face
                (set-face-attribute 'fixed-pitch nil :font "FiraCode Nerd Font" :height 140)
                ;; Set the variable pitch face
                (set-face-attribute 'variable-pitch nil :font "FiraCode Nerd Font" :height 140 :weight 'regular)))
  ;; Set fonts for non-daemon Emacs
  (set-face-attribute 'default nil :font "FiraCode Nerd Font" :height 140)
  (set-face-attribute 'fixed-pitch nil :font "FiraCode Nerd Font" :height 140)
  (set-face-attribute 'variable-pitch nil :font "FiraCode Nerd Font" :height 140 :weight 'regular))
