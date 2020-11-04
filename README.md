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

#### `cancelDocument( required string document_hash )`

Cancel document. *[Endpoint docs](https://eversign.com/api/documentation/methods#cancel-document)*

#### `createDocument( required any create_document )`

Create a document. The parameter `create_document` expects an instance of the `helpers.create_document` component, but you can construct the struct/json yourself if you prefer. *[Endpoint docs](https://eversign.com/api/documentation/methods#create-document)*

#### `createTemplate( required any template )`

Create a document template. *[Endpoint docs](https://eversign.com/api/documentation/methods#create-template)*

#### `deleteDocument( required string document_hash )`

Delete document. Please note that only cancelled documents and draft documents or templates can be deleted. *[Endpoint docs](https://eversign.com/api/documentation/methods#delete-document)*

#### `deleteTemplate( required string document_hash )`

Delete template using the document/template hash. *[Endpoint docs](https://eversign.com/api/documentation/methods#delete-document)*

#### `downloadAuditTrail( required string document_hash )`

Convenience method for downloading the final document's audit trail.

#### `downloadFinal( required string document_hash, boolean audit_trail=false , any document_id, boolean url_only=false )`

Download the final, signed version of the document. *[Endpoint docs](https://eversign.com/api/documentation/methods#download-final-pdf)*

#### `downloadOriginal( required string document_hash )`

Download the original PDF file. *[Endpoint docs](https://eversign.com/api/documentation/methods#download-original-pdf)*

#### `getDocument( required string document_hash )`

Retrieve a document (or template) by the document/template hash. *[Endpoint docs](https://eversign.com/api/documentation/methods#get-document-template)*

#### `getFinalDownloadUrl( required string document_hash, boolean audit_trail=false )`

Convenience method for downloading the final document's download URL.

#### `getTemplate( required string document_hash )`

Retrieve a document (or template) by the document/template hash. *[Endpoint docs](https://eversign.com/api/documentation/methods#get-document-template)*

#### `listBusinesses()`

A list of existing businesses on your eversign account. *[Endpoint docs](https://eversign.com/api/documentation/methods#list-businesses)*

#### `listDocuments( string type="all" )`

List documents. The parameter `type` options are all, my_action_required, waiting_for_others, completed, drafts, cancelled. *[Endpoint docs](https://eversign.com/api/documentation/methods#list-documents)*

#### `listTemplates( string type="templates" )`

List templates. The parameter `type` options are templates, templates_archived, template_drafts. *[Endpoint docs](https://eversign.com/api/documentation/methods#list-templates)*

#### `sendReminder( required string document_hash, required numeric signer_id )`

Send reminder. *[Endpoint docs](https://eversign.com/api/documentation/methods#send-reminder)*

#### `useTemplate( required any use_template )`

Use Template. The parameter `use_template` expects an instance of the `helpers.use_template` component, but you can construct the struct/json yourself if you prefer. *[Endpoint docs](https://eversign.com/api/documentation/methods#use-template)*

#### `validateEventHash( required string event_hash, required string event_time, required string event_type )`

Validates Eversign webhook events. *[Endpoint docs](https://eversign.com/api/documentation/webhooks#event-hashes)*

### Reference Manual for `helpers.create_document`

This section documents every public method in the `helpers/create_document.cfc` file. Unless indicated, all methods are chainable. To better understand how these work, you'll want to read the [documentation regarding the Create Document endpoint](https://eversign.com/api/documentation/methods#create-document).

#### `addField( required struct field )`

Appends a single field to the fields array.

#### `addFile( required struct file )`

Appends a single file to the files array.

#### `addMeta( required any meta, any value )`

Appends a single key/value pair to the `meta` property. The parameter `meta` Facilitates two means of setting a `meta` property. You can pass in a struct with a key/value pair for the `meta` name and value. Alternatively, you can use this to pass in the name of the `meta` property, and provide the value as a second argument..

#### `addRecipient( required struct recipient )`

Appends a single recipient to the recipients array.

#### `addSigner( required struct signer )`

Appends a single signer to the signers array.

#### `build()`

Assembles the JSON to send to the API. Generally, you shouldn't need to call this directly.

#### `client( required string client_identifier )`

This parameter is used to specify an internal reference for your application, such as an identification string of the server or client making the API request.

#### `customrequesteremail( required string custom_requester_email )`

convenience method for setting the custom_requester_email.

#### `customrequestername( required string custom_requester_name )`

This parameter can be used to specify a custom requester name for this document. If used, all email communication related to this document and signing-related notifications will carry this name as the requester (sender) name.

#### `draft( boolean draft=true )`

Set to 1 in order to create the document as a draft. Calling this without an argument also creates it as a draft.

#### `embeddedsigning( required string embedded_signing_enabled )`

convenience method for setting the embedded_signing_enabled.

#### `embeddedsigningenabled( boolean embedded_signing_enabled=true )`

Set to 1 in order to enable Embedded Signing for this document. If enabled, this document can be signed within an iFrame embedded on your website and email authentication will be disabled. If called without a flag, it will enable embedded signing.

#### `expires( required date expires )`

This parameter is used to specify a custom expiration date for your document. The date entered will be automatically converted to a Unix Timestamp. If empty, the default document expiration period specified in your business settings will be used.

#### `field( required struct field )`

Convenience method for adding a field.

#### `fields( required any fields )`

An array with an object for each Merge Field of this template. The identifier and object are required. Best to read the docs here. Note that if fields already exist, they will be overwritten. The parameter `fields` Can be passed in as an array or a single field as a struct.

#### `file( required struct file )`

Convenience method for adding a file.

#### `files( required any files )`

An array with an object for each file of the document. Each object must contain a file name and either a URL, a reference to an existing file ID or a file via a base64 string. Best to read the docs here. Note that if files already exist, they will be overwritten. The parameter `files` Can be passed in as an array or a single file as a struct.

#### `flexibleSigning( boolean flexible_signing=true )`

Set to 1 in order to create this document without specifying fields. Signers will be able to place their own fields during signing. If called without a flag, it will enable flexible signing.

#### `message( required string message )`

This parameter is used in order to specify a document message.

#### `meta( required struct meta )`

Sets the `meta` property. If a `meta` property was previously set, this method overwrites it. The parameter `meta` An object containing key/value pairs of whatever you wish set in the `meta` property..

#### `recipient( required struct recipient )`

Convenience method for adding a recipient.

#### `recipients( required any recipients )`

An array with an object for each recipient (CC) role of your template. Each object must contain the role name, CC name and CC email address. Best to read the docs here. Note that if recipients already exist, they will be overwritten. The parameter `recipients` Can be passed in as an array or a single recipient as a struct.

#### `redirect( required string redirect )`

This parameter is used to specify a custom completion redirect URL. If empty, the default Post-Signature Completion URL specified in your eversign Business or the eversign signature completion page will be used.

#### `redirectdecline( required string redirect_decline )`

This parameter is used to specify a custom decline redirect URL. If empty, the default Post-Signature Decline URL specified in your eversign Business or the eversign signature declined page will be used.

#### `reminders( boolean reminders=true )`

Set to 1 in order to enable Auto Reminders for this document. Calling this without an argument also enable auto reminders.

#### `requestername( required string custom_requester_name )`

convenience method for setting the custom_requester_name.

#### `requireAllSigners( boolean require_all_signers=true )`

Set to 1 in order to require all signers to sign to complete this document. Calling this without an argument also require all signers.

#### `sandbox( boolean sandbox=true )`

Set to 1 in order to enable Sandbox Mode. Calling this without an argument also enables the sandbox.

#### `signer( required struct signer )`

Convenience method for adding a signer.

#### `signers( required any signers )`

An array with an object for each signer of the document. Each object must contain the role name, signer name and signer email address. At this point, an optional Signer PIN and message can be specified as well. Best to read the docs here. Note that if signers already exist, they will be overwritten. The parameter `signers` Can be passed in as an array or a single signer as a struct.

#### `title( required string title )`

This parameter is used in order to specify a document title.

#### `useHiddenTags( boolean use_hidden_tags=true )`

Set to 1 to parse hidden tags placed on your document. If called without a flag, it will parse hidden tags.

#### `userSignerOrder( any use_signer_order=true )`

Set to 1 in order to enable Signing Order for this document. Calling this without an argument also enables signing order.

### Reference Manual for `helpers.use_template`

This section documents every public method in the `helpers/use_template.cfc` file. Unless indicated, all methods are chainable. To better understand how these work, you'll want to read the [documentation regarding the Use Template endpoint](https://eversign.com/api/documentation/methods#use-template).

#### `addField( required struct field )`

Appends a single field to the fields array.

#### `addRecipient( required struct recipient )`

Appends a single recipient to the recipients array.

#### `addSigner( required struct signer )`

Appends a single signer to the signers array.

#### `build()`

Assembles the JSON to send to the API. Generally, you shouldn't need to call this directly.

#### `client( required string client_identifier )`

This parameter is used to specify an internal reference for your application, such as an identification string of the server or client making the API request.

#### `customrequesteremail( required string custom_requester_email )`

convenience method for setting the custom_requester_email.

#### `customrequestername( required string custom_requester_name )`

This parameter can be used to specify a custom requester name for this document. If used, all email communication related to this document and signing-related notifications will carry this name as the requester (sender) name.

#### `embeddedsigning( boolean embedded_signing_enabled=true )`

convenience method for setting the embedded_signing_enabled.

#### `embeddedsigningenabled( boolean embedded_signing_enabled=true )`

Set to 1 in order to enable Embedded Signing for this document. If enabled, this document can be signed within an iFrame embedded on your website and email authentication will be disabled. If called without a flag, it will enable embedded signing.

#### `expires( required date expires )`

This parameter is used to specify a custom expiration date for your document. The date entered will be automatically converted to a Unix Timestamp. If empty, the default document expiration period specified in your business settings will be used.

#### `field( required struct field )`

Convenience method for adding a field.

#### `fields( required any fields )`

An array with an object for each Merge Field of this template. The identifier and object are required. Best to read the docs here. Note that if fields already exist, they will be overwritten. The parameter `fields` Can be passed in as an array or a single field as a struct.

#### `message( required string message )`

This parameter is used in order to specify a document message.

#### `recipient( required struct recipient )`

Convenience method for adding a recipient.

#### `recipients( required any recipients )`

An array with an object for each recipient (CC) role of your template. Each object must contain the role name, CC name and CC email address. Best to read the docs here. Note that if recipients already exist, they will be overwritten. The parameter `recipients` Can be passed in as an array or a single recipient as a struct.

#### `redirect( required string redirect )`

This parameter is used to specify a custom completion redirect URL. If empty, the default Post-Signature Completion URL specified in your eversign Business or the eversign signature completion page will be used.

#### `redirectdecline( required string redirect_decline )`

This parameter is used to specify a custom decline redirect URL. If empty, the default Post-Signature Decline URL specified in your eversign Business or the eversign signature declined page will be used.

#### `requestername( required string custom_requester_name )`

convenience method for setting the custom_requester_name.

#### `sandbox( boolean sandbox=true )`

Set to 1 in order to enable Sandbox Mode. Calling this without an argument also enables the sandbox.

#### `signer( required struct signer )`

Convenience method for adding a signer.

#### `signers( required any signers )`

An array with an object for each signer of the document. Each object must contain the role name, signer name and signer email address. At this point, an optional Signer PIN and message can be specified as well. Best to read the docs here. Note that if signers already exist, they will be overwritten. The parameter `signers` Can be passed in as an array or a single signer as a struct.

#### `template_id( required string template_id )`

Set to the Template ID of the template you would like to use.

#### `templateid( required string template_id )`

convenience method for setting the template_id.

#### `title( required string title )`

This parameter is used in order to specify a document title.


---
