;; CONTACT.scm - Canonical contact information for all hyperpolymath repos
;; SPDX-License-Identifier: AGPL-3.0-or-later

(contact
  (canonical-email "jonathan.jewell@open.ac.uk")
  (security-contact "jonathan.jewell@open.ac.uk")
  
  (policy
    "All hyperpolymath repositories MUST use the canonical contact email."
    "Do NOT use placeholder emails (@example.com, @localhost, etc.)"
    "This is enforced by CI/CD secret scanning.")
  
  (enforcement
    (workflow "secret-scanner.yml")
    (pre-commit "pre-commit-secrets")))
