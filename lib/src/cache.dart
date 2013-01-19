//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart;

/**
 * Cache keeps ObjectDefinitins and Singleton instances.
 */
class Cache {
  Map<String, ObjectDefinition> _objectDefinitions = {};

  ContainerConfiguration _configuration;

  ContainerConfiguration get configuration => _configuration;

  /**
   * Create an instance of [Cache].
   */
  Cache(this._configuration);

  /**
   * Add ObjectDefinition into cache by id.
   */
  void add(String id, ObjectDefinition od) {
    assert(id != null);
    assert(od != null);
    // Prevent duplicates
    if (_objectDefinitions.containsKey(id)) {
      throw new FoundDuplicateDefinitionException("Found duplicate '$id' for object definition.");
    }
    // Add od into map
    _objectDefinitions[id] = od;
    // Checkis object deinition for singleton
    if (od.scope == Scope.SINGLETON && !od.isLazy) {
      od.instance = configuration.create(id, od);
    }
  }

  /**
   * Find ObjectDefinition by id.
   */
  ObjectDefinition find(String id) {
    if (_objectDefinitions.containsKey(id)) {
      return _objectDefinitions[id];
    } else {
      throw new DefinitionNotFoundException("Object definition by '$id' was not found.");
    }
  }

  /**
   * Resolve object by id
   */
  dynamic resolve(String id, [Map params = null]) {
    if (_objectDefinitions.containsKey(id)) {
      ObjectDefinition od = _objectDefinitions[id];
      if (od.scope == Scope.SINGLETON) {
        if (od.instance == null) {
          // Create singleton instance
          od.instance = configuration.create(id, od, params);
        }
        // Return singleton instance
        return od.instance;
      } else {
        // Create instance
        return configuration.create(id, od, params);
      }
    } else {
      throw new DefinitionNotFoundException("Object definition by '$id' was not found.");
    }
  }

  /**
   * Clear object definition map.
   */
  void clear() {
    _objectDefinitions.clear();
  }
}