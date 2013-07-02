//Copyright (C) 2012-2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart;

/**
 * Exception thrown when we try to bind the same id.
 */
class BindDuplicateException implements Exception {
  /**
   * Bind id.
   */
  final String id;

  /**
   * Creates a new BindDuplicateException with an optional error [id].
   */
  const BindDuplicateException([this.id = ""]);

  /**
   * Print out the message.
   */
  String toString() => "Bind duplicate $id";
}

/**
 * Exception thrown when binder not found.
 */
class BinderNotFoundException implements Exception {
  /**
   * Binder id.
   */
  final String id;

  /**
   * Creates a new BinderNotFoundException with an optional error [id].
   */
  const BinderNotFoundException([this.id = ""]);

  String toString() => "Identifier '$id' was not bound";
}

/**
 * Exception thrown when instantiate object not found.
 */
class InstanceCreationException implements Exception {
  /**
   * Binder id.
   */
  final String id;

  /**
   * Creates a new InstanceCreationException with an optional error [id].
   */
  const InstanceCreationException([this.id = ""]);

  String toString() => "Can not create Instance by $id";
}

/**
 * Exception thrown when binding incorrect type.
 */
class IncorrectBindingTypeException implements Exception {
  /**
   * Message.
   */
  final String message;

  /**
   * Creates a new IncorrectBindingTypeException with an optional error [message].
   */
  const IncorrectBindingTypeException([this.message = ""]);

  String toString() => "$message";
}

/**
 * Exception thrown when argument type unsupport.
 */
class UnsupportArgumentTypeException implements Exception {
  /**
   * Argument.
   */
  final dynamic arg;

  /**
   * Creates a new UnsupportArgumentTypeException with an optional error [arg].
   */
  const UnsupportArgumentTypeException([this.arg = ""]);

  String toString() => "Unsupport argument type: $arg";
}
