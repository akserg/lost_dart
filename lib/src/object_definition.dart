//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart;

/**
 * Universal form of object definition.
 */
abstract class ObjectDefinition {

  /// Object instantiation scope. It is Singleton by default.
  String scope = Scope.SINGLETON;

  /// Attribute tells when singleton instance will created.
  bool isLazy = true;

  /// Type instance.
  dynamic instance;
}
