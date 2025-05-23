;; Store Verification Contract
;; Validates retail locations

(define-data-var admin principal tx-sender)

;; Store data map
(define-map stores
  { store-id: uint }
  {
    name: (string-utf8 100),
    location: (string-utf8 100),
    verified: bool,
    created-at: uint
  }
)

;; Store verification status
(define-map verification-status
  { store-id: uint }
  { verified: bool }
)

;; Get admin
(define-read-only (get-admin)
  (var-get admin)
)

;; Check if caller is admin
(define-private (is-admin)
  (is-eq tx-sender (var-get admin))
)

;; Register a new store
(define-public (register-store (store-id uint) (name (string-utf8 100)) (location (string-utf8 100)))
  (begin
    (asserts! (is-none (map-get? stores { store-id: store-id })) (err u1)) ;; Store ID already exists
    (map-set stores
      { store-id: store-id }
      {
        name: name,
        location: location,
        verified: false,
        created-at: block-height
      }
    )
    (map-set verification-status
      { store-id: store-id }
      { verified: false }
    )
    (ok true)
  )
)

;; Verify a store (admin only)
(define-public (verify-store (store-id uint))
  (begin
    (asserts! (is-admin) (err u403)) ;; Not authorized
    (asserts! (is-some (map-get? stores { store-id: store-id })) (err u404)) ;; Store not found
    (map-set verification-status
      { store-id: store-id }
      { verified: true }
    )
    (map-set stores
      { store-id: store-id }
      (merge (unwrap-panic (map-get? stores { store-id: store-id }))
             { verified: true })
    )
    (ok true)
  )
)

;; Check if a store is verified
(define-read-only (is-store-verified (store-id uint))
  (default-to false
    (get verified (map-get? stores { store-id: store-id })))
)

;; Get store details
(define-read-only (get-store (store-id uint))
  (map-get? stores { store-id: store-id })
)
