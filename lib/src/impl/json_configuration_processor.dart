//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart;

/**
 * Implementation of [ConfigurationProcessor] using to process
 * [InCodeConfiguration].
 */
class JSONConfigurationProcessor extends ConfigurationProcessor {

  /**
   * Create an instanbce of [JSONConfigurationProcessor].
   */
  JSONConfigurationProcessor(ContainerConfiguration configuration) : super(configuration);

  /**
   * Process each configuration and generate ObjectDefinition per item.
   */
  void _process(JSONConfiguration config) {
    // Pass through each object in configuration
    config.objects.forEach((String id, _ClassObject instanceObject) {
      // Create instance of empty JSONObjectDefinition
      JSONObjectDefinition od = new JSONObjectDefinition();
      // It keeps reference on library
      od.library = instanceObject.library;
      // It keeps reference on clazz
      od.clazz = instanceObject.clazz;
      // It keeps reference on clazz constructor
      od.constructor = instanceObject.constructor;
      // Specify attributes like scope here
      od.scope = instanceObject.scope;
      // Add definition into cache
      configuration.cache.add(id, od);
    });
  }

}
