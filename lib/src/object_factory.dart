//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart;

/**
 * Factory of Objects.
 */
abstract class ObjectFactory {

  ContainerConfiguration _configuration;
  
  ContainerConfiguration get configuration => _configuration;

  /**
   * Create an instance of [ObjectFactory].
   */
  ObjectFactory(this._configuration);
  
  /**
   * Create instance of object [id] based on information from [ObjectDefinition].
   */
  dynamic create(String id, ObjectDefinition od, [Map params = null]);
}