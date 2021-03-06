;; EMACS Config
;; Ben Shaw

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (dracula)))
 '(custom-safe-themes
   (quote
    ("b97a01622103266c1a26a032567e02d920b2c697ff69d40b7d9956821ab666cc" "ff7625ad8aa2615eae96d6b4469fcc7d3d20b2e1ebc63b761a349bebbb9d23cb" "d9129a8d924c4254607b5ded46350d68cc00b6e38c39fc137c3cfb7506702c12" "3ff840641a718fbd6efa0cb48cb22bab610e935aca128783ce33014ebffc6e7b" "46f1275ae8a7e73bb63fb13db781980092289d032b4d32ca3819c961e0c0fa4c" "52a693830a0125b1188addabaadcdb04af67121fd15d395b967e404598941dc3" "3169fccee5b97e9f62459cf8aa628f3a423ebec4dabd361fc4b276d3fdd7ede6" "b887c858a4ced1799ab682f6f3ecaed264759b39e3a017d5795430b2213e11e9" "eb0a314ac9f75a2bf6ed53563b5d28b563eeba938f8433f6d1db781a47da1366" "f7f1658c29c47b10946cd7f9948a8620ad83de90fdb27d71345b5e3416050aac" "e58c0aa9864b9def98b830202fc0e338c175ca6a385b90bcd2fc97a7ba3829ac" "d9068fd376a4e49c4bf820b2afce047b7fbd3ffea6d65f6d169c55cdc7510a24" "3dddc5908694a79b0b57a01f055bb716af900fc87fea02c32666b8f440724c34" "3be096aeee1f2371814f43b58825d4d21307cc20b449d90ba7637c502662c80f" "fa7da9b007614cf0d02b58a4bc59687e03e69a0a8ea32c4fb7be775581abaf97" "715fdcd387af7e963abca6765bd7c2b37e76154e65401cd8d86104f22dd88404" default)))
 '(custom-theme-load-path
   (quote
    ("/home/ben/.emacs.d/elpa/hamburg-theme-20160122.2340/" "/home/ben/.emacs.d/elpa/solarized-theme-20160901.334/" custom-theme-directory t "/home/ben/.emacs.d/elpa/dracula-theme-20161119.1345/")) t)
 '(package-selected-packages
   (quote
    (web-mode flymd markdown-mode pdf-tools helm-flyspell magit auctex-latexmk auctex helm-swoop dracula-theme))))

;;;;;;;;;;;;;;;;;;;;;;
;;;; Key Bindings ;;;;
;;;;;;;;;;;;;;;;;;;;;;

;; ANSI-Term
(global-set-key (kbd "C-c t") '(lambda () (interactive) (ansi-term "/usr/bin/zsh")));

;; Magit
(global-set-key (kbd "C-c g") 'magit-status);

;; Helm
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-s") 'helm-swoop)
(global-set-key (kbd "C-c s s") 'helm-spotify-plus)
(global-set-key (kbd "C-c s f") 'helm-spotify-plus-next)
(global-set-key (kbd "C-c s b") 'helm-spotify-plus-previous)
(global-set-key (kbd "C-c s p") 'helm-spotify-plus-play)
(global-set-key (kbd "C-c s g") 'helm-spotify-plus-pause) 

;; Possible Helm/Tramp SSH Bug Fix
(setq tramp-use-ssh-controlmaster-options nil)

;; rag/kill-a-buffer
(global-set-key (kbd "C-x k") 'rag/kill-a-buffer)

;;;;;;;;;;;;;;;;;;;;;;
;; End Key Bindings ;;
;;;;;;;;;;;;;;;;;;;;;;


;; Package repos

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

;; Disable tool, menu, and scroll bars
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;; Buffer Kill
(defun rag/kill-a-buffer (askp)
  "with no prefix, kill the current buffer without prompt
 with prefix, select which buffer to kill"
  (interactive "P")
  (if askp
      (kill-buffer (funcall completing-read-function
			    "Kill buffer: "
			    (mapcar #'buffer-name (buffer-list))))
    (kill-this-buffer)))

;; Default Font
(add-to-list 'default-frame-alist '(font . "Liberation Mono" ))

;; Helm
(add-to-list 'load-path "/home/ben/.emacs.d/async")
(add-to-list 'load-path "/home/ben/.emacs.d/helm")

(require 'helm-config)

;; Web-mode hooks
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))

;; PDF Tools call and hook
(pdf-tools-install)
(add-to-list 'auto-mode-alist '("\\.pdf\\'" . pdf-view-mode))

;; Jedi (Python auto-complete)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)


;; Disable linum in certain major modes
(define-global-minor-mode my-global-linum-mode linum-mode
  (lambda ()
    (when (not (memq major-mode
		     (list 'shell-mode
			   'doc-view-mode
			   'term-mode
			   'text-mode
			   'help-mode
			   'minibuffer-prompt
			   'pdf-view-mode
			   )))
      (linum-mode))))

;; SQL Indentation
(eval-after-load "sql"
  '(load-library "~/.emacs.d/minor_modes/sql_indent/sql-indent.el"))

;; Theme
(if (display-graphic-p) (load-theme 'dracula))

;; Linum adjustments
(my-global-linum-mode 1)
;;(set-face-attribute 'fringe nil :background "#3a3d4f")
(setq-default left-fringe-width 12)
(setq-default right-fringe-width 10)
(setq linum-format "   %4d")

;; Flyspell Hooks
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'markdown-mode-hook 'flyspell-mode)
(add-hook 'org-mode-hook 'flyspell-mode)

;; Ansi-term fix
(setq explicit-shell-file-name "/usr/bin/zsh")


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-latex-bold-face ((t (:inherit bold :foreground "spring green"))))
 '(font-latex-italic-face ((t (:inherit italic :foreground "medium spring green"))))
 '(font-latex-sectioning-5-face ((t (:inherit variable-pitch :foreground "sky blue" :weight bold))))
 '(font-latex-warning-face ((t (:inherit bold :foreground "indian red")))))
