
# `use_template.cfc` Reference

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

This parameter can be used to specify a custom requester email address for this document. If used, all email communication related to this document and signing-related notifications will carry this email address as the requester (sender) email address.

#### `customrequestername( required string custom_requester_name )`

This parameter can be used to specify a custom requester name for this document. If used, all email communication related to this document and signing-related notifications will carry this name as the requester (sender) name.

#### `embeddedsigning(  boolean embedded_signing_enabled=true  )`

convenience method for setting the embedded_signing_enabled.

#### `embeddedsigningenabled(  boolean embedded_signing_enabled=true  )`

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

#### `requesteremail( required string custom_requester_email )`

convenience method for setting the custom_requester_email.

#### `requestername( required string custom_requester_name )`

convenience method for setting the custom_requester_name.

#### `sandbox(  boolean sandbox=true  )`

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


