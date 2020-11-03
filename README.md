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

#### `cancelDocument`

Cancel document *[docs](https://eversign.com/api/documentation/methods#cancel-document)*

#### `createDocument`

Create a document *[docs](https://eversign.com/api/documentation/methods#create-document)*

#### `createTemplate`

//TODO Add create_template helper *[docs](https://eversign.com/api/documentation/methods#create-template)*

#### `deleteDocument`

Delete document. Please note that only cancelled documents and draft documents or templates can be deleted. *[docs](https://eversign.com/api/documentation/methods#delete-document)*

#### `deleteTemplate`

Delete template using the document/template hash *[docs](https://eversign.com/api/documentation/methods#delete-document)*

#### `downloadAuditTrail`

Convenience method for downloading the final document's audit trail.

#### `downloadFinal`

Download the final, signed version of the document *[docs](https://eversign.com/api/documentation/methods#download-final-pdf)*

#### `downloadOriginal`

Download the original PDF file *[docs](https://eversign.com/api/documentation/methods#download-original-pdf)*

#### `getDocument`

Retrieve a document (or template) by the document/template hash *[docs](https://eversign.com/api/documentation/methods#get-document-template)*

#### `getFinalDownloadUrl`

Convenience method for downloading the final document's download URL.

#### `getTemplate`

Retrieve a document (or template) by the document/template hash *[docs](https://eversign.com/api/documentation/methods#get-document-template)*

#### `listBusinesses`

A list of existing businesses on your eversign account *[docs](https://eversign.com/api/documentation/methods#list-businesses)*

#### `listDocuments`

List documents *[docs](https://eversign.com/api/documentation/methods#list-documents)*

#### `listTemplates`

List templates *[docs](https://eversign.com/api/documentation/methods#list-templates)*

#### `sendReminder`

Send reminder *[docs](https://eversign.com/api/documentation/methods#send-reminder)*

#### `useTemplate`

Use Template *[docs](https://eversign.com/api/documentation/methods#use-template)*

#### `validateEventHash`

Validates Eversign webhook events *[docs](https://eversign.com/api/documentation/webhooks#event-hashes)*

---
