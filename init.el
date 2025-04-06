;;; init.el --- And there was the Config, and it was good -*- lexical-binding: t -*-
;;; Commentary:
;;; The settings for literally everything is loaded here.
;;; Code:

(message "[init.el] parsing org config file")

;; early-init MUST be loaded and may not have been if Emacs
;; is a version older than 27.1
(when (version< emacs-version "27.1")
  (error "[init.el] Your Emacs is outdated; this config requires 27.1 or higher to run"))

;; set where our stuff is
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(setq custom-file (locate-user-emacs-file "custom.el"))

;; use newest byte code
(setq load-prefer-newer t)

;; now load everything
(require 'org)
(org-babel-load-file
 (expand-file-name "README.org"
		   user-emacs-directory))

(message "[init.el] done parsing org config file")

;; run emacsclient, but only on unix
(if (not (or *is-a-windows* *is-a-haiku*))
    (add-hook 'after-init-hook
	      (lambda ()
	        (require 'server)
	        (unless (server-running-p)
	          (server-start)))))

;; announce we are all good
(message "[init.el] Emacs has finished starting up, init.el processed")
;;; init.el ends here


