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
  
  /// Flag mark binder as list
  bool _isList = false;
  
  /// Flag mark binder as map
  bool _isMap = false;
  
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
  
  //*************
  // List binding
  //*************
  
  /**
   * Add [type] to list binder.
   */
  Binder addTypeToList(Type type) {
    assert(type != null);
    if (!_isList) {
      throw new IncorrectBindingTypeException("That method only of list binder.");
    }
    return addConstructorTypeArg(type);
  }
  
  /**
   * Add [id] reference to list binder.
   */
  Binder addRefToList(String id) {
    assert(id != null);
    if (!_isList) {
      throw new IncorrectBindingTypeException("That method only of list binder.");
    }
    return addConstructorRefArg(id);
  }
  
  /**
   * Add dynamic [value] to list binder.
   */
  Binder addConstToList(dynamic value) {
    assert(value != null);
    if (!_isList) {
      throw new IncorrectBindingTypeException("That method only of list binder.");
    }
    return addConstructorConstArg(value);
  }
  
  /**
   * Add list of [types] to list.
   */
  Binder addAllTypesToList(List<Type> types) {
    assert(types != null);
    types.forEach((Type type){
      addTypeToList(type);
    });
  }
  
  /**
   * Add list of [id] to list.
   */
  Binder addAllRefsToList(List<String> ids) {
    assert(ids != null);
    ids.forEach((String id){
      addRefToList(id);
    });
  }
  
  /**
   * Add list of constant [value] to list.
   */
  Binder addAllConstsToList(List<dynamic> values) {
    assert(values != null);
    values.forEach((dynamic value){
      addConstToList(value);
    });
  }
  
  //*************
  // Map binding
  //*************
  
  /**
   * Add [property] - [type] to map binder.
   */
  Binder addTypeToMap(String property, Type type) {
    assert(type != null);
    if (!_isMap) {
      throw new IncorrectBindingTypeException("That method only of map binder.");
    }
    return setTypeProperty(property, type);
  }
  
  /**
   * Add [property] - [id] reference to map binder.
   */
  Binder addRefToMap(String property, String id) {
    assert(id != null);
    if (!_isList) {
      throw new IncorrectBindingTypeException("That method only of map binder.");
    }
    return setRefProperty(property, id);
  }
  
  /**
   * Add [property] - dynamic [value] to map binder.
   */
  Binder addConstToMap(String property, dynamic value) {
    assert(value != null);
    if (!_isList) {
      throw new IncorrectBindingTypeException("That method only of map binder.");
    }
    return setConstProperty(property, value);
  }
}