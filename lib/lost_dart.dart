//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

/**
 * LostDart is Inversion of Control Container implementation for Dart.
 */
library lost_dart;

import 'dart:json' as json;
import 'dart:mirrors' as mirrors;

part 'src/exception.dart';
part 'src/scope.dart';
part 'src/configuration.dart';
part 'src/configuration_processor.dart';
part 'src/container.dart';
part 'src/container_configuration.dart';
part 'src/object_definition.dart';
part 'src/cache.dart';
part 'src/object_factory.dart';

// Implementation
part 'src/impl/default_container_configuration.dart';
part 'src/impl/in_code_configuration.dart';
part 'src/impl/in_code_configuration_processor.dart';
part 'src/impl/in_code_object_definition.dart';
part 'src/impl/in_code_object_factory.dart';

part 'src/impl/json_object_factory.dart';
part 'src/impl/json_object_definition.dart';
part 'src/impl/json_configuration.dart';
part 'src/impl/json_configuration_processor.dart';

/**
 * Identifies injectable constructors, methods, and fields
 */
class Inject {
  List<String> _args;
  
  Inject(args) {
    if (args != null) {
      if (args is String) {
        _args = [args as String];
      } else if (args is List<String>) {
        _args = args as List<String>;
      } else {
        throw new InjectionException("Argument type can be a String or array of String");
      }
    }
  }
}

/**
 * Exception thrown when injection problem happen.
 */
class InjectionException implements Exception {
  /**
   * A message describing the error.
   */
  final String message;

  /**
   * Creates a new InjectionException with an optional error [message].
   */
  const InjectionException([this.message = ""]);

  String toString() => "InjectionException: $message";
}