;;; gfetch.scm --- An info fetch tool written in Guile
;;; Copyright (c) 2022, DEADBLACKCLOVER. This file is
;;; licensed under the GNU General Public License version 3 or later. See
;;; the LICENSE file.

;;; Code:
(use-modules (ice-9 rdelim) 
             (ice-9 textual-ports))

(define (get-line-n lines num) 
  (let ((line "") 
        (count 1)) 
    (while (not (eq? count (+ num 1))) 
           (set! line (get-line lines)) 
           (set! count (+ count 1))) line))

(define (get-cpu) 
  (call-with-input-file "/proc/cpuinfo" (lambda (port) 
                                          (car (cdr (string-split (get-line-n port 5) #\:))))))

(display "gFetch")
(newline)
(display (string-append "CPU:" (get-cpu)))
;;; gfetch.scm ends here
