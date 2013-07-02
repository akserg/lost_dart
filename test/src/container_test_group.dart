//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart_test;

/**
 * Group of tests of [Container] class.
 */
class ContainerTestGroup extends TestGroup {

  registerTests() {
    this.testGroupName = "Container";

    this.testList["bind"] = bindTest;
    this.testList["bindType"] = bindTypeTest;
    this.testList["isExists"] = isExistsTest;
    this.testList["get"] = getTest;
    this.testList["getType"] = getTypeTest;
    this.testList["clean"] = cleanTest;

  }

  /**
   * Check test binding..
   */
  void bindTest() {
    Container container = new Container();
    container.bindAs("1");
    //
    ut.expect(container.isExistsAs("1"), true);
  }

  /**
   * Check type binding.
   */
  void bindTypeTest() {
    Container container = new Container();
    container.bind(Baz);
    //
    ut.expect(container.isExists(Baz), true);
  }

  /**
   * Check is bind exists.
   */
  void isExistsTest() {
    Container container = new Container();
    container.bindAs("1");
    //
    ut.expect(container.isExistsAs("1"), true);
  }

  /**
   * Check get method.
   */
  void getTest() {
    Container container = new Container();
    container.bindAs("1").to(Baz);
    var result = container.getAs("1");
    ut.expect(result is Baz, true);
  }
  
  /**
   * Check get Type method.
   */
  void getTypeTest() {
    Container container = new Container();
    container.bind(Baz).to(Baz);
    var result = container.get(Baz);
    ut.expect(result is Baz, true);
  }
  
  /**
   * Check how dos it clean.
   */
  void cleanTest() {
    Container container = new Container();
    container.bindAs("1");
    container.clean();
    //
    ut.expect(container.isExistsAs("1"), false);
  }
}