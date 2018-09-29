# Generate CA private key
ca-key.pem:
	openssl genrsa -out $@ 4096

# Generate CA certificate
ca-cert.pem: ca-key.pem
	echo "Creating Root Certificate '$@'"
	openssl req -x509 \
		-config conf/ca.cnf \
		-new -nodes -extensions v3_ca -days 3654 \
		-key $< \
		-sha512 \
		-days 3653 \
		-out $@
	openssl x509 -text \
		-noout \
		-in $@

# Generate Certificate Signing Request
%.csr:
	echo "Creating Certificate Signing Request '$@'"
	openssl req -new \
		-newkey rsa -nodes -keyout $(@:%.csr=%-key.pem) \
		-config conf/ssl.cnf \
		-out $@
	openssl req -text \
		-noout \
		-verify \
		-in $@

# Generate SSL certificate
%-cert.pem: %.csr ca-cert.pem ca-key.pem
	openssl x509 -req \
		-in $< \
		-CA $(word 2,$^) -CAkey $(word 3,$^) -CAcreateserial \
		-extensions v3_req \
		-extfile conf/ssl.cnf \
		-days 3653 \
		-out $@
	openssl x509 -text \
		-noout \
		-in $@
