//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart;

/**
 * Class using to process configuration.
 */
abstract class ConfigurationProcessor {

  /// Container Configuration
  ContainerConfiguration _configuration;
  
  /// Return Container Configuration
  ContainerConfiguration get configuration => _configuration;

  /**
   * Create an instanbce of [ConfigurationProcessor].
   */
  ConfigurationProcessor(this._configuration);

  /**
   * Add configuration into configuration list.
   */
  void add(Configuration config) {
    assert(config != null);
    _process(config);
  }

  /**
   * Add list of configuration into configuration.
   */
  void addAll(List<Configuration> configs) {
    assert(configs != null);
    configs.forEach((Configuration config) => _process(config));
  }

  /**
   * Process each configuration and generate ObjectDefinition per item.
   */
  void _process(Configuration config);
}
