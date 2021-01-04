;; File location on Windows c:/Users/<username>/AppData/Roaming/
;; Clone .emacs.d from github to c:/Users/<username>/AppData/Roaming
;; on Windows - create a symbolic link using the below command (on a Admin mode cmd shell)
;;     cd c:/Users/<username>/AppData/Roaming
;;     mklink .emacs .emacs.d/.emacs

(add-to-list 'load-path "~/.emacs.d/lisp/")
(let ((default-directory  "~/.emacs.d/elpa/"))
  (normal-top-level-add-subdirs-to-load-path))


(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(require 'typescript-mode)
(require 'uniquify)
(require 'php-mode)
(require 'web-mode)
(require 'darkroom)

(setq backup-directory-alist '(("." . "~/.emacs-saves/")))
(desktop-save-mode 1)
(setq desktop-auto-save-timeout 120)

(defun as-change-file()
  (interactive)
  (delete-trailing-whitespace)
  (untabify (point-min) (point-max))
  (setq buffer-file-coding-system 'iso-latin-1-unix))

(add-hook 'before-save-hook 'as-change-file)

(defun as-indent-file()
  (interactive)
  (indent-region 0 (buffer-size)))

(global-set-key (kbd "C-c f f") 'as-indent-file)

(autoload 'php-mode "php-mode" "Major mode for editing PHP code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.twig\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))
