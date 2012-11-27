//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart;

/**
 * Object definition scope.
 */
class Scope {
  static const String SINGLETON = "SINGLETON";
  static const String PROTOTYPE = "PROTOTYPE";
  
  /**
   * Check is scope equals [SINGLETON] or [PROTOTYPE].
   */
  static bool validate(String scope) {
    return scope == SINGLETON || scope == PROTOTYPE;
  }
}
