(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("d268b67e0935b9ebc427cad88ded41e875abfcc27abd409726a92e55459e0d01" "745d03d647c4b118f671c49214420639cb3af7152e81f132478ed1c649d4597d" "c4063322b5011829f7fdd7509979b5823e8eea2abf1fe5572ec4b7af1dd78519" "db5b906ccc66db25ccd23fc531a213a1afb500d717125d526d8ff67df768f2fc" "7661b762556018a44a29477b84757994d8386d6edee909409fabe0631952dad9" default))
 '(helm-completion-style 'helm)
 '(package-selected-packages
   '(multi-vterm lsp-mode yasnippet lsp-treemacs helm-lsp projectile hydra flycheck company avy which-key helm-xref dap-mode))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(warning-suppress-log-types '((comp)))
 '(warning-suppress-types '((lsp-mode))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; -------------- system setting ----------------------
;; all backups goto ~/.backups instead in the current directory
;; (setq backup-directory-alist (quote (("." . "/Users/syu/Zmacs/backup_file/"))))
(setq backup-directory-alist (quote (("." . "~/Zmacs/backup_file"))))
(setenv "LIBRARY_PATH" "/usr/local/opt/gcc/lib/gcc/12:/usr/local/opt/gcc/lib/gcc/12/gcc/x86_64-apple-darwin21/12")

(setq message-log-max t)
;; ----------------------------------------------------

