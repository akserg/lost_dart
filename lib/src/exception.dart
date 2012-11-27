//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart;

/**
 * Exception thrown when a object definition not found.
 */
class DefinitionNotFoundException implements Exception {
  /**
   * A message describing the error.
   */
  final String message;

  /**
   * Creates a new DefinitionNotFoundException with an optional error [message].
   */
  const DefinitionNotFoundException([this.message = ""]);

  String toString() => "DefinitionNotFoundException: $message";
}

/**
 * Exception thrown when duplicate object definition found.
 */
class FoundDuplicateDefinitionException implements Exception {
  /**
   * A message describing the error.
   */
  final String message;

  /**
   * Creates a new FoundDuplicateDefinitionException with an optional error [message].
   */
  const FoundDuplicateDefinitionException([this.message = ""]);

  String toString() => "FoundDuplicateDefinitionException: $message";
}

/**
 * Exception thrown when unknown configuration type found.
 */
class UnknownObjectDefinitionTypeException implements Exception {
  /**
   * A message describing the error.
   */
  final String message;

  /**
   * Creates a new UnknownObjectDefinitionTypeException with an optional error [message].
   */
  const UnknownObjectDefinitionTypeException([this.message = ""]);

  String toString() => "UnknownObjectDefinitionTypeException: $message";
}

/**
 * Exception thrown when duplicate configuration object found.
 */
class FoundDuplicateConfigurationObjectException implements Exception {
  /**
   * A message describing the error.
   */
  final String message;

  /**
   * Creates a new FoundDuplicateConfigurationObjectException with an optional error [message].
   */
  const FoundDuplicateConfigurationObjectException([this.message = ""]);

  String toString() => "FoundDuplicateConfigurationObjectException: $message";
}

/**
 * Exception thrown when configuration object not found.
 */
class ConfigurationObjectNotFoundException implements Exception {
  /**
   * A message describing the error.
   */
  final String message;

  /**
   * Creates a new ConfigurationObjectNotFoundException with an optional error [message].
   */
  const ConfigurationObjectNotFoundException([this.message = ""]);

  String toString() => "ConfigurationObjectNotFoundException: $message";
}

/**
 * Exception thrown when invalid scope found.
 */
class InvalidScopeException implements Exception {
  /**
   * A message describing the error.
   */
  final String message;

  /**
   * Creates a new InvalidScopeException with an optional error [message].
   */
  const InvalidScopeException([this.message = ""]);

  String toString() => "InvalidScopeException: $message";
}

/**
 * Exception thrown when unknown configuration type found.
 */
class UnknownConfigurationTypeException implements Exception {
  /**
   * A message describing the error.
   */
  final String message;

  /**
   * Creates a new UnknownConfigurationTypeException with an optional error [message].
   */
  const UnknownConfigurationTypeException([this.message = ""]);

  String toString() => "UnknownConfigurationTypeException: $message";
}

/**
 * Exception thrown when configuration object not found.
 */
class ContainerNotInitialisedException implements Exception {
  /**
   * A message describing the error.
   */
  final String message;

  /**
   * Creates a new ContainerNotInitialisedException with an optional error [message].
   */
  const ContainerNotInitialisedException([this.message = ""]);

  String toString() => "ContainerNotInitialisedException: $message";
}

/**
 * Exception thrown when class not found.
 */
class ClassNotFoundException implements Exception {
  /**
   * A message describing the error.
   */
  final String message;

  /**
   * Creates a new ClassNotFoundException with an optional error [message].
   */
  const ClassNotFoundException([this.message = ""]);

  String toString() => "ClassNotFoundException: $message";
}

/**
 * Exception thrown when library not found.
 */
class LibraryNotFoundException implements Exception {
  /**
   * A message describing the error.
   */
  final String message;

  /**
   * Creates a new LibraryNotFoundException with an optional error [message].
   */
  const LibraryNotFoundException([this.message = ""]);

  String toString() => "LibraryNotFoundException: $message";
}