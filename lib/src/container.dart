//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart;

/**
 * IoC container.
 */
class Container {
  
  /// Container configuration
  ContainerConfiguration _configuration;
  
  /// Return current container configuration
  ContainerConfiguration get configuration => _configuration;
  
  /**
   *  Create an instance of Container.
   *  If [ContainerConfiguration] not specified - 
   */
  Container([this._configuration = null]) {
    if (_configuration == null) {
      // Get default one
      _configuration = new DefaultContainerConfiguration();
    }
    _configuration.container = this;
  }

  /**
   * Add configuration into configuration list.
   */
  void add(Configuration config) {
    _configuration.add(config);
  }
  
  /**
   * Add list of configuration into configuration.
   */
  void addAll(List<Configuration> configs) {
    _configuration.addAll(configs);
  }
  
  /**
   * Find or create object by id.
   */
  dynamic resolve(String id, [Map params = null]) {
    return _configuration.cache.resolve(id, params);
  }
}
