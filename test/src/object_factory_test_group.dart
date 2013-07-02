//Copyright (C) 2012-2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart_test;

/**
 * Group of tests of [ObjectDefinition] class.
 */
class ObjectFactoryTestGroup extends TestGroup {

  registerTests() {
    this.testGroupName = "ObjectFactory";

    this.testList["Create by FactoryFunction"] = createByFactoryFunctionTest;
    this.testList["Create by Type"] = createByTypeTest;
  }

  /**
   * Create an object instance.
   */
  void createByFactoryFunctionTest() {
    ObjectFactory factory = new ObjectFactory();
    Container container = new Container();
    ObjectDefinition od = new ObjectDefinition();
    od.factory = (){
      return new Baz("john");
    };
    var result = factory.create("1", container, od);
    ut.expect(result is Baz, true);
    ut.expect((result as Baz).name, ut.equals("john"));
  }

  /**
   * Create an object instance with parameters
   */
  void createByTypeTest() {
    ObjectFactory factory = new ObjectFactory();
    Container container = new Container();
    ObjectDefinition od = new ObjectDefinition();
    od.clazz = mirrors.reflectClass(Baz);
    od.props = {"name":new ConstArgument("john")};
    var result = factory.create("1", container, od);
    ut.expect(result is Baz, true);
    ut.expect((result as Baz).name, ut.equals("john"));
  }
}
