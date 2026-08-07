# TLS test fixture

`localhost-cert.pem` and `localhost-key.pem` are a self-signed certificate and
matching private key used only by `tests/fake_ha.py`. The certificate is valid
only for `localhost`, `127.0.0.1`, and `::1`.

The private key is intentionally public test data. Do not deploy it, trust it,
or reuse it outside this test suite.
