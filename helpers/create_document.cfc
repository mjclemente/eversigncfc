/**
* eversigncfc
* Copyright 2020  Matthew J. Clemente, John Berquist
* Licensed under MIT (https://mit-license.org)
*/
component accessors="true" {

  property name="sandbox" default="0";
  property name="is_draft" default="0";
  property name="title" default="";
  property name="message" default="";
  property name="use_signer_order" default="0";
  property name="reminders" default="0";
  property name="require_all_signers" default="0";
  property name="custom_requester_name" default="";
  property name="custom_requester_email" default="";
  property name="redirect" default="";
  property name="redirect_decline" default="";
  property name="client" default="";
  property name="expires" default="";
  property name="embedded_signing_enabled" default="0";
  property name="flexible_signing" default="0";
  property name="use_hidden_tags" default="0";
  property name="files" default="";
  property name="signers" default="";
  property name="recipients" default="";
  property name="meta" default="";
  property name="fields" default="";

  /**
  * @hint No parameters can be passed to init this component. They must be built manually.
  */
  public any function init() {

    setFiles( [] );
    setSigners( [] );
    setRecipients( [] );
    setMeta( {} );
    setFields( [] );

    variables.utcBaseDate = dateAdd( "l", createDate( 1970,1,1 ).getTime() * -1, createDate( 1970,1,1 ) );

    return this;
  }

  /**
  * @hint Set to 1 in order to enable Sandbox Mode. Calling this without an argument also enables the sandbox.
  */
  public any function sandbox( boolean sandbox = true ) {
    setSandbox( sandbox ? 1 : 0 );
    return this;
  }

  /**
  * @hint Set to 1 in order to create the document as a draft. Calling this without an argument also creates it as a draft.
  */
  public any function draft( boolean draft = true ) {
    setIs_draft( draft ? 1 : 0 );
    return this;
  }

  /**
  * @hint This parameter is used in order to specify a document title.
  */
  public any function title( required string title ) {
    setTitle( title );
    return this;
  }

  /**
  * @hint This parameter is used in order to specify a document message.
  */
  public any function message( required string message ) {
    return setMessage( message );
    return this;
  }

  /**
  * @hint Set to 1 in order to enable Signing Order for this document. Calling this without an argument also enables signing order.
  */
  public any function userSignerOrder( use_signer_order = true ) {
    setUse_signer_order( use_signer_order ? 1 : 0 );
    return this;
  }

  /**
  * @hint Set to 1 in order to enable Auto Reminders for this document. Calling this without an argument also enable auto reminders.
  */
  public any function reminders( boolean reminders = true ) {
    setReminders( reminders ? 1 : 0 );
    return this;
  }

  /**
  * @hint Set to 1 in order to require all signers to sign to complete this document. Calling this without an argument also require all signers.
  */
  public any function requireAllSigners( boolean require_all_signers = true ) {
    setRequire_all_signers( require_all_signers ? 1 : 0 );
    return this;
  }

  /**
  * @hint This parameter can be used to specify a custom requester name for this document. If used, all email communication related to this document and signing-related notifications will carry this name as the requester (sender) name.
  */
  public any function customrequestername( required string custom_requester_name ) {
    setCustom_requester_name( custom_requester_name );
    return this;
  }

  /**
  * @hint convenience method for setting the custom_requester_name
  */
  public any function requestername( required string custom_requester_name ) {
    return this.customrequestername( custom_requester_name );
  }

  /**
  * @hint This parameter can be used to specify a custom requester email address for this document. If used, all email communication related to this document and signing-related notifications will carry this email address as the requester (sender) email address.
  */
  public any function customrequesteremail( required string custom_requester_email ) {
    setCustom_requester_email( custom_requester_email );
    return this;
  }

  /**
  * @hint convenience method for setting the custom_requester_email
  */
  public any function customrequesteremail( required string custom_requester_email ) {
    return this.custom_requester_email( custom_requester_email );
  }

  /**
  * @hint This parameter is used to specify a custom completion redirect URL. If empty, the default Post-Signature Completion URL specified in your eversign Business or the eversign signature completion page will be used.
  */
  public any function redirect( required string redirect ) {
    return setRedirect( redirect );
    return this;
  }

  /**
  * @hint This parameter is used to specify a custom decline redirect URL. If empty, the default Post-Signature Decline URL specified in your eversign Business or the eversign signature declined page will be used.
  */
  public any function redirectdecline( required string redirect_decline ) {
    return setRedirect_decline( redirect_decline );
    return this;
  }

  /**
  * @hint This parameter is used to specify an internal reference for your application, such as an identification string of the server or client making the API request.
  */
  public any function client( required string client_identifier ) {
    return setClient( client_identifier );
    return this;
  }

  /**
  * @hint This parameter is used to specify a custom expiration date for your document. The date entered will be automatically converted to a Unix Timestamp. If empty, the default document expiration period specified in your business settings will be used.
  */
  public any function expires( required date expires ) {
    setExpires( getUTCTimestamp( expires ) );
    return this;
  }

  /**
  * @hint Set to 1 in order to enable Embedded Signing for this document. If enabled, this document can be signed within an iFrame embedded on your website and email authentication will be disabled. If called without a flag, it will enable embedded signing.
  */
  public any function embeddedsigningenabled( boolean embedded_signing_enabled = true ) {
    setEmbedded_signing_enabled( embedded_signing_enabled ? 1 : 0 );
    return this;
  }

  /**
  * @hint convenience method for setting the embedded_signing_enabled
  */
  public any function embeddedsigning( required string embedded_signing_enabled ) {
    return this.embeddedsigningenabled( embedded_signing_enabled );
  }

  /**
  * @hint Set to 1 in order to create this document without specifying fields. Signers will be able to place their own fields during signing. If called without a flag, it will enable flexible signing.
  */
  public any function flexibleSigning( boolean flexible_signing = true ) {
    setFlexible_signing( flexible_signing ? 1 : 0 );
    return this;
  }

    /**
  * @hint Set to 1 to parse hidden tags placed on your document. If called without a flag, it will parse hidden tags.
  */
  public any function useHiddenTags( boolean use_hidden_tags = true ) {
    setUse_hidden_tags( use_hidden_tags ? 1 : 0 );
    return this;
  }

  /**
  * @hint An array with an object for each file of the document. Each object must contain a file name and either a URL, a reference to an existing file ID or a file via a base64 string. Best to read the docs here. Note that if files already exist, they will be overwritten
  * @files Can be passed in as an array or a single file as a struct
  */
  public any function files( required any files ) {
    if ( isArray( files ) ){
      setFiles( files );
    } else {
      // we're assuming this is a struct in the shape of a file. If it's not, the API will error
      setFiles( [ files ] );
    }
    return this;
  }

  /**
  * @hint Appends a single file to the files array
  */
  public any function addFile( required struct file ) {
    variables.files.append( file );
    return this;
  }

  /**
  * @hint Convenience method for adding a file
  */
  public any function file( required struct file ) {
    return this.addFile( file );
  }



  /**
  * @hint An array with an object for each signer of the document. Each object must contain the role name, signer name and signer email address. At this point, an optional Signer PIN and message can be specified as well. Best to read the docs here. Note that if signers already exist, they will be overwritten
  * @signers Can be passed in as an array or a single signer as a struct
  */
  public any function signers( required any signers ) {
    if ( isArray( signers ) ){
      setSigners( signers );
    } else {
      // we're assuming this is a struct in the shape of a signer. If it's not, the API will error
      setSigners( [ signers ] );
    }
    return this;
  }

  /**
  * @hint Appends a single signer to the signers array
  */
  public any function addSigner( required struct signer ) {
    variables.signers.append( signer );
    return this;
  }

  /**
  * @hint Convenience method for adding a signer
  */
  public any function signer( required struct signer ) {
    return this.addSigner( signer );
  }

  /**
  * @hint An array with an object for each recipient (CC) role of your template. Each object must contain the role name, CC name and CC email address. Best to read the docs here. Note that if recipients already exist, they will be overwritten
  * @recipients Can be passed in as an array or a single recipient as a struct
  */
  public any function recipients( required any recipients ) {
    if ( isArray( recipients ) ){
      setRecipients( recipients );
    } else {
      // we're assuming this is a struct in the shape of a recipient. If it's not, the API will error
      setRecipients( [ recipients ] );
    }
    return this;
  }

  /**
  * @hint Appends a single recipient to the recipients array
  */
  public any function addRecipient( required struct recipient ) {
    variables.recipients.append( recipient );
    return this;
  }

  /**
  * @hint Convenience method for adding a recipient
  */
  public any function recipient( required struct recipient ) {
    return this.addRecipient( recipient );
  }

    /**
  * @hint An array with an object for each Merge Field of this template. The identifier and object are required. Best to read the docs here. Note that if fields already exist, they will be overwritten
  * @fields Can be passed in as an array or a single field as a struct
  * @example { "identifier": "unique_field_identifier_1", "value": "Merge Field Content" }
  */
  public any function fields( required any fields ) {
    if ( isArray( fields ) ){
      setFields( fields );
    } else {
      // we're assuming this is a struct in the shape of a field. If it's not, the API will error
      setFields( [ fields ] );
    }
    return this;
  }

  /**
  * @hint Sets the `meta` property. If a `meta` property was previously set, this method overwrites it.
  * @meta An object containing key/value pairs of whatever you wish set in the `meta` property.
  */
  public any function meta( required struct meta ) {
    setMeta( meta );
    return this;
  }


  /**
  * @hint Appends a single key/value pair to the `meta` property.
  * @meta Facilitates two means of setting a `meta` property. You can pass in a struct with a key/value pair for the `meta` name and value. Alternatively, you can use this to pass in the name of the `meta` property, and provide the value as a second argument.
  */
  public any function addMeta( required any meta, any value ) {
    if ( isStruct( meta ) )
      variables.meta.append( meta );
    else
      variables.meta[ meta ] = value;

    return this;
  }


  /**
  * @hint Appends a single field to the fields array
  */
  public any function addField( required struct field ) {
    variables.fields.append( field );
    return this;
  }

  /**
  * @hint Convenience method for adding a field
  */
  public any function field( required struct field ) {
    return this.addField( field );
  }



  /**
  * @hint Assembles the JSON to send to the API. Generally, you shouldn't need to call this directly.
  */
  public string function build() {

    var body = '';
    var properties = getPropertyValues();
    var count = properties.len();

    properties.each(
      function( property, index ) {

        var value = serializeJSON( property.value );
        body &= '"#property.key#": ' & value & '#index NEQ count ? "," : ""#';
      }
    );

    return '{' & body & '}';
  }

  private numeric function getUTCTimestamp( required date dateToConvert ) {
    return dateDiff( "s", variables.utcBaseDate, dateToConvert );
  }

  private date function parseUTCTimestamp( required numeric utcTimestamp ) {
    return dateAdd( "s", utcTimestamp, variables.utcBaseDate );
  }

  /**
  * @hint converts the array of properties to an array of their keys/values, while filtering those that have not been set
  */
  private array function getPropertyValues() {

    var propertyValues = getProperties().map(
      function( item, index ) {
        return {
          "key" : item.name,
          "value" : getPropertyValue( item.name )
        };
      }
    );

    return propertyValues.filter(
      function( item, index ) {
        return hasValue( item.value );
      }
    );
  }

  private array function getProperties() {

    var metaData = getMetaData( this );
    var properties = [];

    for( var prop in metaData.properties ) {
      properties.append( prop );
    }

    return properties;
  }

  private any function getPropertyValue( string key ){
    var method = this["get#key#"];
    var value = method();
    return value;
  }

  private boolean function hasValue( any value ) {
    if ( isNull( value ) ) return false;
    if ( isSimpleValue( value ) ) return len( value );
    if ( isStruct( value ) ) return !value.isEmpty();
    if ( isArray( value ) ) return value.len();

    return false;
  }
}
