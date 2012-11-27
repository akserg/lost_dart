//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart;

/**
 * Default implementation of ContainerConfiguration.
 */
class DefaultContainerConfiguration extends ContainerConfiguration {
  
  const String IN_CODE_CONFIGURATION = "InCodeConfiguration";
  
  Map<String, ConfigurationProcessor> _configurationProcessor;
  Cache _cache;
  Map<String, ObjectFactory> _objectFactories;
  
  /**
   * Initialise container configuration
   */
  void _initialise() {
    _configurationProcessor = new Map<String, ConfigurationProcessor>();
    _configurationProcessor[IN_CODE_CONFIGURATION] = new InCodeConfigurationProcessor(this);
    //
    _cache = new Cache(this);
    //
    _objectFactories = new Map<String, ObjectFactory>();
    _objectFactories[IN_CODE_CONFIGURATION] = new InCodeObjectFactory(this);
  }
  
  /**
   * Add configuration into configuration list.
   */
  void add(Configuration config) {
    assert(config != null);
    if (config is InCodeConfiguration) {
      _configurationProcessor[IN_CODE_CONFIGURATION]._process(config);
    } else {
      throw new UnknownConfigurationTypeException("Unknown configuration type '${config.toString()}");
    }
  }
  
  /**
   * Add list of configuration into configuration.
   */
  void addAll(List<Configuration> configs) {
    assert(configs != null);
    configs.forEach(fun(Configuration config){
      add(config);
    });
  }
  
  /**
   * Return Cache.
   */
  Cache get cache => _cache;
  
  /**
   * Create instance of object [id] based on information from [ObjectDefinition].
   */
  dynamic create(String id, ObjectDefinition od, [Map params = null]) {
    if (od is InCodeObjectDefinition) {
      return _objectFactories[IN_CODE_CONFIGURATION].create(id, od, params);
    } else {
      throw new UnknownObjectDefinitionTypeException("Unknown type of ObjectDefinition: ${od.toString()}");
    }
  }
}
