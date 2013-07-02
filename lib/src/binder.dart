//Copyright (C) 2012-2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart;

/**
 * The FunctionFactory.
 */
typedef dynamic FunctionFactory();

/**
 * That class use to bind unique identifier or type 
 * to an instance of class defined in [ObjectDefinition].
 */
class Binder<T> {

  /// Reference id in container.
  String _id;
  
  /// Object Definition
  final ObjectDefinition _definition;
  
  /// Binding container
  final Container _container;
  
  /**
   * Create new Binder in [container].
   */
  Binder(this._container, this._id) : _definition = new ObjectDefinition();

  
  /**
   * Mark class as Prototype.
   */
  Binder asPrototype() {
    _definition.scope = Scope.PROTOTYPE;
    return this;
  }
  
  /**
   * Name binding with specified [id].
   */
  Binder named(String id) {
    assert(id != null);
    _container._changeId(this._id, id);
  }
  
  //*********
  // Property
  //*********
  
  /**
   * Set type property.
   */
  Binder setTypeProperty(String property, Type type) {
    assert(type != null);
    _definition.props[property] = new TypeArgument(type);
    return this;
  }
  
  /**
   * Set reference property.
   */
  Binder setRefProperty(String property, String id) {
    assert(id != null);
    _definition.props[property] = new RefArgument(id);
    return this;
  }
  
  /**
   * Set const property.
   */
  Binder setConstProperty(String property, dynamic value) {
    assert(value != null);
    _definition.props[property] = new ConstArgument(value);
    return this;
  }
  
  //*************************
  // Function Factory binding
  //*************************
  
  /**
   * Bind to [FunctionFactory].
   */
  Binder toFactory(FunctionFactory functionFactory) {
    assert(functionFactory != null);
    _definition.factory = functionFactory;
    return this;
  }
  
  //*************
  // Type binding
  //*************
  
  /**
   * Bind to Runtime Type.
   */
  Binder to(Type type) {
    assert(type != null);
    _definition.clazz = mirrors.reflectClass(type);
    return this;
  }
  
  /**
   * Use constructor name for type binding.
   * Use only for [to] method.
   */
  Binder withConstructorName(String constructorName) {
    assert(constructorName != null);
    _definition.constructorName = new Symbol(constructorName);
    return this;
  }
  
  /**
   * Add type constructor argument.
   */
  Binder addConstructorTypeArg(Type type) {
    assert(type != null);
    _definition.constructorArgs.add(new TypeArgument(type));
    return this;
  }
  
  /**
   * Add reference constructor argument.
   */
  Binder addConstructorRefArg(String id) {
    assert(id != null);
    _definition.constructorArgs.add(new RefArgument(id));
    return this;
  }
  
  /**
   * Add const constructor argument.
   */
  Binder addConstructorConstArg(dynamic value) {
    assert(value != null);
    _definition.constructorArgs.add(new ConstArgument(value));
    return this;
  }
}