;; ~/.emacs
;; Luke Hoersten <Luke@Hoersten.org>

;; general
(setq-default load-path (cons "~/.emacs.d/" load-path))               ; set default emacs load path
(setq-default user-mail-address "lhoersten@allstontrading.com")

(setq-default ediff-split-window-function 'split-window-horizontally) ; diff horizontally
(setq-default x-select-enable-clipboard t)                            ; paste from X buffer
(setq-default inhibit-splash-screen t)                                ; disable splash screen
(put 'set-goal-column 'disabled nil)                                  ; enable goal column setting
(put 'narrow-to-region 'disabled nil)                                 ; enable hiding

(display-time-mode t)                                                 ; show clock
(column-number-mode t)                                                ; show column numbers
(delete-selection-mode t)                                             ; replace highlighted text
(windmove-default-keybindings)                                        ; move between windows with shift-arrow
(setq-default indent-tabs-mode nil)                                     ; mouse hover variables

(ido-mode t)                                                          ; file/buffer selector
(setq-default ido-enable-flex-matching t)                             ; fuzzy matching is a must have
(add-hook 'text-mode-hook 'flyspell-mode t)                           ; spellcheck text

;; coding
(which-func-mode t)                                                   ; show current function
(show-paren-mode t)                                                   ; show matching paren
(transient-mark-mode t)                                               ; show highlighting
(global-font-lock-mode t)                                             ; syntax highlighting
(global-whitespace-mode t)                                            ; show whitespace
(setq-default whitespace-style '(tab-mark trailing tabs empty))       ; what whitespace elements to show
(add-hook 'before-save-hook 'whitespace-cleanup)                      ; cleanup whitespace on exit
(global-set-key (kbd "C-c c") 'compile)                               ; compile

(require 'hoersten-pastebin-region)                                   ; send selected text to pastebin
(require 'mercurial)                                                  ; load mercurial mode
(require 'hoersten-c-style)                                           ; load c specific lisp

(require 'pretty-mode)                                                ; convert characters to unicode
(global-pretty-mode t)
(setq haskell-font-lock-symbols 'unicode)

(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets/")

;; gdb settings
(setq-default gdb-many-windows t)                                     ; gdb many windows
(setq-default gdb-use-separate-io-buffer t)                           ; gdb stdio output
(setq-default gud-tooltip-mode t)                                     ; mouse hover variables
(global-set-key (kbd "C-c g") 'gdb)                                   ; gdb

;; use only spaces for alignment
(global-set-key (kbd "C-c a") 'align-with-spaces) ; align
(defun align-with-spaces (beg end pattern)
  "Align selected using only spaces for whitespace."
  (interactive "r\nsAlign by: ")
  (let ((indent-tabs-mode nil))
    (align-string beg end pattern 1)
    (align-entire beg end)
    (untabify beg end)
    (indent-region beg end)
    (whitespace-cleanup-region beg end)))

;; Shell
(global-set-key (kbd "C-c s") 'shell)              ; start shell
(ansi-color-for-comint-mode-on)                    ; color in shell buffer
(setq-default comint-scroll-to-bottom-on-input t)  ; only type on prompt
(setq-default comint-scroll-show-maximum-output t) ; place text at bottom

;; map file extensions to modes
(setq-default auto-mode-alist
              (append
               '(("\\.ipp$" . c++-mode)
                 ("\\.inl$" . c++-mode)
                 ("SCons"   . python-mode)
                 ("\\.jj$"  . java-mode))
               auto-mode-alist))

;; x stuff
(if (not window-system)
    (menu-bar-mode nil) ; remove menu bar in no-x mode
  (tool-bar-mode nil)   ; remove tool bar
  (scroll-bar-mode nil) ; remove scroll bar
  (custom-set-faces '(default ((t (:background "#000000" :foreground "#ffffff" :height 101 :family "DejaVu Sans Mono")))))
  (setq default-frame-alist '((width . 100) (height . 50) (menu-bar-lines . 1)))
  (visual-line-mode t)                                                  ; word wrap break on whitespace

  ;; twilight theme
  (require 'color-theme)
  (load "color-theme-twilight")
  (color-theme-twilight)
  (global-hl-line-mode t))
