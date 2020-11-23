# eversigncfc

A CFML wrapper for the [Eversign API](https://eversign.com/api/documentation). Use it to create, send, and track legally binding e-signature documents.

*Feel free to use the issue tracker to report bugs or suggest improvements!*

## Acknowledgements

This project borrows heavily from the API frameworks built by [jcberquist](https://github.com/jcberquist). Thanks to John for all the inspiration!

## Table of Contents

- [Quick Start](#quick-start)
- [Setup and Authentication](#setup-and-authentication)
- [`eversigncfc` Reference Manual](#reference-manual)
- [Reference Manual for `helpers.create_document`](#reference-manual-for-helperscreate_document)
- [Reference Manual for `helpers.use_template`](#reference-manual-for-helpersuse_template)

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

writeDump( var='#eversign.createDocument( document )#' );
```

### Setup and Authentication

To get started with the Eversign API, you'll need an [Access Key and Business ID](https://eversign.com/api/documentation/intro#api-access-key).

Once you have these, you can provide them to this wrapper manually when creating the component, as in the Quick Start example above, or via environment variables named `EVERSIGN_ACCESS_KEY` and `EVERSIGN_BUSINESS_ID`, which will get picked up automatically. This latter approach is generally preferable, as it keeps hardcoded credentials out of your codebase.

### Reference Manual

A full reference manual for all public methods in `eversign.cfc`  can be found in the `docs` directory, [here](https://github.com/mjclemente/eversigncfc/blob/main/docs/eversign.md).

### Reference Manual for `helpers.create_document`

The reference manual for all public methods in `helpers/create_document.cfc` can be found in the `docs` directory, [in `create_document.md`](https://github.com/mjclemente/eversigncfc/blob/main/docs/create_document.md).

Unless indicated, all methods are chainable. To better understand how these work, you'll want to read the [documentation regarding the Create Document endpoint](https://eversign.com/api/documentation/methods#create-document).

### Reference Manual for `helpers.use_template`

The reference manual for all public methods in `helpers/use_template.cfc` can be found in the `docs` directory, [in `use_template.md`](https://github.com/mjclemente/eversigncfc/blob/main/docs/use_template.md).

Unless indicated, all methods are chainable. To better understand how these work, you'll want to read the [documentation regarding the Use Template endpoint](https://eversign.com/api/documentation/methods#use-template).

---
