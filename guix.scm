;; robot-repo-bot - Guix Package Definition
;; Run: guix shell -D -f guix.scm

(use-modules (guix packages)
             (guix gexp)
             (guix git-download)
             (guix build-system gnu)
             ((guix licenses) #:prefix license:)
             (gnu packages base))

(define-public robot_repo_bot
  (package
    (name "robot-repo-bot")
    (version "0.1.0")
    (source (local-file "." "robot-repo-bot-checkout"
                        #:recursive? #t
                        #:select? (git-predicate ".")))
    (build-system gnu-build-system)
    (synopsis "Guix channel/infrastructure")
    (description "Guix channel/infrastructure - part of the RSR ecosystem.")
    (home-page "https://github.com/hyperpolymath/robot-repo-bot")
    (license license:agpl3+)))

;; Return package for guix shell
robot_repo_bot
