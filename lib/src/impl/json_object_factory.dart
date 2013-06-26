//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart;

/**
 * [ObjectFactory] implementation for create and instances of object based on
 * [InCodeObjectDefinition].
 */
class JSONObjectFactory extends ObjectFactory {

  /**
   * Create an instance of [JSONObjectFactory].
   */
  JSONObjectFactory(ContainerConfiguration configuration) : super(configuration);

  /**
   * Create instance of object [id] based on information from [InCodeObjectDefinition].
   */
  dynamic create(String id, JSONObjectDefinition od, [Map params = null]) {
    if (params == null) {
      params = {};
    }
    
    mirrors.MirrorSystem mirrorSystem = mirrors.currentMirrorSystem();
    Symbol librarySymbol = new Symbol(od.library);
    Iterable<mirrors.LibraryMirror> libs = mirrorSystem.findLibrary(librarySymbol);
    if (libs.isNotEmpty) {
      mirrors.LibraryMirror libraryMirror = libs.single;
      Symbol classSymbol = new Symbol(od.clazz);
      if (libraryMirror.classes.containsKey(classSymbol)) {
        mirrors.ClassMirror classMirror = libraryMirror.classes[classSymbol];
        Symbol constructorSymbol = new Symbol(od.constructor);
        // Because named arguments does not supports now
        Map<Symbol, dynamic> namedArgumentsSymbol = null;
//        Map<Symbol, dynamic> namedArgumentsSymbol = new Map<Symbol, dynamic>();
//        if (od.namedArguments != null) {
//          od.namedArguments.forEach((String key, Object value){
//            namedArgumentsSymbol[new Symbol(key)] = value;
//          });
//        }
        mirrors.InstanceMirror instanceMirror = classMirror.newInstance(constructorSymbol, od.positionalArguments, namedArgumentsSymbol);
        return instanceMirror.reflectee;
      }
    }
    
    return null;
  }
}
