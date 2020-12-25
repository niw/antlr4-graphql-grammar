grammar GraphQL;

// Parser

// Document
// https://spec.graphql.org/June2018/#sec-Language.Document

document:
    definition+
    ;

definition:
    executableDefinition
    | typeSystemDefinition
    | typeSystemExtension
    ;

executableDefinition:
    operationDefinition
    | fragmentDefinition
    ;

// Operations
// https://spec.graphql.org/June2018/#sec-Language.Operations

operationDefinition:
    operationType name? variableDefinitions? directives? selectionSet
    | selectionSet
    ;

operationType:
    QUERY | MUTATION | SUBSCRIPTION;

// Selection Sets
// https://spec.graphql.org/June2018/#sec-Selection-Sets

selectionSet:
    '{' selection+ '}';

selection:
    field
    | fragmentSpread
    | inlineFragment
    ;

// Fields
// https://spec.graphql.org/June2018/#sec-Language.Fields

field:
    alias? name arguments? directives? selectionSet?;

// Arguments
// https://spec.graphql.org/June2018/#sec-Language.Arguments

arguments:
    '(' argument+ ')';

argument:
    name ':' value;

// Field Alias
// https://spec.graphql.org/June2018/#sec-Field-Alias

alias:
    name ':';

// Fragments
// https://spec.graphql.org/June2018/#sec-Language.Fragments

fragmentSpread:
    '...' fragmentName directives?;

fragmentDefinition:
    FRAGMENT fragmentName typeCondition directives? selectionSet;

fragmentName:
    // Specification is Name but not `on`
    nameBase
    | TRUE
    | FALSE
    | NULL
    ;

// Type Conditions
// https://spec.graphql.org/June2018/#sec-Type-Conditions

typeCondition:
    ON namedType;

// Inline Fragments
// https://spec.graphql.org/June2018/#sec-Inline-Fragments

inlineFragment:
    '...' typeCondition? directives? selectionSet;

// Input Values
// https://spec.graphql.org/June2018/#sec-Input-Values

value:
    variable
    | intValue
    | floatValue
    | stringValue
    | booleanValue
    | nullValue
    | enumValue
    | listValue
    | objectValue
    ;

// Int Value
// https://spec.graphql.org/June2018/#sec-Int-Value

intValue:
    INT_VALUE;

// Float Value
// https://spec.graphql.org/June2018/#sec-Float-Value

floatValue:
    FLOAT_VALUE;

// Bloolean Value
// https://spec.graphql.org/June2018/#sec-Boolean-Value

booleanValue:
    TRUE
    | FALSE
    ;

// String Value
// https://spec.graphql.org/June2018/#sec-String-Value

stringValue:
    STRING_VALUE;

// Null Value
// https://spec.graphql.org/June2018/#sec-Null-Value

nullValue:
    NULL;

// Enum Value
// https://spec.graphql.org/June2018/#sec-Enum-Value

enumValue:
    // Specification is Name but not `true` or `false` or `null`
    nameBase
    | ON;

// List Value
// https://spec.graphql.org/June2018/#sec-List-Value

listValue:
    '[' ']'
    | '[' value+ ']'
    ;

// Input Object Values
// https://spec.graphql.org/June2018/#sec-Input-Object-Values

objectValue:
    '{' '}'
    | '{' objectField+ '}';

objectField:
    name ':' value;

// Variables
// https://spec.graphql.org/June2018/#sec-Language.Variables

variable:
    '$' name;

variableDefinitions:
    '(' variableDefinition+ ')';

variableDefinition:
    variable ':' type_ defaultValue?;

defaultValue:
    '=' value;

// Type References
// https://spec.graphql.org/June2018/#sec-Type-References

type_:
    namedType
    | listType
    | nonNullType
    ;

namedType:
    name;

listType:
    '[' type_ ']';

nonNullType:
    namedType '!'
    | listType '!'
    ;

// Directives
// https://spec.graphql.org/June2018/#sec-Language.Directives

directives:
    directive+;

directive:
    '@' name arguments?;

// Type System
// https://graphql.github.io/graphql-spec/June2018/#TypeSystemDefinition

typeSystemDefinition:
    schemaDefinition
    | typeDefinition
    | directiveDefinition
    ;

// Type System Extensions
// https://spec.graphql.org/June2018/#TypeSystemExtension

typeSystemExtension:
    schemaExtension
    | typeExtension
    ;

// Schema
// https://graphql.github.io/graphql-spec/June2018/#sec-Schema

schemaDefinition:
    SCHEMA directives? '{' rootOperationTypeDefinition+ '}';

rootOperationTypeDefinition:
    operationType ':' namedType;

// Schema Extension
// https://spec.graphql.org/June2018/#sec-Schema-Extension

schemaExtension:
    EXTEND SCHEMA directives? '{' operationTypeDefinition+ '}'
    | EXTEND SCHEMA directives
    ;

// https://spec.graphql.org/June2018/#OperationTypeDefinition
operationTypeDefinition:
    operationType ':' namedType;

