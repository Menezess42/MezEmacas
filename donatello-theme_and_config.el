;; Set the color theme for the Teenage Mutant Ninja Turtles
(custom-set-faces
  `(default ((t (:foreground "#00A89C" :background "#182b22"))))
  `(font-lock-comment-face ((t (:foreground "#C7E2D3"))))
  `(font-lock-keyword-face ((t (:foreground "#FFD300"))))
  `(font-lock-string-face ((t (:foreground "#FFA500"))))
  `(font-lock-variable-name-face ((t (:foreground "#FFE4B5"))))
  `(font-lock-function-name-face ((t (:foreground "#B94D8B"))))
  `(font-lock-builtin-face ((t (:foreground "#FF6D00"))))
  `(font-lock-constant-face ((t (:foreground "#FF9AA2"))))
  `(font-lock-type-face ((t (:foreground "#00BFFF"))))
  `(flycheck-warning ((t (:underline (:style wave :color "#FFD300")))))
  `(flycheck-error ((t (:underline (:style wave :color "#FF4500")))))
  `(region ((t (:background "#3d3d3d" :foreground "#FFFFFF"))))
  `(cursor ((t (:background "#FFFFFF"))))
  `(line-number ((t (:foreground "#FFA500"))))
  `(line-number-current-line ((t (:foreground "#00FF7F" :background "#2E2E2E"))))
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

