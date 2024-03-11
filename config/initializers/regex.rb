RE_PHONE   = /\d\d\d-\d\d\d-\d\d\d\d/ unless defined?(RE_PHONE)
RE_EMAIL   = /^([0-9a-zA-Z]+[-._+&amp;])*[0-9a-zA-Z]+@([-0-9a-zA-Z]+[.])+[a-zA-Z]{2,6}$/ unless defined?(RE_EMAIL)
RE_NO_HTML = /<\/?[^>]*>/ unless defined?(RE_NO_HTML)
RE_IPHONE  = /Apple.*Mobile.*Safari/ unless defined?(RE_IPHONE)