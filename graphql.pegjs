start
  = root_call block

root_call
  = ws? call:call
    { return call; }

call
  = name:call_name parameter:call_parameters
    { return { name: name, parameter: parameter }}

call_name
  = identifier

call_parameters
  = ws? "(" ws? parameter:paramater ws? ")"
    { return parameter; }

paramater
  = [a-z0-9]

block
  = ws? "{" properties:properties "}"
    { return { properties: properties } }

properties
  = properties:(
      first:property
      rest:(property_separator ws? p:property { return p })*
      { return [first].concat(rest); }
    )
    { return properties; }

property
  = simple_property
  / object_property

simple_property
  = name:identifier ws?
    { return { name: name }; }

object_property
  = name:identifier ws? properties:block ws?
    { return { name: name, properties: properties } }

property_separator
  = ","

identifier
  = identifier:[a-z0-9]+ { return identifier.join(''); }

ws "whitespace"
  = [ \t\n\r]*