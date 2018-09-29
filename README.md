Certificates
============
This repository helps creating SSL and CA certificates for development purposes.


Creating a CA Key and Certificate
---------------------------------

    make ca-cert.pem
    
This will create `ca-key.pem` and `ca-cert.pem`.
Add this to your Chrome's accepted certificate authorities.


Creating an SSL certificate
---------------------------

    make foo-cert.pem
    
This will create `foo.csr`, `foo-key.pem` and `foo-cert.pem`.
Use the latter to configure your web server.
