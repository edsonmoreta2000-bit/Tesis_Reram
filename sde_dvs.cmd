(sde:clear)

; ================================================================
; ReRAM HfO2 - geometria 2D reproducible
; Stack, de arriba hacia abajo (um):
;   TiN.top       0.000 - 0.030  (30 nm)
;   HfO2         0.030 - 0.035 (5 nm)
;   Hafnium      0.035 - 0.045 (10 nm)
;   TiN.bottom    0.045 - 0.075 (30 nm)
;
; SwitchGap.HfO2 es una subdivision de 1 nm
; junto al reservorio de Hafnium.
; ================================================================

(define Ymin -0.0425)
(define Ymax  0.0425)
(define YwL  -0.0025)
(define YwR   0.0025)

(define X0    0.000)
(define X1    0.030)
(define Xgap  0.034)
(define X2    0.035)
(define X3    0.045)
(define X4    0.075)

; --------------------------- TiN superior ------------------------

(sdegeo:create-rectangle
  (position X0 Ymin 0.0)
  (position X1 Ymax 0.0)
  "TiN"
  "TiN.top"
)

; --------------------------- HfO2 activo --------------------------

(sdegeo:create-rectangle
  (position X1 Ymin 0.0)
  (position X2 YwL 0.0)
  "HfO2"
  "HfO2.left"
)

(sdegeo:create-rectangle
  (position X1 YwL 0.0)
  (position Xgap YwR 0.0)
  "HfO2"
  "Weak.HfO2"
)

(sdegeo:create-rectangle
  (position Xgap YwL 0.0)
  (position X2 YwR 0.0)
  "HfO2"
  "SwitchGap.HfO2"
)

(sdegeo:create-rectangle
  (position X1 YwR 0.0)
  (position X2 Ymax 0.0)
  "HfO2"
  "HfO2.right"
)

; --------------------------- Reservorio Hf ------------------------

(sdegeo:create-rectangle
  (position X2 Ymin 0.0)
  (position X3 Ymax 0.0)
  "Hafnium"
  "Hf.reservoir"
)

; --------------------------- TiN inferior -------------------------

(sdegeo:create-rectangle
  (position X3 Ymin 0.0)
  (position X4 Ymax 0.0)
  "TiN"
  "TiN.bottom"
)

; --------------------------- Contactos ----------------------------

(sdegeo:define-contact-set
  "top"
  4.0
  (color:rgb 1 0 0)
  "##"
)

(sdegeo:define-contact-set
  "bottom"
  4.0
  (color:rgb 0 0 1)
  "##"
)

(sdegeo:set-contact
  (find-edge-id (position X0 0.0 0.0))
  "top"
)

(sdegeo:set-contact
  (find-edge-id (position X4 0.0 0.0))
  "bottom"
)

(sdeio:save-tdr-bnd
  (get-body-list)
  "@tdrboundary@"
)