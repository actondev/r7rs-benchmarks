(define (main)
  (display (this-scheme-implementation-name))
  (flush-output-port (current-output-port)))
