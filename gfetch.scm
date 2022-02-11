;;; gfetch.scm --- An info fetch tool written in Guile
;;; Copyright (c) 2022, DEADBLACKCLOVER. This file is
;;; licensed under the GNU General Public License version 3 or later. See
;;; the LICENSE file.

;;; Code:
(use-modules (ice-9 rdelim) 
             (ice-9 regex) 
             (ice-9 textual-ports))

(define (get-line-n lines num) 
  (let ((line "") 
        (count 1)) 
    (while (not (eq? count (+ num 1))) 
           (set! line (get-line lines)) 
           (set! count (+ count 1))) line))

(define (get-hostname) 
  (call-with-input-file "/etc/hostname" (lambda (port) 
                                          (get-line-n port 1))))

(define (get-cpu) 
  (call-with-input-file "/proc/cpuinfo" (lambda (port) 
                                          (car (cdr (string-split (get-line-n port 5) #\:))))))

(define (get-distro) 
  (call-with-input-file "/etc/os-release" (lambda (port) 
                                            (car (cdr (string-split (get-line-n port 3) #\=))))))

(define (get-kernel) 
  (call-with-input-file "/proc/sys/kernel/osrelease" (lambda (port) 
                                                       (get-line-n port 1))))

(define (get-de) 
  (string-append (getenv "XDG_CURRENT_DESKTOP") "/" (getenv "DESKTOP_SESSION")))

(define (get-shell) 
  (match:substring (string-match "([^/]+)?$" (getenv "SHELL"))))

(display "gFetch")
(newline)
(display (string-append "HOSTNAME: " (get-hostname)))
(newline)
(display (string-append "USER: " (getenv "USER")))
(newline)
(display (string-append "CPU:" (get-cpu)))
(newline)
(display (string-append "DISTRO: " (get-distro)))
(newline)
(display (string-append "KERNEL: " (get-kernel)))
(newline)
(display (string-append "DE: " (get-de)))
(newline)
(display (string-append "SHELL: " (get-shell)))
(newline)
;;; gfetch.scm ends here
