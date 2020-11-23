
# `eversign.cfc` Reference

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

#### `downloadFinal( required string document_hash,  boolean audit_trail=false ,  any document_id,  boolean url_only=false  )`

Download the final, signed version of the document. *[Endpoint docs](https://eversign.com/api/documentation/methods#download-final-pdf)*

#### `downloadOriginal( required string document_hash )`

Download the original PDF file. *[Endpoint docs](https://eversign.com/api/documentation/methods#download-original-pdf)*

#### `getDocument( required string document_hash )`

Retrieve a document (or template) by the document/template hash. *[Endpoint docs](https://eversign.com/api/documentation/methods#get-document-template)*

#### `getFinalDownloadUrl( required string document_hash,  boolean audit_trail=false  )`

Convenience method for downloading the final document's download URL.

#### `getTemplate( required string document_hash )`

Retrieve a document (or template) by the document/template hash. *[Endpoint docs](https://eversign.com/api/documentation/methods#get-document-template)*

#### `listBusinesses()`

A list of existing businesses on your eversign account. *[Endpoint docs](https://eversign.com/api/documentation/methods#list-businesses)*

#### `listDocuments(  string type="all"  )`

List documents. The parameter `type` options are all, my_action_required, waiting_for_others, completed, drafts, cancelled. *[Endpoint docs](https://eversign.com/api/documentation/methods#list-documents)*

#### `listTemplates(  string type="templates"  )`

List templates. The parameter `type` options are templates, templates_archived, template_drafts. *[Endpoint docs](https://eversign.com/api/documentation/methods#list-templates)*

#### `sendReminder( required string document_hash, required numeric signer_id )`

Send reminder. *[Endpoint docs](https://eversign.com/api/documentation/methods#send-reminder)*

#### `useTemplate( required any use_template )`

Use Template. The parameter `use_template` expects an instance of the `helpers.use_template` component, but you can construct the struct/json yourself if you prefer. *[Endpoint docs](https://eversign.com/api/documentation/methods#use-template)*

#### `validateEventHash( required string event_hash, required string event_time, required string event_type )`

Validates Eversign webhook events. *[Endpoint docs](https://eversign.com/api/documentation/webhooks#event-hashes)*


