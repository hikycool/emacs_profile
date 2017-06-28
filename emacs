
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("bb749a38c5cb7d13b60fa7fc40db7eced3d00aa93654d150b9627cabd2d9b361" "0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" "b3775ba758e7d31f3bb849e7c9e48ff60929a792961a2d536edec8f68c671ca5" "72a81c54c97b9e5efcc3ea214382615649ebb539cb4f2fe3a46cd12af72c7607" "58c6711a3b568437bab07a30385d34aacf64156cc5137ea20e799984f4227265" "3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02" "3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6" "987b709680284a5858d5fe7e4e428463a20dfabe0a6f2a6146b3b8c7c529f08b" "96998f6f11ef9f551b427b8853d947a7857ea5a578c75aa9c4e7c73fe04d10b4" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "9b59e147dbbde5e638ea1cde5ec0a358d5f269d27bd2b893a0947c4a867e14c1" "3d5ef3d7ed58c9ad321f05360ad8a6b24585b9c49abcee67bdcbb0fe583a6950" "e0d42a58c84161a0744ceab595370cbe290949968ab62273aed6212df0ea94b4" default)))
 '(package-selected-packages (quote (org-beautify-theme eww-lnum ##)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;-----------------------load default theme -----------------------------

(add-to-list 'custom-theme-load-path "~/.emacs.d/theme")

(load-theme 'wilson t)


;; cancel welcome page
(setq inhibit-splash-screen t)


;;------------------------------------------------

;;------------------------font-------------------------
 
;; Setting English Font
;;(set-face-attribute
;; 'default nil :font "Ayuthaya 14")

;; Setting Chinese Font
;;(dolist (charset '(kana han symbol cjk-misc bopomofo))  
;;  (set-fontset-font (frame-parameter nil 'font)  
;;                    charset  
;;                    (font-spec :family "Yuanti SC" :size 14)))

;;---------------------------------------------------

;;-----------------------------windows number--------------------
(add-to-list 'load-path "~/.emacs.d/window/")    
(require 'window-numbering)						      ;;number of windows
(window-numbering-mode 1)

(global-linum-mode t)
(setq linum-format "%d")

;;(setq default-frame-alist 
;;'((height . 35) (width . 120) (menu-bar-lines . 20) (tool-bar-lines . 0)))    ;;the size of init_window
;;------------------------------------------------------------

;;--------------------------multi-term---------------------
(add-to-list 'load-path "~/.emacs.d/multi-term")
(require 'multi-term)
(setq multi-term-program "/bin/bash")
;; Use Emacs terminfo, not system terminfo, mac系统出现了4m
(setq system-uses-terminfo nil)

;;switch key
(add-hook 'term-mode-hook
          (lambda ()
            (add-to-list 'term-bind-key-alist '("M-[" . multi-term-prev))
            (add-to-list 'term-bind-key-alist '("M-]" . multi-term-next))))

;;cancle the limite of line number
(add-hook 'term-mode-hook
          (lambda ()
            (setq term-buffer-maximum-size 0)))

;;cancle minor mode
;;(add-hook 'term-mode-hook
  ;;        (lambda ()
    ;;        (setq show-trailing-whitespace nil)
      ;;      (autopair-mode -1)))
;;short-cut key
(global-set-key (kbd "C-q") 'multi-term)

(global-visual-line-mode 1)

;;the paste
(add-hook 'term-mode-hook
          (lambda ()
            (define-key term-raw-map (kbd "C-y") 'term-paste)))

;;----------------------------------------------------------
;;----------------------imenu_list--------------------------
(add-to-list 'load-path "~/.emacs.d/imenu")
(require 'imenu-list)
(global-set-key (kbd "M-q") 'imenu-list)

;;---------------------------------------------------------
;;----------------------package manage---------------------
(require 'package)
(add-to-list
 'package-archives
 '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
;;----------------------elpy-mode---------------------------
(package-initialize)
(elpy-enable)
