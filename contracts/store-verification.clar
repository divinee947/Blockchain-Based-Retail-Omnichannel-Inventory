;; Product Registration Contract
;; Records merchandise details

(define-data-var admin principal tx-sender)

;; Product data map
(define-map products
  { product-id: uint }
  {
    name: (string-utf8 100),
    description: (string-utf8 500),
    category: (string-utf8 50),
    manufacturer: (string-utf8 100),
    created-at: uint,
    active: bool
  }
)

;; Product SKUs
(define-map product-skus
  { product-id: uint, sku: (string-utf8 50) }
  {
    price: uint,
    size: (string-utf8 20),
    color: (string-utf8 20)
  }
)

;; Get admin
(define-read-only (get-admin)
  (var-get admin)
)

;; Check if caller is admin
(define-private (is-admin)
  (is-eq tx-sender (var-get admin))
)

;; Register a new product
(define-public (register-product
  (product-id uint)
  (name (string-utf8 100))
  (description (string-utf8 500))
  (category (string-utf8 50))
  (manufacturer (string-utf8 100)))
  (begin
    (asserts! (is-admin) (err u403)) ;; Not authorized
    (asserts! (is-none (map-get? products { product-id: product-id })) (err u1)) ;; Product ID already exists
    (map-set products
      { product-id: product-id }
      {
        name: name,
        description: description,
        category: category,
        manufacturer: manufacturer,
        created-at: block-height,
        active: true
      }
    )
    (ok true)
  )
)

;; Add a SKU to a product
(define-public (add-product-sku
  (product-id uint)
  (sku (string-utf8 50))
  (price uint)
  (size (string-utf8 20))
  (color (string-utf8 20)))
  (begin
    (asserts! (is-admin) (err u403)) ;; Not authorized
    (asserts! (is-some (map-get? products { product-id: product-id })) (err u404)) ;; Product not found
    (asserts! (is-none (map-get? product-skus { product-id: product-id, sku: sku })) (err u2)) ;; SKU already exists
    (map-set product-skus
      { product-id: product-id, sku: sku }
      {
        price: price,
        size: size,
        color: color
      }
    )
    (ok true)
  )
)

;; Deactivate a product
(define-public (deactivate-product (product-id uint))
  (begin
    (asserts! (is-admin) (err u403)) ;; Not authorized
    (asserts! (is-some (map-get? products { product-id: product-id })) (err u404)) ;; Product not found
    (map-set products
      { product-id: product-id }
      (merge (unwrap-panic (map-get? products { product-id: product-id }))
             { active: false })
    )
    (ok true)
  )
)

;; Get product details
(define-read-only (get-product (product-id uint))
  (map-get? products { product-id: product-id })
)

;; Get product SKU details
(define-read-only (get-product-sku (product-id uint) (sku (string-utf8 50)))
  (map-get? product-skus { product-id: product-id, sku: sku })
)
