
;;; My .emacs file

;; by Phil Hagelberg
;; Much thanks to emacswiki.org and RMS.

;; Note: this relies on files found in my .emacs.d:
;; http://dev.technomancy.us/phil/browser/dotfiles/.emacs.d

(setq user-full-name "Phil Hagelberg")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq load-path (append '("~/.emacs.d") load-path))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;     loading modes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'psvn)
(require 'color-theme)
(require 'zenburn)
(require 'tabbar)
(require 'htmlize)

;; PHP mode
(autoload 'php-mode "php-mode")
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
; luckily I don't find much use for this anymore. =D

;; .js (javascript) loads C mode (until I find something better)
(add-to-list 'auto-mode-alist '("\\.js$" . c-mode))

;; CSS-mode
(autoload 'css-mode "css-mode")
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))

;; YAML-mode
(autoload 'yaml-mode "yaml-mode")
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ruby help
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; syntax highlighting needs to be done before ruby-electric
(global-font-lock-mode t)

(require 'ruby-electric)
(require 'inf-ruby)
(require 'ruby-mode)

(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode)) ; d'oh!

(require 'arorem)

(defun ruby-newline-and-indent ()
  (interactive)
  (newline)
  (ruby-indent-command))

; some times i have to use emacs21! sad but true
(if (= emacs-major-version 22)
    (progn
      (file-name-shadow-mode)
      (load "irc-stuff")
      (add-to-list 'hs-special-modes-alist
		   (list 'ruby-mode
			 (concat ruby-block-beg-re "\|{")
			 (concat ruby-block-end-re "\|}")
			 "#"
			 'ruby-forward-sexp nil)))
  ; so reveal-mode in my-ruby-mode-hook doesn't barf
  (defun reveal-mode() t))

(defun my-ruby-mode-hook ()
  (ruby-electric-mode)
  (hs-minor-mode)
  (reveal-mode)
  (local-set-key (kbd "RET") 'ruby-reindent-then-newline-and-indent))

(add-hook 'ruby-mode-hook 'my-ruby-mode-hook)

(setq ri-ruby-script (expand-file-name "~/.emacs.d/ri-emacs.rb"))
(require 'ri-ruby)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Use libnotify to tell us when our name happens

(add-hook 'rcirc-receive-message-hooks 'notify-if-nick)

(defun notify-if-nick (process command sender args line)
  (if (string-match rcirc-nick line)
      (shell-command (concat "notify-send \"" sender " said\" \"" line "\""))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;     key bindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; for when the terminal is misbehaving (not the best way to fix)
;(global-set-key "\C-h" 'backward-delete-char)
(global-set-key "\M-h" 'backward-kill-word)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\C-x\C-r" 'jump-to-register)

; linear buffer-switching
(global-set-key "\M-p" 'bs-cycle-next)
(global-set-key "\M-n" 'bs-cycle-previous)

; 2D spatial buffer-switching
(global-set-key [(control shift p)] 'tabbar-backward-group)
(global-set-key [(control shift n)] 'tabbar-forward-group)
(global-set-key [(control shift b)] 'tabbar-backward)
(global-set-key [(control shift f)] 'tabbar-forward)

; sometimes my hands aren't in the right place
(global-set-key [(control shift up)] 'tabbar-backward-group)
(global-set-key [(control shift down)] 'tabbar-forward-group)
(global-set-key [(control shift left)] 'tabbar-backward)
(global-set-key [(control shift right)] 'tabbar-forward)

; just useful for learning new modes
(global-set-key [f1] 'menu-bar-mode)

(global-set-key [f2] 'color-theme-zenburn)
(global-set-key [(shift f2)] 'color-theme-standard)

; useful for ansi-terms
(global-set-key [f3] 'rename-buffer)

; display images using imagemagick
(global-set-key [f5] (lambda () 
		       (interactive) 
		       (shell-command (concat "display " 
					      (thing-at-point 'filename)))))

(global-set-key [(shift f5)] 'flickr-grab)

(defun flickr-grab ()
  "Display only the photo from a flickr url"
  (interactive)
  (w3m-browse-url
   (with-current-buffer (url-retrieve-synchronously (thing-at-point 'filename))
     (save-excursion
       (re-search-backward "src=\"\\(http://static\\.flickr\\.com/[[:digit:]]*/[[:digit:]]*\_[[:alnum:]]*\\.jpg\\)")
       (match-string 1)))))

(global-set-key [f6] (lambda (lat lng)
		       (interactive "BLatitude: \nBLongitude")
		       (w3m-browse-url (concat "http://maps.yahoo.com/maps_result?mag=12&lat="
					       lat
					       "&lon="
					       lng))))


; i think zenspider wrote this
(defvar ys-eshell-wins nil)
(global-set-key [f8] (lambda (win-num)
		       (interactive "p")
		       (message "win-num %s" win-num)
		       (let ((assoc-buffer (cdr (assoc win-num ys-eshell-wins))))
			 (if (not (buffer-live-p assoc-buffer))
			     (progn ; the requested buffer not there 
			       (setq assoc-buffer (eshell t))
			       (setq ys-eshell-wins (assq-delete-all win-num ys-eshell-wins))
			       (add-to-list 'ys-eshell-wins (cons win-num assoc-buffer))))
			 (switch-to-buffer assoc-buffer)
			 (rename-buffer (concat "*eshell-" (int-to-string win-num) "*"))
			 assoc-buffer)))

(global-set-key [f9] '(lambda () 
			(interactive) 
			(ansi-term "/bin/bash")))

; great for quick googles
(global-set-key [f10] 'w3m)

(global-set-key [f11] 'ri)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;     registers (C-x C-r)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(set-register ?e '(file . "~/.emacs"))
(set-register ?d '(file . "~/.emacs.d"))
(set-register ?g '(file . "~/.gnus.el"))
(set-register ?b '(file . "~/.bashrc"))
(set-register ?s '(file . "~/.screenrc"))
      
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;     misc things
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq font-lock-maximum-decoration t)
(blink-cursor-mode -1)
(auto-compression-mode 1) ; load .gz's automatically
(setq inhibit-startup-message t)
(setq transient-mark-mode t)
(show-paren-mode 1)
(mouse-wheel-mode 1) ; duh! this should be default.
(set-scroll-bar-mode 'right) ; mostly for seeing how far down we are, not for clicking
(tool-bar-mode -1)
(menu-bar-mode -1) ; toggled by F1
(tabbar-mode)
(global-hl-line-mode) ; especially nice in w3m
(global-font-lock-mode t)
(setq color-theme-is-global nil)
(tooltip-mode -1)
(setq frame-title-format '(buffer-file-name "%f" ("%b")))
(ido-mode)
(set-default-font "terminus-16") ; apt-get install xfonts-terminus

;; don't clutter directories!
(setq backup-directory-alist `(("." . ,(expand-file-name "~/.emacs.baks"))))
(setq auto-save-directory (expand-file-name "~/.emacs.d/backups"))

;; browsing
(setq browse-url-browser-function 'browse-url-firefox)
(setq browse-url-firefox-new-window-is-tab t)

;; w3m
(setq w3m-use-cookies t)
(setq w3m-default-save-directory "~/")

(setq w3m-search-engine-alist
      '(("C2" "http://c2.com/cgi-bin/wiki?%s")
        ("EmacsWiki" "http://emacswiki.org/cgi-bin/wiki/%s")
        ("GDict" "http://google.com.au/search?q=define:%s")
        ("GGroups" "http://google.es/groups?q=%s")
        ("GIS" "http://google.com.au/images?q=%s")
        ("Google" "http://www.google.com.au/search?q=%s")
        ("ISBN" "http://www.amazon.com/exec/obidos/ASIN/%s")
        ("RFC" "http://www.faqs.org/rfc/rfc%s")
        ("Sourceforge" "http://sf.net/projects/%s")
        ("Thesaurus"
         "http://thesaurus.reference.com/search?db=roget&q=%s")
        ("Wikipedia"
         "http://en.wikipedia.org/wiki/Special:Search?search=%s")))

(mapc (lambda (v) (set v nil))
      '(w3m-show-graphic-icons-in-header-line
        w3m-show-graphic-icons-in-mode-line
        w3m-track-mouse
        w3m-use-favicon
        w3m-use-toolbar))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;    Nifty things to remember and hopefully use
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; M-z zap to char
; C-u C-SPC jump to previous edit
; M-/ autocomplete word 
; M-! insert output of shell command
; M-| replace region with shell output
; M-x thumbs
; C-r k Rectangle kill

; C-x h select all
; C-M-\ indent

; Macros
; C-m C-r to begin
; name it, and do stuff
; C-s to save

; temp macros
; C-m C-m to start recording
; C-m C-s to stop
; C-m C-p to play

; M-C-p, M-C-n back and forward blocks
; C-c C-s irb when in ruby-mode
