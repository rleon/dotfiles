(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'monokai t)

(add-to-list 'load-path "~/.emacs.d/vendor/emacs-powerline")
(require 'powerline)

(menu-bar-mode -1) ; hide menubar
(tool-bar-mode -1) ; hide toolbar
(setq inhibit-startup-screen t) ; kill wellcome screen

; add line numbers
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

(server-start) ; keep one emacs instance and connect with emacsclient

(defun rl-term-start-or-switch (prg &optional use-existing)
  "* run program PRG in a terminal buffer. If USE-EXISTING is non-nil "
  " and PRG is already running, switch to that buffer instead of starting"
  " a new instance."
  (interactive)
  (let ((bufname (concat "*" prg "*")))
    (when (not (and use-existing
                 (let ((buf (get-buffer bufname)))
                   (and buf (buffer-name (switch-to-buffer bufname))))))
      (ansi-term prg prg))))

(defmacro rl-program-shortcut (name key &optional use-existing)
  "* macro to create a key binding KEY to start some terminal program PRG; 
    if USE-EXISTING is true, try to switch to an existing buffer"
  `(global-set-key ,key 
     '(lambda()
        (interactive)
        (rl-term-start-or-switch ,name ,use-existing))))

; terminal programs are under Shift + Function Key
(rl-program-shortcut "zsh"   (kbd "<S-f1>") t)  ; the ubershell

; smart buffer list management 
(global-set-key (kbd "C-x C-b") 'ibuffer)
