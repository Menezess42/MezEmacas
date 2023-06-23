    ;; Define functions to increase/decrease transparency by 5
    (defun transparency-increase ()
      (interactive)
      (let* ((alpha-list '((100 100) (85 65) (70 50) (55 35) (40 20) (25 10) (10 5) (0 0)))
             (current-alpha (or (cdr (assoc 'alpha (frame-parameters))) (cons 100 100)))
             (closest (car alpha-list)))
        (dolist (a alpha-list)
          (when (> (abs (- (car a) (car current-alpha))) (abs (- (car closest) (car current-alpha)))))
          (setq closest a))
        (set-frame-parameter (selected-frame) 'alpha closest)))

    (defun transparency-decrease ()
      (interactive)
      (let* ((alpha-list '((100 100) (85 65) (70 50) (55 35) (40 20) (25 10) (10 5) (0 0)))
             (current-alpha (or (cdr (assoc 'alpha (frame-parameters))) (cons 100 100)))
             (closest (car alpha-list)))
        (dolist (a (reverse alpha-list))
          (when (> (abs (- (car a) (car current-alpha))) (abs (- (car closest) (car current-alpha)))))
          (setq closest a))
        (set-frame-parameter (selected-frame) 'alpha closest)))

    ;; Define function to set transparency to a specific value
    (defun transparency-set (value)
      (interactive "nTransparency Value (0-100): ")
      (set-frame-parameter (selected-frame) 'alpha (cons value value)))

  

    ;; Set keybindings for transparency functions
    (global-set-key (kbd "C-c t +") 'transparency-increase)
    (global-set-key (kbd "C-c t -") 'transparency-decrease)
(global-set-key (kbd "C-c t =") 'transparency-set)
