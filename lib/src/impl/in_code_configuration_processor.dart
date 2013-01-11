//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart;

/**
 * Implementation of [ConfigurationProcessor] using to process 
 * [InCodeConfiguration].
 */
class InCodeConfigurationProcessor extends ConfigurationProcessor {
  
  /**
   * Create an instanbce of [InCodeConfigurationProcessor].
   */
  InCodeConfigurationProcessor(ContainerConfiguration configuration) : super(configuration);
  
  /**
   * Process each configuration and generate ObjectDefinition per item.
   */
  void _process(InCodeConfiguration config) {
    config.objects.forEach((String id, _InstanceObject value) {
      // Pass through each object in configuration
      _InstanceObject instanceObject = value;
      // Create instance of empty InCodeObjectDefinition
      InCodeObjectDefinition od = new InCodeObjectDefinition();
      // It keeps reference on instance function
      od.instanceFunction = instanceObject.instanceFunction;
      // Specify attributes like scope here
      od.scope = instanceObject.scope;
      // Add definition into cache
      configuration.cache.add(id, od);
    });
  }
  
}
