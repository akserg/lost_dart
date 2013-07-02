//Copyright (C) 2012-2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart;

/**
 * Universal form of object definition.
 */
class ObjectDefinition {
  
  /// Object instantiation scope. It is [Scope.SINGLETON] by default.
  Scope scope = Scope.SINGLETON;

  /// Attribute tells when singleton instance will created.
  bool isLazy = true;

  /// Type instance.
  dynamic instance;
  
  //********
  // General
  //********
  
  /// Class instanse properties
  Map props = {};
  
  //*****************
  // Function Factory
  //*****************
  
  /// Factory function for 
  FunctionFactory factory;
  
  //***************
  // Function Class
  //***************
  
  /// Class Mirror
  mirrors.ClassMirror clazz;
  
  /// Constructor name
  Symbol constructorName = new Symbol("");
  
  /// Constructor positional arguments
  List<dynamic> constructorArgs = new List<dynamic>();
}