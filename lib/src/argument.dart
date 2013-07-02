//Copyright (C) 2012-2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart;

/**
 * Abstract argument.
 */
abstract class Argument<T> {
  final T value;
  
  Argument(this.value);
}

/**
 * Type reference argument.
 */
class TypeArgument<Type> extends Argument<Type> {
  TypeArgument(Type type) : super(type);
}

/**
 * String reference argument.
 */
class RefArgument<String> extends Argument<String> {
  RefArgument(String id) : super(id);
}

/**
 * Constant value argument.
 */
class ConstArgument<Dynamic> extends Argument<Dynamic> {
  ConstArgument(Dynamic value) : super(value);
}
