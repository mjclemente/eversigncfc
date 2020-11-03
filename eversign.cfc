/**
* eversigncfc
* Copyright 2020  Matthew J. Clemente, John Berquist
* Licensed under MIT (https://mit-license.org)
*/
component displayname="eversigncfc"  {

  variables._eversigncfc_version = '0.0.0';

  public any function init(
      string access_key = '',
      string business_id = '',
      string baseUrl = "https://api.eversign.com/api",
      boolean includeRaw = false,
      numeric httpTimeout = 50
  ) {

      structAppend( variables, arguments );

      //map sensitive args to env variables or java system props
      var secrets = {
          'access_key': 'EVERSIGN_ACCESS_KEY',
          'business_id': 'EVERSIGN_BUSINESS_ID'
      };
      var system = createObject( 'java', 'java.lang.System' );

      for ( var key in secrets ) {
          //arguments are top priority
          if ( len( variables[ key ] ) ) {
              continue;
          }

          //check environment variables
          var envValue = system.getenv( secrets[ key ] );
          if ( !isNull( envValue ) && envValue.len() ) {
              variables[ key ] = envValue;
              continue;
          }

          //check java system properties
          var propValue = system.getProperty( secrets[ key ] );
          if ( !isNull( propValue ) && propValue.len() ) {
              variables[ key ] = propValue;
          }
      }

      //declare file fields to be handled via multipart/form-data **Important** this is not applicable if payload is application/json
      variables.fileFields = [];

      return this;
  }

  /**
  * @docs https://eversign.com/api/documentation/methods#list-businesses
  * @hint A list of existing businesses on your eversign account
  */
  public struct function listBusinesses() {
    return apiCall( 'GET', '/business' );
  }

  /**
  * @docs https://eversign.com/api/documentation/methods#create-document
  * @hint Create a document
  * @create_document expects an instance of the `helpers.create_document` component, but you can construct the struct/json yourself if you prefer
  */
  public struct function createDocument( required any create_document ) {
    var payload = isObject( create_document )
      ? create_document.build()
      : create_document;

    return apiCall( 'POST', '/document', {}, payload );
  }

  /**
  * @docs https://eversign.com/api/documentation/methods#create-template
  //TODO Add create_template helper
  * @hint Create a document template
  */
  public struct function createTemplate( required any template ) {
    var payload = isObject( template )
      ? template.build()
      : document;

    return apiCall( 'POST', '/document', {}, payload );
  }

  /**
  * @docs https://eversign.com/api/documentation/methods#use-template
  * @hint Use Template
  * @use_template expects an instance of the `helpers.use_template` component, but you can construct the struct/json yourself if you prefer
  */
  public struct function useTemplate( required any use_template ) {
    var payload = isObject( use_template )
      ? use_template.build()
      : use_template

    return apiCall( 'POST', '/document', {}, payload );
  }

  /**
  * @docs https://eversign.com/api/documentation/methods#get-document-template
  * @hint Retrieve a document (or template) by the document/template hash
  */
  public struct function getDocument( required string document_hash ) {
    return apiCall( 'GET', '/document', { "document_hash" = document_hash } );
  }

  /**
  * @docs https://eversign.com/api/documentation/methods#get-document-template
  * @hint Retrieve a document (or template) by the document/template hash
  */
  public struct function getTemplate( required string document_hash ) {
    return getDocument( document_hash );
  }

  /**
  * @docs https://eversign.com/api/documentation/methods#list-documents
  * @hint List documents
  * @type options are all, my_action_required, waiting_for_others, completed, drafts, cancelled
  */
  public struct function listDocuments( string type = 'all' ) {
    return apiCall( 'GET', '/document', { 'type' = type } );
  }

  /**
  * @docs https://eversign.com/api/documentation/methods#list-templates
  * @hint List templates
  * @type options are templates, templates_archived, template_drafts
  */
  public struct function listTemplates( string type = 'templates' ) {
    return apiCall( 'GET', '/document', { 'type' = type } );
  }

  /**
  * @docs https://eversign.com/api/documentation/methods#send-reminder
  * @hint Send reminder
  */
  public struct function sendReminder( required string document_hash, required numeric signer_id ) {
    var payload = {
      "document_hash": document_hash,
	    "signer_id": signer_id
    }

    return apiCall( 'POST', '/send_reminder', {}, payload );
  }

  /**
  * @docs https://eversign.com/api/documentation/methods#delete-document
  * @hint Delete document. Please note that only cancelled documents and draft documents or templates can be deleted.
  */
  public struct function deleteDocument( required string document_hash ) {
    return apiCall( 'DELETE', '/document', { "document_hash" = document_hash } );
  }

  /**
  * @docs https://eversign.com/api/documentation/methods#delete-document
  * @hint Delete template using the document/template hash
  */
  public struct function deleteTemplate( required string document_hash ) {
    return deleteDocument( document_hash );
  }

  /**
  * @docs https://eversign.com/api/documentation/methods#cancel-document
  * @hint Cancel document
  */
  public struct function cancelDocument( required string document_hash ) {
    return apiCall( 'DELETE', '/document', { "document_hash" = document_hash, "cancel" = 1 } );
  }

  /**
  * @docs https://eversign.com/api/documentation/methods#download-original-pdf
  * @hint Download the original PDF file
  */
  public struct function downloadOriginal( required string document_hash ) {
    return apiCall( 'GET', '/download_raw_document', { "document_hash" = document_hash } );
  }

  /**
  * @docs https://eversign.com/api/documentation/methods#download-final-pdf
  * @hint Download the final, signed version of the document
  */
  public struct function downloadFinal( required string document_hash, boolean audit_trail = false, any document_id, boolean url_only = false ) {
    var params = {
      "document_hash" = document_hash
    };
    if( audit_trail ){
      params[ "audit_trail" ] = "1";
    }
    if( arguments.keyExists( 'document_id' ) ){
      params[ "document_id" ] = document_id;
    }
    if( url_only ){
      params[ "url_only" ] = "1";
    }
    return apiCall( 'GET', '/download_final_document', params );
  }

  /**
  * @hint Convenience method for downloading the final document's audit trail.
  */
  public struct function downloadAuditTrail( required string document_hash ){
    return downloadFinal( document_hash = document_hash, document_id = 'AT' );
  }

  /**
  * @hint Convenience method for downloading the final document's download URL.
  */
  public struct function getFinalDownloadUrl( required string document_hash, boolean audit_trail = false ){
    return downloadFinal( document_hash = document_hash, audit_trail = audit_trail, url_only = true );
  }

  /**
  * @docs https://eversign.com/api/documentation/webhooks#event-hashes
  * @hint Validates Eversign webhook events
  */
  public boolean function validateEventHash( required string event_hash, required string event_time, required string event_type ){
    return hmac("#event_time##event_type#",variables.access_key,"HMACSHA256") == event_hash;
  }



  // PRIVATE FUNCTIONS
  private struct function apiCall(
      required string httpMethod,
      required string path,
      struct queryParams = { },
      any payload = '',
      struct headers = { }
  ) {

      var fullApiPath = variables.baseUrl & path;
      var requestHeaders = getBaseHttpHeaders();
      requestHeaders.append( headers, true );

      queryParams["access_key"] = variables.access_key;
      queryParams["business_id"] = variables.business_id;


      var requestStart = getTickCount();
      var apiResponse = makeHttpRequest( httpMethod = httpMethod, path = fullApiPath, queryParams = queryParams, headers = requestHeaders, payload = payload );

      var result = {
          'responseTime' = getTickCount() - requestStart,
          'statusCode' = listFirst( apiResponse.statuscode, " " ),
          'statusText' = listRest( apiResponse.statuscode, " " ),
          'headers' = apiResponse.responseheader
      };

      var parsedFileContent = {};

      // Handle response based on mimetype
      var mimeType = apiResponse.mimetype ?: requestHeaders[ 'Content-Type' ];

      if ( mimeType == 'application/json' && isJson( apiResponse.fileContent ) ) {
          parsedFileContent = deserializeJSON( apiResponse.fileContent );
      } else if ( mimeType.listLast( '/' ) == 'xml' && isXml( apiResponse.fileContent ) ) {
          parsedFileContent = xmlToStruct( apiResponse.fileContent );
      } else {
          parsedFileContent = apiResponse.fileContent;
      }

      //can be customized by API integration for how errors are returned
      //if ( result.statusCode >= 400 ) {}

      //stored in data, because some responses are arrays and others are structs
      result[ 'data' ] = parsedFileContent;

      if ( variables.includeRaw ) {
          result[ 'raw' ] = {
              'method' : ucase( httpMethod ),
              'path' : fullApiPath,
              'params' : parseQueryParams( queryParams ),
              'payload' : parseBody( payload ),
              'response' : apiResponse.fileContent
          };
      }

      return result;
  }

  private struct function getBaseHttpHeaders() {
      return {
          'Accept' : 'application/json',
          'Content-Type' : 'application/json',
          'User-Agent' : 'eversigncfc/#variables._eversigncfc_version# (ColdFusion)'
      };
  }

  private any function makeHttpRequest(
      required string httpMethod,
      required string path,
      struct queryParams = { },
      struct headers = { },
      any payload = ''
  ) {
      var result = '';

      var fullPath = path & ( !queryParams.isEmpty()
          ? ( '?' & parseQueryParams( queryParams, false ) )
          : '' );

      cfhttp( url = fullPath, method = httpMethod,  result = 'result', timeout = variables.httpTimeout ) {

          if ( isJsonPayload( headers ) ) {

              var requestPayload = parseBody( payload );
              if ( isJSON( requestPayload ) ) {
                  cfhttpparam( type = "body", value = requestPayload );
              }

          } else if ( isFormPayload( headers ) ) {

              headers.delete( 'Content-Type' ); //Content Type added automatically by cfhttppparam

              for ( var param in payload ) {
                  if ( !variables.fileFields.contains( param ) ) {
                      cfhttpparam( type = 'formfield', name = param, value = payload[ param ] );
                  } else {
                      cfhttpparam( type = 'file', name = param, file = payload[ param ] );
                  }
              }

          }

          //handled last, to account for possible Content-Type header correction for forms
          var requestHeaders = parseHeaders( headers );
          for ( var header in requestHeaders ) {
              cfhttpparam( type = "header", name = header.name, value = header.value );
          }

      }
      return result;
  }

  /**
  * @hint convert the headers from a struct to an array
  */
  private array function parseHeaders( required struct headers ) {
      var sortedKeyArray = headers.keyArray();
      sortedKeyArray.sort( 'textnocase' );
      var processedHeaders = sortedKeyArray.map(
          function( key ) {
              return { name: key, value: trim( headers[ key ] ) };
          }
      );
      return processedHeaders;
  }

  /**
  * @hint converts the queryparam struct to a string, with optional encoding and the possibility for empty values being pass through as well
  */
  private string function parseQueryParams( required struct queryParams, boolean encodeQueryParams = true, boolean includeEmptyValues = true ) {
      var sortedKeyArray = queryParams.keyArray();
      sortedKeyArray.sort( 'text' );

      var queryString = sortedKeyArray.reduce(
          function( queryString, queryParamKey ) {
              var encodedKey = encodeQueryParams
                  ? encodeUrl( queryParamKey )
                  : queryParamKey;
              if ( !isArray( queryParams[ queryParamKey ] ) ) {
                  var encodedValue = encodeQueryParams && len( queryParams[ queryParamKey ] )
                      ? encodeUrl( queryParams[ queryParamKey ] )
                      : queryParams[ queryParamKey ];
              } else {
                  var encodedValue = encodeQueryParams && ArrayLen( queryParams[ queryParamKey ] )
                      ?  encodeUrl( serializeJSON( queryParams[ queryParamKey ] ) )
                      : queryParams[ queryParamKey ].toList();
                  }
              return queryString.listAppend( encodedKey & ( includeEmptyValues || len( encodedValue ) ? ( '=' & encodedValue ) : '' ), '&' );
          }, ''
      );

      return queryString.len() ? queryString : '';
  }

  private string function parseBody( required any body ) {
      if ( isStruct( body ) || isArray( body ) ) {
          return serializeJson( body );
      } else if ( isJson( body ) ) {
          return body;
      } else {
          return '';
      }
  }

  private string function encodeUrl( required string str, boolean encodeSlash = true ) {
      var result = replacelist( urlEncodedFormat( str, 'utf-8' ), '%2D,%2E,%5F,%7E', '-,.,_,~' );
      if ( !encodeSlash ) {
          result = replace( result, '%2F', '/', 'all' );
      }
      return result;
  }

  /**
  * @hint helper to determine if body should be sent as JSON
  */
  private boolean function isJsonPayload( required struct headers ) {
      return headers[ 'Content-Type' ] == 'application/json';
  }

  /**
  * @hint helper to determine if body should be sent as form params
  */
  private boolean function isFormPayload( required struct headers ) {
      return arrayContains( [ 'application/x-www-form-urlencoded', 'multipart/form-data' ], headers[ 'Content-Type' ] );
  }

  /**
  *
  * Based on an (old) blog post and UDF from Raymond Camden
  * https://www.raymondcamden.com/2012/01/04/Converting-XML-to-JSON-My-exploration-into-madness/
  *
  */
  private struct function xmlToStruct( required any x ) {

      if ( isSimpleValue( x ) && isXml( x ) ) {
          x = xmlParse( x );
      }

      var s = {};

      if ( xmlGetNodeType( x ) == "DOCUMENT_NODE" ) {
          s[ structKeyList( x ) ] = xmlToStruct( x[ structKeyList( x ) ] );
      }

      if ( structKeyExists( x, "xmlAttributes" ) && !structIsEmpty( x.xmlAttributes ) ) {
          s.attributes = {};
          for ( var item in x.xmlAttributes ) {
              s.attributes[ item ] = x.xmlAttributes[ item ];
          }
      }

      if ( structKeyExists( x, 'xmlText' ) && x.xmlText.trim().len() ) {
          s.value = x.xmlText;
      }

      if ( structKeyExists( x, "xmlChildren" ) ) {

          for ( var xmlChild in x.xmlChildren ) {
              if ( structKeyExists( s, xmlChild.xmlname ) ) {

                  if ( !isArray( s[ xmlChild.xmlname ] ) ) {
                      var temp = s[ xmlChild.xmlname ];
                      s[ xmlChild.xmlname ] = [ temp ];
                  }

                  arrayAppend( s[ xmlChild.xmlname ], xmlToStruct( xmlChild ) );

              } else {

                  if ( structKeyExists( xmlChild, "xmlChildren" ) && arrayLen( xmlChild.xmlChildren ) ) {
                          s[ xmlChild.xmlName ] = xmlToStruct( xmlChild );
                  } else if ( structKeyExists( xmlChild, "xmlAttributes" ) && !structIsEmpty( xmlChild.xmlAttributes ) ) {
                      s[ xmlChild.xmlName ] = xmlToStruct( xmlChild );
                  } else {
                      s[ xmlChild.xmlName ] = xmlChild.xmlText;
                  }

              }

          }
      }

      return s;
  }

}