(add-to-list 'load-path "~/.emacs.d/packages/")
(require 'package)
(setq package-archives
      '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
	("melpa-stable" . "https://stable.melpa.org/packages/")))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
;;(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;;-----------------------Tramp----------------------------------------
(setq tramp-default-method "ssh")
(setq directory-abbrev-alist '(("^/mime" . "/ssh:root@cdp:/root/Mime")))
(setq tramp-use-ssh-controlmaster-options nil)
(setq recentf-exclude `(,tramp-file-name-regexp
                        "COMMIT_EDITMSG")
      tramp-auto-save-directory temporary-file-directory
      backup-directory-alist (list (cons tramp-file-name-regexp nil)))
(defun my/project-remember-advice (fn pr &optional no-write)
  (let* ((remote? (file-remote-p (project-root pr)))
         (no-write (if remote? t no-write)))
    (funcall fn pr no-write)))

(advice-add 'project-remember-project :around
            'my/project-remember-advice)

;; if debug set verbose to 10, default is 3
(setq tramp-verbose 10)
;;-----------------------Tramp----------------------------------------

;;-----------------use package-----------------
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

(eval-and-compile
  (setq use-package-always-ensure t)    ; 不用每个包都手动添加:ensure t 关键字
  (setq use-package-always-defer t)     ; 默认都是延时加载，不用每个包都手动添加:defer t 关键字
  (setq use-package-always-demand nil)  ;
  (setq use-package-expand-minimally t) ;
  (setq use-package-verbose t)          ; 打印安装过程
  )

;;-----------------use package-----------------

;;-----------------straight--------------------
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
;;-----------------straight--------------------

;;-----------------all-the-icos----------------
(use-package all-the-icons
  :if (display-graphic-p))
(when (display-graphic-p)
  (require 'all-the-icons))
;;----------------------------------------------------

;;------------------------theme-------------------------
(use-package gruvbox-theme)
;;  :init(load-theme 'gruvbox-dark-hard t))

(straight-use-package '(nano-theme :type git :host github
                                   :repo "rougier/nano-theme"))
;;(load-theme 'nano-dark t)
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-gruvbox t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))
(load-theme 'doom-gruvbox t)

;;------------------------theme-------------------------

;;-----------------window-numbering-------------------
;;(use-package window-numbering
  ;;:config 
  ;;:init(setq window-numbering-mode t)
  ;;)
(use-package window-numbering
  :ensure t
  :unless noninteractive
  :demand t
  )
(require 'window-numbering)
(setq window-numbering-assign-func
      (lambda () (when (equal (buffer-name) "*Calculator*") 9)))
(window-numbering-mode t)

;;------------------------title bar--------------------
;; 隐藏 title bar
;;(setq default-frame-alist '((undecorated . t)))
;;(add-to-list 'default-frame-alist '(drag-internal-border . 1))
;;(add-to-list 'default-frame-alist '(internal-border-width . 5))
(add-to-list 'default-frame-alist '(undecorated-round . t))
;;------------------------title bar--------------------

;;------------------------font-------------------------
 
;; Setting English Font
(set-face-attribute
 'default nil :font "Ayuthaya 16")

;; Setting Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))  
  (set-fontset-font (frame-parameter nil 'font)  
                    charset  
                    (font-spec :family "Yuanti SC" :size 15)))

(use-package cnfonts
  :ensure t)
(cnfonts-mode 1)
(define-key cnfonts-mode-map (kbd "C--") #'cnfonts-decrease-fontsize)
(define-key cnfonts-mode-map (kbd "C-=") #'cnfonts-increase-fontsize)
(setq cnfonts-profiles
      '("default" "org-mode" "code"))
;;-----------------------font end---------------------

;;-----------------------Dashbaord--------------------
(use-package dashboard)
(require 'dashboard)
(dashboard-setup-startup-hook)
(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
(setq dashboard-banner-logo-title "Specified Coding Work by Syu")
(setq dashboard-startup-banner "/Users/syu/.emacs.d/logo/logo_fish_27.png")
;;-----------------------Dashbaord--------------------

;; --------------- execute path from shell -----------
(use-package exec-path-from-shell
  :demand t
  :config (when (memq window-system '(mac ns x))
	    (exec-path-from-shell-initialize)))
;; ---------------------------------------------------
;; -------------------Helm----------------------
(use-package helm-xref)
(helm-mode)
(require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)
;; ---------------------------------------------

;; -------------------LSP-Bridge-------------------

(use-package posframe
  :ensure t)
(use-package markdown-mode
  :ensure t)
(use-package yasnippet
  :ensure t)
;; (add-to-list 'load-path "/Users/syu/Zmacs/syu-bridge/")
;; (add-to-list 'load-path "/Users/syu/Zmacs/lsp-bridge/")
(add-to-list 'load-path "/Users/syu/Zmacs/bridge/")
;; (add-to-list 'load-path "/Users/syu/Zmacs/mbridge/")

(require 'yasnippet)
(yas-global-mode 1)
(require 'lsp-bridge)
;;(global-lsp-bridge-mode)
(setq lsp-bridge-c-lsp-server "ccls")
(setq lsp-bridge-python-lsp-server "pyright")
(add-hook 'python-mode-hook #'lsp-bridge-mode)
(add-hook 'python-ts-mode-hook #'lsp-bridge-mode)
;;(add-hook 'c-mode-hook #'lsp-bridge-mode)
;;(add-hook 'c++-mode-hook #'lsp-bridge-mode)
(add-hook 'emacs-lisp-mode-hook #'lsp-bridge-mode)
(add-hook 'go-mode-hook #'lsp-bridge-mode)
(add-hook 'go-ts-mode-hook #'lsp-bridge-mode)
(add-hook 'yaml-mode-hook #'lsp-bridge-mode)
(add-hook 'yaml-ts-mode-hook #'lsp-bridge-mode)
(add-hook 'js-json-mode-hook #'lsp-bridge-mode)
(add-hook 'json-ts-mode-hook #'lsp-bridge-mode)
(add-hook 'dockerfile-mode #'lsp-bridge-mode)
(add-hook 'dockerfile-ts-mode #'lsp-bridge-mode)

(setq lsp-bridge-enable-log nil)
(setq lsp-bridge-enable-debug nil)

(global-set-key (kbd "C-x M-.") 'lsp-bridge-find-def)
(global-set-key (kbd "C-x M-,") 'lsp-bridge-find-def-return)
(global-set-key (kbd "C-x M-?") 'lsp-bridge-find-references)
(global-set-key (kbd "C-x M-'") 'lsp-bridge-find-impl)
(global-set-key (kbd "C-x M-\"") 'lsp-bridge-find-impl-other-window)

;; ------------------------------------------------

;; -------------------Eglot------------------------
(use-package eglot
  :config
  (add-to-list 'eglot-server-programs '((c-mode c++-mode c-ts-mode c++-ts-mode) . ("ccls")))
  :hook ((c-mode . eglot-ensure)
	 (c++-mode . eglot-ensure)
	 (c-ts-mode . eglot-ensure)
	 (c++-ts-mode . eglot-ensure))
  )

(use-package company
  :after eglot
  :hook (eglot-managed-mode . company-mode))
(require 'eglot)

(use-package google-c-style
  :ensure t
  :hook
  (c-mode-common-hook . google-set-c-style)
  (c-mode-common-hook . google-make-newline-indent)
  )

;; ------------------------------------------------

;;---------------LSP---------------------------------
;; --------------------------------------

;; --------------- hot keys -----------------
;; full screen
(global-set-key (kbd "C-s-f") 'toggle-frame-fullscreen)

;; --------------- hot keys -----------------

;; --------------- yaml --------------------
(use-package yaml-mode)
(require 'yaml-mode)
    (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-hook 'yaml-mode-hook
          (lambda ()
            (define-key yaml-mode-map "\C-m" 'newline-and-indent)))
;;-----------------yaml----------------------


;;----------------imenu--------------------
(use-package imenu)
(use-package imenu-list)
;;-----------------------------------------



;;---------------JAVA---------------------
;;---------------LSP---------------------------------

(setq package-selected-packages '(lsp-mode yasnippet lsp-treemacs helm-lsp
    projectile hydra flycheck company avy which-key helm-xref dap-mode))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))
(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

(use-package lsp-mode
  :ensure t)

(which-key-mode)
;;(add-hook 'c-mode-hook 'lsp)
;;(add-hook 'c++-mode-hook 'lsp)
(setq lsp-log-io nil)
(setq lsp-lens-enable nil)
;;---------------JAVA---------------------
(use-package lsp-ui
  :config
  (setq lsp-prefer-flymake nil
        lsp-ui-doc-delay 1.0
        lsp-ui-sideline-enable t
        lsp-ui-sideline-show-symbol nil
	lsp-ui-doc-enable t
	lsp-ui-doc-show-with-cursor t))
;;(define-key lsp-mode-map (kbd "C-x M-,") #'lsp-ui-peek-find-references)
;;(define-key lsp-mode-map (kbd "C-x M-.") #'lsp-ui-peek-find-definitions)

(use-package lsp-java
  :after lsp-mode
  ;; :if (executable-find "mvn")
  :init (use-package request :defer t)
  :config (add-hook 'java-mode-hook 'lsp)
  :custom
  (lsp-java-server-install-dir (expand-file-name "/Users/syu/.emacs.d/eclipse.jdt.ls/server/"))
  (lsp-java-workspace-dir (expand-file-name "/Users/syu/.emacs.d/eclipse.jdt.ls/workspace/")))
(use-package dap-mode
  :after lsp-mode
  :config
  (dap-auto-configure-mode)
  (dap-mode t)
  (dap-ui-mode t)
  (dap-tooltip-mode 1)
  (tooltip-mode 1)
  )
;; (use-package dap-java :ensure nil)
(use-package dap-java
  :ensure nil
  :after (lsp-java))

(require 'lsp-java)
(require 'lsp-java-boot)
;; to enable the lenses
;; (add-hook 'lsp-mode-hook #'lsp-lens-mode)
;;(require 'lsp-java-boot)
;;(add-hook 'java-mode-hook #'lsp)
(add-hook 'java-mode-hook #'lsp)
(add-hook 'java-mode-hook #'lsp-java-boot-lens-mode)
(setq lsp-java-format-settings-url "file://Users/syu/.emacs.d/java-google-style.xml")
(setq lsp-java-format-settings-profile "GoogleStyle")
;;(add-hook 'java-mode-hook (lambda ()
;;                            (setq c-default-style "java")
;;                            (setq c-basic-offset 4)
                            ;; (display-line-numbers-mode nil)
;;                            ))
(setq lsp-file-watch-ignored
  '(".idea" ".ensime_cache" ".eunit" "node_modules"
            ".git" ".hg" ".fslckout" "_FOSSIL_"
            ".bzr" "_darcs" ".tox" ".svn" ".stack-work"
            "build"))
(setq path-to-lombok (car (file-expand-wildcards "/Users/syu/.emacs.d/eclipse.jdt.ls/server/lombok.jar")))
(setq lsp-java-java-path "/usr/local/Cellar/openjdk/21.0.2/libexec/openjdk.jdk/Contents/Home/bin/java")
(setq lsp-java-configuration-runtimes '[
					(:"JAVASE-1.8_301"
					  :path "/Library/Java/JavaVirtualMachines/jdk1.8.0_301.jdk/Contents/Home/")
					(:"JAVA-11"
					  :path "/usr/local/opt/openjdk@11/libexec/openjdk.jdk/Contents/Home/")
					(:"JAVA-21"
					  :path "/usr/local/Cellar/openjdk/21.0.2/libexec/openjdk.jdk/Contents/Home/"
					  :default t)
					])

;; 			"-XX:GCTimeRatio=4"
;;			"-XX:AdaptiveSizePolicyWeight=90"
;;			"-Dsun.zip.disableMemoryMapping=true"

(setq lsp-java-vmargs '("-noverify"
			"-XX:+UseG1GC"
			"-XX:+UseStringDeduplication"
			"-Xmx3G"
			"-Xms2G"
			"-javaagent:/Users/syu/.emacs.d/eclipse.jdt.ls/server/lombok.jar"))

;; Don't organise imports on save
(setq lsp-java-save-action-organize-imports nil)

;; Fetch less results from the Eclipse server
(setq lsp-java-completion-max-results 20)

;;(setq lsp-java-imports-gradle-wrapper-checksums [(:sha256 \"e2e16793e30bfca74dee8134d9bd29b349077cbc8bd35ee1c313f9470aa9d862\" :allowed t)])
(setq lsp-java-imports-gradle-wrapper-checksums [(:sha256 "\"6e521a1cf8cc93a00c3c4de8b9abb39a70be412c195783f3088d71d8ff41cffd\"" :allowed t)])
(setq lsp-java-import-gradle-enabled t)
(setq lsp-java-import-maven-enabled t)
(setq lsp-java-trace-server "verbose")
;;(require 'lsp-java-boot)
;; to enable the lenses
;;(add-hook 'lsp-mode-hook #'lsp-lens-mode)
;;(add-hook 'java-mode-hook #'lsp-java-boot-lens-mode)

;;---------------JAVA---------------------

;;---------------Scala-------------------
(use-package scala-mode
  :interpreter
  ("scala" . scala-mode))
(use-package sbt-mode
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
   ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
   (setq sbt:program-options '("-Dsbt.supershell=false"))
   )
;;(use-package flycheck
;;  :init (global-flycheck-mode))
(use-package lsp-metals
  :ensure t
  :custom
  ;; Metals claims to support range formatting by default but it supports range
  ;; formatting of multiline strings only. You might want to disable it so that
  ;; emacs can use indentation provided by scala-mode.
  (lsp-metals-server-args '("-J-Dmetals.allow-multiline-string-formatting=off"))
  :hook (scala-mode . lsp))

(use-package company
  :hook (scala-mode . company-mode)
  :config
  (setq lsp-completion-provider :capf))

(use-package posframe
  :ensure t)

;;---------------Scala-------------------
;;---------------JAVA---------------------

;;---------------Scala-------------------
;;---------------Scala-------------------

;;---------------Libvterm---------------
(use-package vterm
  :ensure t)
(use-package multi-vterm
  :ensure t)
;;--------------Libvterm---------------

;;--------------ORG-------------------
(use-package org-download
  :ensure t)
(add-hook 'dired-mode-hook 'org-download-enable)

;; (setq-default org-download-image-dir "~/Self/ORG/org_image/")
(setq org-use-fast-todo-selection t)
(setq org-todo-keywords '((sequence "TODO(t)" "DOING(i)" "|" "DONE(d)" "ABORT(a)")))
(setq org-todo-keyword-faces '(
			       ("DOING" . "orange")
			       ("ABORT" . "gray")
			       ))
;;(setq org-todo-keyword-faces '(("TODO" . "red")
;;                               ("DOING" . "yellow")
;;                               ("DONE" . "green")
;;			       ("ABORT" . "gray")
;;			       ))
(add-hook 'org-mode 'cnfonts-enable)
(use-package company-org-block
  :ensure t
  :custom
  (company-org-block-edit-style 'auto) ;; 'auto, 'prompt, or 'inline
  :hook ((org-mode . (lambda ()
                       (setq-local company-backends '(company-org-block))
                       (company-mode +1)))))
(org-babel-do-load-languages
 'org-babel-load-languagesc
 '((C . t)
   (python . t)
   (java . t)
   (org . t)
   (makefile . t)
   (sql . t)
   (shell . t)
   ))

(use-package org-roam
  :ensure t)
(use-package simple-httpd
  :ensure t)
(use-package f
  :ensure t)
(use-package websocket
  :after org-roam)
(use-package org-roam-ui
  ;;:straight
  ;;(:host github :repo "org-roam/org-roam-ui" :branch "main" :files ("*.el" "out"))
  :after org-roam
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(setq org-roam-directory "~/Self/ORG/roam/")
(add-hook 'after-init-hook 'org-roam-mode)

(require 'org-roam-protocol)
(use-package org-transclusion
  :after org
  :bind
  (:map global-map
	("C-x M-a" . #'org-transclusion-add)
	("C-x M-m" . #'org-transclusion-mode)
	))
;;--------------ORG-------------------

;;--------------lsp docker------------
;;(use-package docker-tramp
;;  :ensure t)
;; Uncomment the next line if you are using this from source
;; (add-to-list 'load-path "<path-to-lsp-docker-dir>")
;;(use-package lsp-docker
;;  :ensure t)
;;(require 'lsp-docker)

;;(defvar lsp-docker-client-packages
;;    '(lsp-css lsp-clients lsp-bash lsp-go lsp-pyls lsp-html lsp-typescript
;;      lsp-terraform lsp-clangd))

;;(setq lsp-docker-client-configs
;;    '((:server-id bash-ls :docker-server-id bashls-docker :server-command "bash-language-server start")
;;      (:server-id clangd :docker-server-id clangd-docker :server-command "ccls")
;;      (:server-id css-ls :docker-server-id cssls-docker :server-command "css-languageserver --stdio")
;;      (:server-id dockerfile-ls :docker-server-id dockerfilels-docker :server-command "docker-langserver --stdio")
;;      (:server-id gopls :docker-server-id gopls-docker :server-command "gopls")
;;      (:server-id html-ls :docker-server-id htmls-docker :server-command "html-languageserver --stdio")
;;      (:server-id pyls :docker-server-id pyls-docker :server-command "pyls")
;;      (:server-id ts-ls :docker-server-id tsls-docker :server-command "typescript-language-server --stdio")))

;;(require 'lsp-docker)
;;(lsp-docker-init-clients
;;  :path-mappings '(("/Users/syu/Code/dproject" . "/projects"))
;;  :client-packages lsp-docker-client-packages
;;  :client-configs lsp-docker-client-configs)
;;--------------lsp docker------------

;; ------------- protobuf buf mode -------------------

(use-package protobuf-mode
  :ensure t)
(setq auto-mode-alist  (cons '(".proto$" . protobuf-mode) auto-mode-alist))

;; ------------- protobuf buf mode -------------------
;;------------- mode line ------------------
(use-package all-the-icons
  :if (display-graphic-p))
(use-package doom-modeline)
(doom-modeline-mode t)
(setq doom-modeline-support-imenu t)
;;------------- mode line ------------------
;;------------- treemacs ----------------------
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                 (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay      0.5
          treemacs-directory-name-transformer    #'identity
          treemacs-display-in-side-window        t
          treemacs-eldoc-display                 t
          treemacs-file-event-delay              5000
          treemacs-file-extension-regex          treemacs-last-period-regex-value
          treemacs-file-follow-delay             0.2
          treemacs-file-name-transformer         #'identity
          treemacs-follow-after-init             t
          treemacs-git-command-pipe              ""
          treemacs-goto-tag-strategy             'refetch-index
          treemacs-indentation                   2
          treemacs-indentation-string            " "
          treemacs-is-never-other-window         nil
          treemacs-max-git-entries               5000
          treemacs-missing-project-action        'ask
          treemacs-no-png-images                 nil
          treemacs-no-delete-other-windows       t
          treemacs-project-follow-cleanup        nil
          treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                      'left
          treemacs-recenter-distance             0.1
          treemacs-recenter-after-file-follow    nil
          treemacs-recenter-after-tag-follow     nil
          treemacs-recenter-after-project-jump   'always
          treemacs-recenter-after-project-expand 'on-distance
          treemacs-show-cursor                   nil
          treemacs-show-hidden-files             t
          treemacs-silent-filewatch              nil
          treemacs-silent-refresh                nil
          treemacs-sorting                       'alphabetic-asc
          treemacs-space-between-root-nodes      t
          treemacs-tag-follow-cleanup            t
          treemacs-tag-follow-delay              1.5
          treemacs-user-mode-line-format         nil
          treemacs-width                         35
	  treemacs-load-theme                    "all-the-icons")

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
	("C-x t s"   . treemacs-switch-workspace)
        ("C-x t b"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))
(use-package treemacs-all-the-icons
  :ensure t)
(require 'treemacs-all-the-icons)
(treemacs-load-theme "all-the-icons")

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package treemacs-icons-dired
  :after treemacs dired
  :ensure t
  :config (treemacs-icons-dired-mode))

(use-package treemacs-magit
  :after treemacs magit
  :ensure t)

(use-package treemacs-persp
  :after treemacs persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))
;;-------------- treemacs ---------------------
;; ------------- Rainbow -----------------------------------------
(use-package rainbow-mode)
(add-hook 'prog-mode-hook 'rainbow-mode)
(use-package rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
;;---------------------------------------------------------------
;;------------------- Tree sitter --------------------------
;;(use-package tree-sitter)
;;(use-package tree-sitter-langs)
;;(require 'tree-sitter)
;;(require 'tree-sitter-langs)
;;;; (global-tree-sitter-mode)
;;(add-hook 'python-mode-hook #'tree-sitter-hl-mode)
;;(add-hook 'c-mode-hook #'tree-sitter-hl-mode)
;;(add-hook 'c++-mode-hook #'tree-sitter-hl-mode)
;;(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
(use-package treesit-auto
  :demand t
  :config
  (setq treesit-auto-install 'prompt)
  (global-treesit-auto-mode))

;;-----------------------------------------------------------
;;--------------------- helm ag -----------------------------
;; sudo apt-get install silversearcher-ag
(use-package helm-ag
  :ensure t
  :bind
  (:map global-map
	("C-x a g" . helm-ag)
	("C-x a d" . helm-do-ag)
	("C-x a f" . helm-do-ag-project-root)
	("C-x a s" . helm-ag-project-root)
	))
;;----------------------------------------------------------
;;------------------- flycheck -----------------
(use-package flycheck
  :ensure t)
(add-hook 'python-mode-hook #'flymake-mode)
;;------------------- flycheck -----------------

;;------------------- kubernetes ---------------
(use-package kubernetes)
(fset 'ks 'kubernetes-overview)
;;------------------- kubernetes ---------------


;;---------------------------------------
;;(load-file "~/Zmacs/bridge/grpc-tramp.el")
;;(require 'grpc-tramp)
(setq tramp-connection-timeout 10)

;; -------------- Copilot --------------
(use-package copilot
  :straight (:host github :repo "zerolfx/copilot.el" :files ("dist" "*.el"))
  :ensure t)

;;(add-hook 'prog-mode-hook 'copilot-mode)
(defun my/copilot-tab ()
  (interactive)
  (or (copilot-accept-completion)
      (indent-for-tab-command)))

(with-eval-after-load 'copilot
  (define-key copilot-mode-map (kbd "C-<tab>") #'my/copilot-tab))
;; -------------- Copilot --------------

;;(add-to-list 'load-path "~/Code/GPT/")
;;(require 'myu

;;------------------- Common Lisp -----------------
;;(load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
;;(setq inferior-lisp-program "/usr/local/bin/sbcl")
;;(load "~/quicklisp/setup.lisp")
;;(use-package slime
;;  :ensure t)
;;------------------- Common Lisp -----------------
;;------------------- Bazel-----------------
(defcustom buildifier-bin "buildifier"
  "Location of the buildifier binary."
  :type 'string
  :group 'buildifier)

(defcustom buildifier-path-regex
  "BUILD\\|WORKSPACE\\|BAZEL"
  "Regular expression describing base paths that need buildifier."
  :type 'string
  :group 'buildifier)

(defun buildifier ()
  "Run buildifier on current buffer."
  (interactive)
  (when (and (string-match buildifier-path-regex
                           (file-name-nondirectory
                            (buffer-file-name)))
             (executable-find buildifier-bin))
    (let ((p (point))
          (tmp (make-temp-file "buildifier")))
      (write-region nil nil tmp)
      (let ((result (with-temp-buffer
                      (cons (call-process buildifier-bin tmp t nil)
                            (buffer-string)))))
        (if (= (car result) 0)
            (save-excursion
              (erase-buffer)
              (insert (cdr result)))
          (warn "%s failed: %s" buildifier-bin (cdr result)))
        (goto-char p)
        (delete-file tmp nil)))))

(add-hook 'before-save-hook 'buildifier)
;;------------------- Bazel-----------------
