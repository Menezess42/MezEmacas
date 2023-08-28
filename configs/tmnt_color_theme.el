;; Set the color theme for the Teenage Mutant Ninja Turtles
(custom-set-faces
 '(default ((t (:background "#2d3339" :foreground "#9966cc"))))
 '(font-lock-comment-face ((t (:foreground "#b9b9b9"))))
 '(font-lock-comment-delimiter-face ((t (:foreground "#b9b9b9"))))
 '(font-lock-string-face ((t (:foreground "#e6a75e"))))
 '(font-lock-function-name-face ((t (:foreground "#82b47d"))))
 '(font-lock-variable-name-face ((t (:foreground "#6fb4d6"))))
 '(font-lock-keyword-face ((t (:foreground "#b94d8b"))))
 '(font-lock-type-face ((t (:foreground "#c3c080"))))
 '(font-lock-constant-face ((t (:foreground "#e58d62"))))
 '(font-lock-builtin-face ((t (:foreground "#e58d62"))))
 `(flycheck-warning ((t (:underline (:style wave :color "#FFD300")))))
 `(flycheck-error ((t (:underline (:style wave :color "#FF4500")))))
 ;; `(region ((t (:background "#3d3d3d" :foreground "#FFFFFF"))))
 ;; `(cursor ((t (:background "#FFFFFF"))))
 `(line-number ((t (:foreground "#FFA500"))))
 `(line-number-current-line ((t (:foreground "#00FF7F"
                                             :background "#1d1f21"))))
 )

;; make cursor blink
(defvar blink-cursor-colors (list  "#92c48f" "#6785c5" "#be369c" "#d9ca65")
  "On each blink the cursor will cycle to the next color in this list.")

(setq blink-cursor-count 0)
(defun blink-cursor-timer-function ()
  "Zarza wrote this cyberpunk variant of timer `blink-cursor-timer'. 
    Warning: overwrites original version in `frame.el'.

    This one changes the cursor color on each blink. Define colors in `blink-cursor-colors'."
  (when (not (internal-show-cursor-p))
    (when (>= blink-cursor-count (length blink-cursor-colors))
      (setq blink-cursor-count 0))
    (set-cursor-color (nth blink-cursor-count blink-cursor-colors))
    (setq blink-cursor-count (+ 1 blink-cursor-count))
    )
  (internal-show-cursor nil (not (internal-show-cursor-p)))
  )
;; (global-hl-line-mode)
;; (set-face-background 'hl-line "#301934")
(global-hl-line-mode)
(set-face-background 'hl-line "#301934")
(set-face-attribute 'hl-line nil :box '(:line-width 3 :color "purple"))
;; Set background color for active modeline
(set-face-background 'mode-line "#301934")
;; Set box attribute for active modeline
(set-face-attribute 'mode-line nil :box '(:line-width 3 :color "purple"))
;; Set background color for inactive modeline
(set-face-background 'mode-line-inactive "#301934")
;; Set box attribute for inactive modeline
(set-face-attribute 'mode-line-inactive nil :box '(:line-width 3 :color "purple"))

;;; add purple border to the window
(set-face-attribute 'vertical-border nil :foreground "purple")
(set-face-attribute 'window-divider nil :foreground "purple" :background "purple")
(set-face-attribute 'window-divider-first-pixel nil :foreground "purple" :background "purple")
(set-face-attribute 'window-divider-last-pixel nil :foreground "purple" :background "purple")
