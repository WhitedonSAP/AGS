;;; SSS - Supreme Sexp System

;; Copyright © Josep Bigorra <jjbigorra@gmail.com>

;; sss is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; sss is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with sss.  If not, see <https://www.gnu.org/licenses/>.

(use-modules (ice-9 popen)
             (ice-9 textual-ports)
             (sss prelude))

(setup-i18n)

(define clone-repos
  (make-parameter '(byggsteg AGS
                             Gentoo-Linux-Installer
                             Hyprland-dots
                             LFS-Auto
                             LFS-Auto-Repo
                             Niri-dots
                             OverDeepOS-Toolkit)))

(define destination-folder
  (make-parameter "$HOME/hacking"))

(define remote-url
  (make-parameter "git@github.com:WhitedonSAP"))

(log-info (G_ "Cloning user's Git repositories"))

(for-each (lambda (x)
            (syscall (format #f
                             (string-join '("[ -d ~a/~a ] || "
                                            "git clone ~a/~a.git ~a/~a"))
                             (destination-folder)
                             x
                             (remote-url)
                             x
                             (destination-folder)
                             x)))
          (clone-repos))
