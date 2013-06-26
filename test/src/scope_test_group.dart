//Copyright (C) 2012-2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart_test;

/**
 * Test Scope values.
 */
class ScopeTestGroup extends TestGroup {

  registerTests() {
    this.testGroupName = "Scope";

    this.testList["verify"] = verifyTest;
  }

  /**
   * Varify scope accepts only [Scope.SINGLETON] and [PROTOTYPE] values.
   */
  void verifyTest() {
    ut.expect(Scope.validate(Scope.SINGLETON), ut.equals(true));
    ut.expect(Scope.validate(Scope.PROTOTYPE), ut.equals(true));
    ut.expect(Scope.validate("test"), ut.equals(false));
  }
}