// Descriptions
// https://spec.graphql.org/June2018/#sec-Descriptions
description:
    stringValue;

// Types
// https://spec.graphql.org/June2018/#sec-Types

typeDefinition:
    scalarTypeDefinition
    | objectTypeDefinition
    | interfaceTypeDefinition
    | unionTypeDefinition
    | enumTypeDefinition
    | inputObjectTypeDefinition;

// Type Extensions
// https://spec.graphql.org/June2018/#sec-Type-Extensions

typeExtension:
    scalarTypeExtension
    | objectTypeExtension
    | interfaceTypeExtension
    | unionTypeExtension
    | enumTypeExtension
    | inputObjectTypeExtension
    ;

// Scalars
// https://spec.graphql.org/June2018/#sec-Scalars

scalarTypeDefinition:
    description? SCALAR name directives?;

// Scalar Extensions
// https://spec.graphql.org/June2018/#sec-Scalar-Extensions

scalarTypeExtension:
    EXTEND SCALAR name directives;

// Objects
// https://graphql.github.io/graphql-spec/June2018/#sec-Objects

objectTypeDefinition:
    description? TYPE name implementsInterfaces? directives? fieldsDefinition?;

implementsInterfaces:
    IMPLEMENTS '&'? namedType
    | implementsInterfaces '&' namedType
    ;

fieldsDefinition:
    '{'  fieldDefinition+ '}';

fieldDefinition:
    description? name argumentsDefinition? ':' type_ directives?;

// Field Arguments
// https://spec.graphql.org/June2018/#sec-Field-Arguments

argumentsDefinition:
    '(' inputValueDefinition+ ')';

inputValueDefinition:
    description? name ':' type_ defaultValue? directives?;

// Object Extensions
// https://spec.graphql.org/June2018/#sec-Object-Extensions

objectTypeExtension:
    EXTEND TYPE name implementsInterfaces? directives? fieldsDefinition
    | EXTEND TYPE name implementsInterfaces? directives
    | EXTEND TYPE name implementsInterfaces
    ;

// Interfaces
// https://spec.graphql.org/June2018/#sec-Interfaces

interfaceTypeDefinition:
    description? INTERFACE name directives? fieldsDefinition?;

// Interface Extensions
// https://spec.graphql.org/June2018/#sec-Interface-Extensions

interfaceTypeExtension:
    EXTEND INTERFACE name directives? fieldsDefinition
    | EXTEND INTERFACE name directives
    ;

// Unions
// https://graphql.github.io/graphql-spec/June2018/#sec-Unions

unionTypeDefinition:
    description? UNION name directives? unionMemberTypes?;

unionMemberTypes:
    '=' '|'? namedType
    | unionMemberTypes '|'namedType
    ;

// Union Extensions
// https://spec.graphql.org/June2018/#sec-Union-Extensions

unionTypeExtension:
    EXTEND UNION name directives? unionMemberTypes
    | EXTEND UNION name directives
    ;

// Enums
// https://spec.graphql.org/June2018/#sec-Enums

enumTypeDefinition:
    description? ENUM name directives? enumValuesDefinition?;

enumValuesDefinition:
    '{' enumValueDefinition+ '}';

enumValueDefinition:
    description? enumValue directives?;

// Enum Extensions
// https://spec.graphql.org/June2018/#sec-Enum-Extensions

enumTypeExtension:
    EXTEND ENUM name directives? enumValuesDefinition
    | EXTEND ENUM name directives
    ;

// Input Objects
// https://spec.graphql.org/June2018/#sec-Input-Objects
inputObjectTypeDefinition:
    description? INPUT name directives? inputFieldsDefinition?;

inputFieldsDefinition:
    '{' inputValueDefinition+ '}';

// Input Object Extensions
// https://spec.graphql.org/June2018/#sec-Input-Object-Extensions
inputObjectTypeExtension:
    EXTEND INPUT name directives? inputFieldsDefinition
    | EXTEND INPUT name directives
    ;

// Directives
// https://spec.graphql.org/June2018/#sec-Type-System.Directives

directiveDefinition:
    description? DIRECTIVE '@' name argumentsDefinition? ON directiveLocations;

directiveLocations:
    '|'? directiveLocation
    | directiveLocations '|' directiveLocation
    ;

directiveLocation:
    executableDirectiveLocation
    | typeSystemDirectiveLocation
    ;

executableDirectiveLocation:
    EXECUTABLE_DIRECTIVE_LOCATION;

typeSystemDirectiveLocation:
    TYPE_SYSTEM_DIRECTIVE_LOCATION;

// Names
// http://spec.graphql.org/June2018/#sec-Names

name:
    nameBase
    | TRUE
    | FALSE
    | NULL
    | ON
    ;

