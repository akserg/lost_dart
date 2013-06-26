//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart;

/**
 * That class realise JSON configuration.
 */
class JSONConfiguration extends InCodeConfiguration {

  static const String ID = "id";
  static const String LIBRARY = "library";
  static const String CLAZZ = "clazz";
  static const String CONSTRUCTOR = "constructor";
  
  
  /**
   * Creat an instance of JSONConfiguration with [jsonString] string.
   */
  JSONConfiguration(String jsonString) : super() {
    _process(jsonString);
  }
  
  /**
   * Process [jsonString] string.
   * 
   * Throws [FormatException] if the input is not valid JSON text.
   */
  void _process(String jsonString) {
    Map mapConfig = json.parse(jsonString);
    //
    String id = "";
    if (mapConfig.containsKey(ID)) {
      id = mapConfig[ID];
    }
    //
    String library = "";
    if (mapConfig.containsKey(LIBRARY)) {
      library = mapConfig[LIBRARY];
    }
    //
    String clazz = "";
    if (mapConfig.containsKey(CLAZZ)) {
      clazz = mapConfig[CLAZZ];
    }
    //
    String constructor = "";
    if (mapConfig.containsKey(CONSTRUCTOR)) {
      constructor = mapConfig[CONSTRUCTOR];
    }

    _add(id, library, clazz, constructor);
  }

  /**
   * Add _InstanceObject;
   */
  void _add(String id, String library, String clazz, String constructor, [String scope = Scope.SINGLETON, List positionalArguments = null, Map namedArguments = null]) {
    if (_inConfigs.containsKey(id)) {
      throw new FoundDuplicateConfigurationObjectException("Duplicate id '$id'");
    } else {
      if (Scope.validate(scope)) {
        _inConfigs[id] = new _ClassObject(library, clazz, constructor, _InstanceFunction, scope, positionalArguments, namedArguments);
      } else {
        throw new InvalidScopeException("Invalid scope '$scope'");
      }
    }
  }
  
  Object _InstanceFunction(Container c, Map params) {
    
  }
}

class _ClassObject extends _InstanceObject {
  String library;
  String clazz;
  String constructor;

  _ClassObject(this.library, this.clazz, this.constructor, InstanceFunction instanceFunction, String scope, List positionalArguments, Map namedArguments):
    super(instanceFunction, scope, positionalArguments, namedArguments);
}
