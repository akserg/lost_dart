//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart;

/**
 * Type of object definition using library and class nmae to create an instance of
 * object.
 */
class JSONObjectDefinition extends ObjectDefinition {

  /// Instance function
  String library;
  
  /// Class name
  String clazz;
  
  /// Construcor name
  String constructor;

  /// Positional arguments
  List positionalArguments = [];
  
  /// Named arguments using to pass arguments into constructor
  Map namedArguments;
}
