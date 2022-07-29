#lang racket
(require web-server/servlet
         web-server/servlet-env
         web-server/http/json)
(require (for-syntax racket/struct-info))
(require json)
(require db)
;;(require uuid)
;;(require "cake.rkt")

;;(print-cake (random 30))

(define request-counter 0)

(struct telegram-message (id text is-inline))
(define new-message (telegram-message 1 "foobar" #t))
(display new-message)



(define (start req)
  (display (+ 1 request-counter))
  ;;(display (request-method req))


  ;;(for ([i (in-vector req)])
  ;;(displayln i))
  ;;(display req)
  (define raw-json (request-post-data/raw req))
  (display raw-json)
  (display (hash-ref (bytes->jsexpr raw-json) 'ololo))

;;(display (extract-struct-info (syntax-local-value #'foo)))


;;(struct telegram-message (id text is-inline))
;;(define new-message (telegram-message 1 "foobar" #t))
;;(display new-message)

  (define file-name (string-append "/Users/ihorkpl/Code/racket/new" "-random-str-" ".txt"))

  
  (write-to-file raw-json file-name #:mode 'binary #:exists 'append)
  (define (data) (hash 'status 1 'error 400 'version 2.1))
  (response/jsexpr (data)))

(serve/servlet start)