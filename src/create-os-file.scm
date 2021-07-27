(use-modules (ice-9 rdelim))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Name: get-os-info
;;
;; Description: Calls the uname function whih provides the
;;              distribution information to be saved in the
;;              release file.
;;
;;              The fields generated are only the necessary.
;;              Feel free to add more if you are not lazy.
;;
;; Input: -
;;
;; Output: A list of lists containing key-value pairs with
;;         the field nam and its respective value.
;;
;; Notes: More information can be found in the following URL
;;
;;        https://www.linux.org/docs/man5/os-release.html
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (get-os-info)
  (let ((uname-list (uname)))
    (list
     (list "NAME=" "GNU Guix")
     (list "ID=" (vector-ref uname-list 1))
     (list "PRETTY-NAME=" "GNU Guix System")
     (list "VERSION=" (vector-ref uname-list 2))
     (list "HOME_URL=" "https://guix.gnu.org")
     (list "SUPPORT_URL=" "https://guix.gnu.org/help/")
     (list "DEFAULT_HOSTNAME=" "guix")
     (list "SYSEXT_LEVEL=" "1"))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Name: write-os-rel-file
;;
;; Description: Creates the os-release file in the same directory
;;              the function will be called.
;;
;; Input: A list of lists containing the key-value pairs to be
;;        written in the os-release file.
;;
;; Output: The OS-release file.
;;
;; Notes: The file will need to be copied to /etc and /usr/lib
;;        (or copied in one location and symlinked in the other.
;;
;;        In GUIX the package can be installed without root rights
;;        so trying to manage all of this complexity in the script
;;        is excessive.
;;
;;        We'll do something in the package script itself or copy
;;        the file yourself :-)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (write-os-rel-file distro-info)
  (let ((port (open-output-file "os-release")))
    (map (lambda (sublist) (write-line (string-concatenate sublist) port)) distro-info)
    (close-port port)))


(define (move-release-file)
  (system "sudo mv os-release /etc"))



