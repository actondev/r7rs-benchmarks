(with-exception-handler (lambda args
			  (display "exception: ")
			  (display args)
			  (newline)
			  (flush-output-port (current-output-port))
			  (exit 1))
			main)
