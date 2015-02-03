start
  = call:root_call properties:block
    { call.properties = properties.properties; return call; }

root_call
  = ws? call:call
    { call.root = true; return call; }

calls
  = calls:("." call:call { return call })+
    { return Array.isArray(calls) ? calls : [calls]; }

call
  = name:call_name parameter:call_parameters
    { return { call: name, parameter: parameter }}

call_name
  = identifier

call_parameters
  = ws? '(' ws? parameter:paramater? ws? ')'
    { return parameter; }

paramater
  = parameter:[a-zA-Z0-9]+ { return parameter.join('') }

block
  = ws? '{' ws? properties:properties ws? '}' ws?
    { return { properties: properties } }

properties
  = properties:(
      first:property
      rest:(property_separator ws? p:property { return p })*
      { return [first].concat(rest); }
    )
    { return properties; }

property
  = call_property
  / object_property
  / simple_property

simple_property
  = name:identifier ws?
    { return { name: name }; }

object_property
  = name:identifier properties:block
    { return { name: name, properties: properties } }

call_property
  = name:identifier calls:calls properties:block
    { return { name: name, calls: calls, properties: properties }; }

property_separator
  = ','

identifier
  = identifier:[a-z0-9A-Z\$]+ { return identifier.join(''); }

ws 'whitespace'
  = [ \t\n\r]*
