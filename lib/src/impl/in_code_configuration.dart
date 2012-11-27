//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart;

/**
 * That class realise 'in-code' configuration.
 */
class InCodeConfiguration extends Configuration {

  Map<String, _InstanceObject> _inConfigs = new Map<String, _InstanceObject>();

  /**
   * Add caller into configuration.
   */
  void add(String id, InstanceFunction caller, [String scope = Scope.SINGLETON, List positionalArguments = null, Map namedArguments = null]) {
    if (_inConfigs.containsKey(id)) {
      throw new FoundDuplicateConfigurationObjectException("Duplicate id '$id'");
    } else {
      if (Scope.validate(scope)) {
        _inConfigs[id] = new _InstanceObject(caller, scope, positionalArguments, namedArguments);
      } else {
        throw new InvalidScopeException("Invalid scope '$scope'");
      }
    }
  }

  /**
   * Remove caller from configuration.
   */
  void remove(String id) {
    if (_inConfigs.containsKey(id)) {
      _inConfigs.remove(id);
    } else {
      throw new ConfigurationObjectNotFoundException("Id '$id' not found.");
    }
  }

  /**
   * Return objects map.
   */
  Map get objects => _inConfigs;
}

class _InstanceObject {
  InstanceFunction instanceFunction;
  String scope = Scope.SINGLETON;
  List positionalArguments;
  Map namedArguments;
  
  _InstanceObject(this.instanceFunction, this.scope, this.positionalArguments, this.namedArguments);
}
