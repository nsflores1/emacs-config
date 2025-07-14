;;; early-init.el --- In the beginning there was early-init -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(message "[init.el] GNU Emacs is now starting")

;; disable slow features, but restore them after init
;; todo: see if a package doesn't handle this better,
;; this is a very clunky solution
(let ((init-file-name-handler-alist file-name-handler-alist))
  (setq gc-cons-threshold most-positive-fixnum
        file-name-handler-alist nil)
  (add-hook 'emacs-startup-hook
            (lambda () (setq gc-cons-threshold (* 128 1024 1024)
                        file-name-handler-alist init-file-name-handler-alist))))

;; tune performance permanently
(setq jit-lock-defer-time 0
      read-process-output-max (* 4 1024 1024)
      process-adaptive-read-buffering nil)

;; Turn off packages
(setq package-enable-at-startup nil)

;; always save all our output for debugging sake
(setq message-log-max t)

;; don't check mtime on elisp bytecode
(setq load-prefer-newer noninteractive)

;; enable high levels of recursion
;; not too high or we'll stack overflow!
(setq max-lisp-eval-depth 2000)

;; simpler way of seeing our OS
(defconst *is-a-mac* (eq system-type 'darwin)
  "System is running macOS.")
(defconst *is-a-windows* (eq system-type 'windows-nt)
  "System is running Microsoft Windows.")
(defconst *is-a-linux* (eq system-type 'gnu/linux)
  "System is running Linux.")
(defconst *is-a-haiku* (eq system-type 'haiku)
  "System is running Haiku.")
(defconst *is-a-unix* (or (eq system-type 'aix)
                          (eq system-type 'berkeley-unix)
                          (eq system-type 'cygwin)
                          (eq system-type 'gnu))
  "System is running some non-Linux Unix.")

;; suppress annoying warnings
(setq byte-compile-warnings '(not obsolete))
(setq warning-suppress-log-types '((comp) (bytecomp)))
(setq native-comp-async-report-warnings-errors 'silent)

;; silence stupid startup message
(setq inhibit-startup-echo-area-message (user-login-name))

;; editing windows is expensive, but there's no frames yet,
;; so now is the ideal time to edit our frame.
(setq window-resize-pixelwise t
      frame-resize-pixelwise t
      frame-title-format '((:eval (if (buffer-file-name)
				      (abbreviate-file-name (buffer-file-name))
				    "%b"))))

;; make the cursor easier to see,
;; make the thing nice and transparent.
(setq default-frame-alist '((vertical-scroll-bars . nil)
                            (horizontal-scroll-bars . )))

(message "[init.el] graphical frames edited, if they exist")
;; early-init.el ends here

