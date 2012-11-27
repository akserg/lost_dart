//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart;

/**
 * Type definition for function using in conjuction with 
 * [InCodeObjectDefinition].
 */
typedef Object InstanceFunction(Container c, Map params);


/**
 * Type of object definition using InstanceFunction ot create an instance of
 * object.
 */
class InCodeObjectDefinition extends ObjectDefinition {

  /// Instance function
  InstanceFunction instanceFunction;
  
  /// Named arguments using to pass arguments into InstanceFunction
  Map namedArguments;
}
