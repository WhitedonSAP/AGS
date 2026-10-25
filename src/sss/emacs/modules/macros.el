;;; macros.el --- Macros for Emacs -*- lexical-binding: t -*-

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

;;; Commentary:

;; Macros for Emacs - tips: you can use `elmacro' package, by activating `elmacro-mode'
;; and after having recorded a macro with the F3 - do - F4 dance
;; use `elmacro-show-last-macro'

;;; Code:

(defun kbd-scheme-hygguile-abstraction ()
  "Replace the active region (CSS classes) with a hygguile class set."
  (interactive)
  (if (use-region-p)
      (let ((content (buffer-substring-no-properties (region-beginning) (region-end))))
        (delete-region (region-beginning) (region-end))
        (insert (format ",(mk-class '(%s))" content)))
    (user-error "Select a text region before running the macro")))

(defun kbd-scheme-make-parameter ()
  "Replace the active region with (make-parameter <val>)."
  (interactive)
  (if (use-region-p)
      (let ((content (buffer-substring-no-properties (region-beginning) (region-end))))
        (delete-region (region-beginning) (region-end))
        (insert (format "(make-parameter %s)" content)))
    (user-error "Select a text region before running the macro")))


(provide 'sss/macros)

;;; macros.el ends here
