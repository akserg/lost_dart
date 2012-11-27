//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart_test;

class CacheTestGroup extends TestGroup {

  registerTests() {
    this.testGroupName = "Cache";

    this.testList["Instance"] = checkInstance;
    this.testList["Add and Find object definition"] = addObjectDefinitionTest;
    this.testList["Add and Resolve"] = resolveTest;
    this.testList["Add and Resolve with Params"] = resolveWithParamsTest;
    this.testList["Clear"] = clearTest;
  }

  /**
   * Check is [Cache] instance not equals null.
   */
  void checkInstance() {
    Container container = new Container();
    ut.expect(container.configuration.cache != null, true);
  }
  
  /**
   * Add and find object definition.
   */
  void addObjectDefinitionTest() {
    Container container = new Container();
    //
    InCodeObjectDefinition test = new InCodeObjectDefinition();
    container.configuration.cache.add("first", test);
    //
    InCodeObjectDefinition test1 = container.configuration.cache.find("first");
    ut.expect(test1, ut.equals(test));
  }
  
  /**
   * Resolve object.
   */
  void resolveTest() {
    Container container = new Container();
    //
    InCodeObjectDefinition test = new InCodeObjectDefinition();
    test.instanceFunction = fun(Container c, Map params) {
      return new Baz("baz-test");
    };
    container.configuration.cache.add("first", test);
    //
    Baz baz = container.configuration.cache.resolve("first");
    ut.expect(baz != null, true);
    ut.expect(baz.name, ut.equals("baz-test"));
  }
  
  /**
   * Resolve Object with params.
   */
  void resolveWithParamsTest() {
    Container container = new Container();
    //
    InCodeObjectDefinition test = new InCodeObjectDefinition();
    test.instanceFunction = fun(Container c, Map params) {
      return new Baz(params['name']);
    };
    container.configuration.cache.add("first", test);
    //
    Baz baz = container.configuration.cache.resolve("first", {'name':'baz-test'});
    ut.expect(baz != null, true);
    ut.expect(baz.name, ut.equals("baz-test"));
  }
  
  /**
   * Check clear method.
   */
  void clearTest() {
    Container container = new Container();
    //
    InCodeObjectDefinition test = new InCodeObjectDefinition();
    test.instanceFunction = fun(Container c, Map params) {
      return new Baz(params['name']);
    };
    container.configuration.cache.add("first", test);
    //
    container.configuration.cache.clear();
    //
    try {
      InCodeObjectDefinition test1 = container.configuration.cache.find("first");
    } on DefinitionNotFoundException catch(e) {
      ut.expect(e is DefinitionNotFoundException, true);
    }
  }
}

