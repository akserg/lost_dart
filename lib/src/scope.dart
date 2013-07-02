//Copyright (C) 2012-2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart;

/**
 * Object definition scope.
 */
class Scope<String> {
  
  final String _value;
  
  const Scope(this._value);
  
  String get value => _value;

  /// SINGLETON scope
  static const Scope SINGLETON = const Scope("SINGLETON");
  /// PROTOTYPE scope
  static const Scope PROTOTYPE = const Scope("PROTOTYPE");
}
