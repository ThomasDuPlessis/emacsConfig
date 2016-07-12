;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Org-mode;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(defun notes ()
  "Switch to my work dir."
   (interactive)
   (find-file
    (concat "~/Documents/" 
	    (read-from-minibuffer "Enter the dir:"))))

(defun newNote (className)
  (interactive "sEnter name of Class: ")
  (let* ((fileName
	  (concat (format-time-string "%Y-%m-%d")   ".org"))
	 (fileFullName
	  (concat "~/Documents/" className "/" fileName)))
    (find-file fileFullName)))

(setq org-src-fontify-natively t)
(add-hook 'org-mode-hook
	  (lambda ()
	    (org-set-local 'yas/trigger-key [tab])
            (define-key yas/keymap [tab] 'yas/next-field-or-maybe-expand)
	    (make-variable-buffer-local 'yas/trigger-key)
            (setq yas/trigger-key [tab])
            (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
            (define-key yas/keymap [tab] 'yas/next-field)
	    (org-indent-mode)
	    (linum-on)))

(global-set-key "\C-ca" 'org-agenda)

;; TODO entry automatricall change to DONE when all children are done
(defun org-summary-todo (n-done n-not-done)
       "Switch entry to DONE when all subentries are done, to TODO otherwise."
       (let (org-log-done org-log-states)   ; turn off logging
         (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)


;; display links to images
(setq org-startup-with-inline-images t)

;; ;open up my agenda on opening of emacs 
;; (org-agenda-list)			   
;;(find-file org-default-notes-file)

(add-to-list 'org-agenda-files "~/org")

(setq org-agenda-window-setup 'current-window)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;