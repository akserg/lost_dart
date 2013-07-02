//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart_test;

class BinderTestGroup extends TestGroup {

  registerTests() {
    this.testGroupName = "Binder";

    this.testList["Instance"] = checkInstance;
  }

  /**
   * Check is [Cache] instance not equals null.
   */
  void checkInstance() {
    Container ctx = new Container();
    Binder binder = new Binder(ctx, "1");
    ut.expect(binder != null, true);
  }
}

