//Copyright (C) 2012-2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart;

/**
 * Dependency Injection container.
 */
class Container {
  
  /// Cache of definitions
  final Map<String, Binder> _definitions = new Map<String, Binder>();
  
  /// ObjectFActory
  final ObjectFactory _objectFactory = new ObjectFactory();
  
  /**
   * Create new context with [ObjectFactory].
   */
  Container();
  
  /**
   * Use [id] for binding new injection.
   */
  Binder bindAs(String id) {
    assert(id != null);
    if (isExistsAs(id)) {
      throw new BindDuplicateException(id);
    }
    // Create new Binder
    Binder binder = new Binder(this, id);
    // Save binder in cache
    _definitions[id] = binder;
    return binder;
  }
  
  /**
   * Use [id] for binding new injection.
   */
  Binder bind(Type type) {
    assert(type != null);
    Binder binder = bindAs(typeToString(type));
    binder.to(type);
    return binder;
  }
  
  /**
   * Bind all [types].
   */
  void bindAll(List<Type> types) {
    assert(types != null);
    types.forEach((Type type){
      bind(type);
    });
  }
  
  /**
   * Bind List to [id].
   */
  Binder bindAsList(String id) {
    assert(id != null);
    Binder binder = bindAs(id);
    binder._isList = true;
    binder.to(List);
    return binder;
  }
  
  /**
   * Bind Map to [id].
   */
  Binder bindAsMap(String id) {
    assert(id != null);
    Binder binder = bindAs(id);
    binder._isMap = true;
    binder.to(Map);
    return binder;
  }
  
  /**
   * Check is [type] object definition exists in [Container].
   */
  bool isExists(Type type) {
    assert(type != null);
    return _definitions.containsKey(typeToString(type));
  }
  
  /**
   * Check is [id] object definition exists in [Container].
   */
  bool isExistsAs(String id) {
    assert(id != null);
    return _definitions.containsKey(id);
  }
  
  /**
   * Return an instanse by [id].
   */
  dynamic getAs(String id) {
    assert(id != null);
    if (!isExistsAs(id)) {
      throw new BinderNotFoundException(id);
    }
    Binder binder = _definitions[id];
    if (binder._definition.scope == Scope.SINGLETON) {
      // Create new instance if necessary
      if (binder._definition.instance == null) {
        // Create new one
        binder._definition.instance = _objectFactory.create(id, this, binder._definition);
      }
    } else {
      // Create new instance each time when calling
      binder._definition.instance = _objectFactory.create(id, this, binder._definition);
    }
    return binder._definition.instance;
  }
  
  /**
   * Return an instanse by [id].
   */
  dynamic get(Type type) {
    assert(type != null);
    return getAs(typeToString(type));
  }
  
  /**
   * Change object definition key from [oldId] to [newId];
   */
  void _changeId(String oldId, String newId) {
    // Check does old id exists
    if (_definitions.containsKey(oldId)) {
      if (_definitions.containsKey(newId)) {
        throw new BindDuplicateException(newId);
      }
      Binder binder = _definitions[oldId];
      _definitions[newId] = binder;
    } else {
      throw new BinderNotFoundException(oldId);
    }
  }
  
  /**
   * Remove all instances.
   */
  void clean() {
    _definitions.clear();
  }
}