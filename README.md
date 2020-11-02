# eversigncfc

A CFML wrapper for the [Eversign API](https://eversign.com/api/documentation). Use it to create, send, and track legally binding e-signature documents.

*Feel free to use the issue tracker to report bugs or suggest improvements!*

## Acknowledgements

This project borrows heavily from the API frameworks built by [jcberquist](https://github.com/jcberquist). Thanks to John for all the inspiration!

## Table of Contents

- [Quick Start](#quick-start)
- [`eversigncfc` Reference Manual](#reference-manual)

### Quick Start

The following is a quick example of sending one-off documents for signatures with Eversign, using the `create_document` helper component.

```cfc
eversign = new path.to.eversigncfc.eversign( access_key = 'xxx', business_id = xxx );

document = new path.to.eversigncfc.helpers.create_document();

document.sandbox()
  .title( "Testing a document!" )
  .message( "No reason to sign this." )
  .addFile( {
    "name" = "Example",
    "file_url" = "https://always-public-testing.s3.amazonaws.com/example.pdf"
  } )
  .addSigner( {
    "id" = 1,
    "name" = "Jo McSign",
    "email" = "hello@notanexample.xyz"
  } );
```

### Reference Manual

#### `listBusinesses()`

Briefly explain what it does.

#### `createDocument( required type argument )`

---
