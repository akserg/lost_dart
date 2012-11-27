//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart;

/**
 * [ObjectFactory] implementation for create and instances of object based on
 * [InCodeObjectDefinition].
 */
class InCodeObjectFactory extends ObjectFactory {
  
  /**
   * Create an instance of [InCodeObjectFactory].
   */
  InCodeObjectFactory(ContainerConfiguration configuration) : super(configuration);
  
  /**
   * Create instance of object [id] based on information from [InCodeObjectDefinition].
   */
  dynamic create(String id, InCodeObjectDefinition od, [Map params = null]) {
    if (params == null) {
      params = {};
    }
    return od.instanceFunction(configuration.container, params);
  }
}
