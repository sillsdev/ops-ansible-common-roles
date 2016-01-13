# ssl_config

This role implements an SSL certificate management system.  A system where the server private key never leaves the server.

A CSR (certificate signing request) can be generated on the server `state: request`, and is downloaded to the Ansible control machine.  This CSR is then signed by some signing authority or it can be self signed `state: selfsign`.  The signed certificate can then be uploaded to the server `state: certificate` for use by other roles.

This role works well with this [apache role](https://github.com/kosssi/ansible-role-apache).

## Variables (and defaults)
````
ssl_path: /root/csr
ssl_certificate_local_path: site_files/certificates

ssl_items:
  - name: test
    state: request
    request:
        country_code: "NZ"
        state: "Taranaki"
        locality: "New Plymouth"
        organization: "saygoweb"
        organization_unit: ""
        common_name: "saygoweb.com"
        alt_names:
          - key: DNS.1
            value: "www.saygoweb.com"
          - key: DNS.2
            value: "saygoweb.com"
  - name: test
    state: certificate
  - name: testsign
    state: selfsign
    request:
        country_code: "NZ"
        state: "Taranaki"
        locality: "New Plymouth"
        organization: "saygoweb"
        organization_unit: ""
        common_name: "default.local"
        alt_names:
          - key: DNS.1
            value: "www.default.local"
          - key: DNS.2
            value: "default.local"
    sign:
````

