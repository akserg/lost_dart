//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart;

/**
 * This class manages container configuration and tight different parts of
 * IoC container in one place.
 */
abstract class ContainerConfiguration {

  /// Reference on Container
  Container _container;

  /// Return [Container].
  Container get container => _container;

  /**
   * Set new [Container]. It runs [_initialise] method to start initialization
   * process through meth
   */
  void set container(Container value) {
    assert(value != null);
    _container = value;
    //
    _initialise();
  }

  /**
   * Initialise container configuration
   */
  void _initialise();

  /**
   * Add configuration into configuration list.
   */
  void add(Configuration config);

  /**
   * Add list of configuration into configuration.
   */
  void addAll(List<Configuration> configs);

  /**
   * Return Cache.
   */
  Cache get cache;

  /**
   * Create instance of object [id] based on information from [ObjectDefinition].
   */
  dynamic create(String id, ObjectDefinition od, [Map params = null]);
}
