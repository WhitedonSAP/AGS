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

(define-module (sss ssh)
  #:declarative? #t
  #:use-module (gnu)
  #:use-module (gnu home services ssh)
  #:export (ssh-capability))

(define joe-ssh-hosts
  (list (openssh-host (name "personal.github.com")
                      (user "git")
                      (host-name "github.com")
                      (identity-file "~/.ssh/id_rsa"))
        (openssh-host (name "gitlab.com")
                      (user "git")
                      (host-name "gitlab.com")
                      (identity-file "~/.ssh/id_rsa"))
        (openssh-host (name "codeberg.org")
                      (user "git")
                      (host-name "codeberg.org")
                      (identity-file "~/.ssh/id_rsa"))))

;; Define a SSH configuration service for a SSS user
(define* (ssh-capability #:key (hosts joe-ssh-hosts)
                         (authorized-keys '()))
  (service home-openssh-service-type
           (home-openssh-configuration (hosts hosts)
                                       (authorized-keys authorized-keys))))
