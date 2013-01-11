//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart_test;

/**
 * Group of tests of [Configuraton] class.
 */
class ConfigurationTestGroup extends TestGroup {

  registerTests() {
    this.testGroupName = "Configuration";

    this.testList["InCodeConfiguration addObject"] = inCodeConfigurationAddObjectTest;
    this.testList["InCodeConfiguration removeObject"] = inCodeConfigurationRemoveObjectTest;
    this.testList["Add Config"] = addConfigTest;
    this.testList["Add Configs"] = addConfigsTest;
    
  }

  /**
   * Check in code configuration add object.
   */
  void inCodeConfigurationAddObjectTest() {
    InCodeConfiguration config = new InCodeConfiguration();
    config.add("id1", (Container c, Map params){
      return new Baz();
    });
    //
    ut.expect(config.objects.containsKey("id1"), true);
  }
  
  /**
   * Check in code configuration remove object.
   */
  void inCodeConfigurationRemoveObjectTest() {
    InCodeConfiguration config = new InCodeConfiguration();
    config.add("id1", (Container c, Map params){
      return new Baz();
    });
    //
    config.remove("id1");
    ut.expect(config.objects.containsKey("id1"), false);
  }
  
  /**
   * Check add config method.
   */
  void addConfigTest() {
    Container container = new Container();
    //
    InCodeConfiguration config = new InCodeConfiguration();
    config.add("first", (Container c, Map params){
      return new Baz("baz-test");
    });
    container.configuration.add(config);
    //
    Baz baz = container.resolve("first");
    ut.expect(baz != null, true);
    ut.expect(baz.name, ut.equals("baz-test"));
  }
  
  /**
   * Check add configs method.
   */
  void addConfigsTest() {
    Container container = new Container();
    //
    InCodeConfiguration config = new InCodeConfiguration();
    config.add("first", (Container c, Map params){
      return new Baz("baz-test");
    });
    InCodeConfiguration config2 = new InCodeConfiguration();
    config.add("second", (Container c, Map params){
      return new Baz("baz-test 2");
    });
    container.configuration.addAll([config, config2]);
    //
    Baz baz = container.resolve("first");
    ut.expect(baz != null, true);
    ut.expect(baz.name, ut.equals("baz-test"));
    //
    Baz baz2 = container.resolve("second");
    ut.expect(baz2 != null, true);
    ut.expect(baz2.name, ut.equals("baz-test 2"));
  }
}


