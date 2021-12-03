(defvar halo--gc-cons-threshold gc-cons-threshold)
(defvar halo--gc-cons-percentage gc-cons-percentage)
(defvar halo--file-name-handler-alist file-name-handler-alist)

(setq-default gc-cons-threshold 402653184
              gc-cons-percentage 0.6
              file-name-handler-alist nil)

(defun halo/restore-defaults-after-init ()
  "Restore default values after initialization."
  (setq-default gc-cons-threshold halo--gc-cons-threshold
                gc-cons-percentage halo--gc-cons-percentage
                file-name-handler-alist halo--file-name-handler-alist))

(add-hook 'after-init-hook #'halo/restore-defaults-after-init)

(setq read-process-output-max (* 1024 1024 4) ; 4mb
      inhibit-compacting-font-caches t
      message-log-max 16384)
