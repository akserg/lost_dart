//Copyright (C) 2012-2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

/**
 * Lost Dart is Inversion of Control Container implementation for Dart.
 */
library lost_dart;

import 'dart:mirrors' as mirrors;

part 'src/container.dart';
part 'src/binder.dart';
part 'src/scope.dart';
part 'src/exception.dart';
part 'src/object_definition.dart';
part 'src/object_factory.dart';
part 'src/argument.dart';

/**
 * Convert [type] qualified name to String.
 */
String typeToString(Type type) {
  assert(type != null);
  mirrors.ClassMirror classMirror = mirrors.reflectClass(type);
  return classMirror.qualifiedName.toString();
}