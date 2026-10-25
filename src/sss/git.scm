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

(define-module (sss git)
  #:declarative? #t
  #:use-module (gnu)
  #:use-module (sss prelude)
  #:export (gitignore-global gitconfig-personal gitconfig
                             git-capability))

(define gitignore-global
  `("bloop" ".bloop"
    ".metals"
    ".stack-work"
    "target"
    "metals.sbt"
    ".direnv"
    "dist-newstyle"))

(define gitconfig-personal
  `((user (name . "WhitedonSAP")
          (email . "ayrtonarantes0987654321ayrt008@gmail.com"))
    (commit (gpgsign . "false"))))

(define gitconfig
  `((core (editor . "emacsclient")
          (excludesfile . "~/.gitignore-global"))
    (commit (gpgsign . "false"))
    (format (thread . "shallow"))
    (sendemail (thread . "no"))
    (pull (rebase . "false"))
    ("includeIf \"gitdir:~/hacking/\"" ("  path" . "~/.gitconfig-personal"))
    ("includeIf \"gitdir:~/fork/\"" ("  path" . "~/.gitconfig-personal"))
    ("includeIf \"gitdir:~/scratch/\"" ("  path" . "~/.gitconfig-personal"))))

(define* (git-capability #:key (gitconfig gitconfig)
                         (gitconfig-personal gitconfig-personal)
                         (gitignore-global gitignore-global))
  `(;; Global Git configuration
    (".gitconfig" ,(plain-file "gitconfig.ini"
                               (mk-rec-kv-conf-lines gitconfig
                                                     #:template
                                                     spaced-equal-conf-pair)))
    ;; Personal Git configuration
    (".gitconfig-personal" ,(plain-file "gitconfig-personal.ini"
                                        (mk-rec-kv-conf-lines
                                         gitconfig-personal
                                         #:template spaced-equal-conf-pair)))
    ;; Global Git ignore
    (".gitignore-global" ,(plain-file "gitignore-global"
                                      (mk-lines gitignore-global)))))