nameBase:
    NAME
    | FRAGMENT
    | QUERY
    | MUTATION
    | SUBSCRIPTION
    | SCHEMA
    | SCALAR
    | TYPE
    | INTERFACE
    | IMPLEMENTS
    | ENUM
    | UNION
    | INPUT
    | EXTEND
    | DIRECTIVE
    | EXECUTABLE_DIRECTIVE_LOCATION
    | TYPE_SYSTEM_DIRECTIVE_LOCATION
    ;


// Lexer

TRUE:
    'true';
FALSE:
    'false';
NULL:
    'null';
FRAGMENT:
    'fragment';
QUERY:
    'query';
MUTATION:
    'mutation';
SUBSCRIPTION:
    'subscription';
SCHEMA:
    'schema';
SCALAR:
    'scalar';
TYPE:
    'type';
INTERFACE:
    'interface';
IMPLEMENTS:
    'implements';
ENUM:
    'enum';
UNION:
    'union';
INPUT:
    'input';
EXTEND:
    'extend';
DIRECTIVE:
    'directive';
ON:
    'on';
EXECUTABLE_DIRECTIVE_LOCATION:
    'QUERY'
    | 'MUTATION'
    | 'SUBSCRIPTION'
    | 'FIELD'
    | 'FRAGMENT_DEFINITION'
    | 'FRAGMENT_SPREAD'
    | 'INLINE_FRAGMENT'
    ;
TYPE_SYSTEM_DIRECTIVE_LOCATION:
    'SCHEMA'
    | 'SCALAR'
    | 'OBJECT'
    | 'FIELD_DEFINITION'
    | 'ARGUMENT_DEFINITION'
    | 'INTERFACE'
    | 'UNION'
    | 'ENUM'
    | 'ENUM_VALUE'
    | 'INPUT_OBJECT'
    | 'INPUT_FIELD_DEFINITION'
    ;
NAME:
    [_A-Za-z] [_0-9A-Za-z]*;

// Int Value
// http://spec.graphql.org/June2018/#sec-Int-Value

INT_VALUE:
    INTEGER_PART;

INTEGER_PART:
    NEGATIVE_SIGN? '0'
    | NEGATIVE_SIGN? NON_ZERO_DIGIT DIGIT*
    ;

fragment NEGATIVE_SIGN:
    '-';

fragment DIGIT:
    [0-9];

fragment NON_ZERO_DIGIT:
    // Specification is Digit but not `0`.
    [1-9];

// Float Value
// http://spec.graphql.org/June2018/#sec-Float-Value

FLOAT_VALUE:
    INTEGER_PART FRACTIONAL_PART
    | INTEGER_PART EXPONENTIAL_PART
    | INTEGER_PART FRACTIONAL_PART EXPONENTIAL_PART
    ;

fragment FRACTIONAL_PART:
    '.' DIGIT+;

fragment EXPONENTIAL_PART:
    EXPONENT_INDICATOR SIGN? DIGIT+;

fragment EXPONENT_INDICATOR:
    [eE];

fragment SIGN:
    [+-];

// String Value
// http://spec.graphql.org/June2018/#sec-String-Value

STRING_VALUE:
    '"' STRING_CHARACTER* '"'
    // Nongreedy subrules
    | '"""' BLOCK_STRING_CHARCTER*? '"""'
    ;

fragment STRING_CHARACTER:
    // Specification is SourceCharacter but not `"` or `\` or LineTerminator.
    [\u0009\u0020\u0021\u0023-\u005b\u005d-\uFFFF]
    | '\\u' ESCAPED_UNICODE
    | '\\' ESCAPED_CHARACTER
    ;

fragment ESCAPED_UNICODE:
    ESCAPED_UNICODE_CHARACTER ESCAPED_UNICODE_CHARACTER ESCAPED_UNICODE_CHARACTER ESCAPED_UNICODE_CHARACTER;

fragment ESCAPED_UNICODE_CHARACTER:
    [0-9A-Fa-f];

fragment ESCAPED_CHARACTER:
    ["\\/bfnrt];

// Specification is
// - SourceCharacter but not `"""` or `\"""`
// - \"""
// See `STRING_VALUE` also for this condition.
fragment BLOCK_STRING_CHARCTER:
    // The order of token is matter.
    '\\"""'
    | SOURCE_CHARACTER
    ;

// Source Text
// http://spec.graphql.org/June2018/#sec-Source-Text

fragment SOURCE_CHARACTER:
    [\u0009\u000A\u000D\u0020-\uFFFF];

// Ignored Tokens
// http://spec.graphql.org/June2018/#sec-Source-Text.Ignored-Tokens

UNICODE_BOM:
    '\uFEFF' -> skip;

WHITE_SPACE:
    [\u0009\u0020] -> skip;

LINE_TERMINATOR:
    // Specification is
    // - New Line (U+000A)
    // - Carrige Return (U+000D) [Lookahead != New Line (U+000A)]
    // - Carrige Return (U+000D) New Line (U+000A)
    [\u000A\u000D] -> skip;

COMMENT:
    // Specification is SourceCharacter but not LineTerminator.
    '#' [\u0009\u0020-\uFFFF]* -> skip;

COMMA:
    ',' -> skip;
