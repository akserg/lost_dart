//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart_test;

/**
 * Group of tests of [ObjectDefinition] class.
 */
class ObjectFactoryTestGroup extends TestGroup {

  registerTests() {
    this.testGroupName = "ObjectFactory";

    this.testList["Create an Object"] = createTest;
    this.testList["Create an Object with Parameters"] = createWithParamsTest;
  }

  /**
   * Create an object instance.
   */
  void createTest() {
    Container container = new Container();
    //
    InCodeObjectDefinition test = new InCodeObjectDefinition();
    test.instanceFunction = (Container c, Map params) {
      return new Baz("baz-test");
    };
    //
    Baz baz = container.configuration.create("first", test);
    ut.expect(baz != null, true);
    ut.expect(baz.name, ut.equals("baz-test"));
  }

  /**
   * Create an object instance with parameters
   */
  void createWithParamsTest() {
    Container container = new Container();
    //
    InCodeObjectDefinition test = new InCodeObjectDefinition();
    test.instanceFunction = (Container c, Map params) {
      return new Baz(params['name']);
    };
    //
    Baz baz = container.configuration.create("first", test, {'name':'baz-test'});
    ut.expect(baz != null, true);
    ut.expect(baz.name, ut.equals("baz-test"));
  }

}
