//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

/**
 * Demo application library.
 * Has an entry point into application.
 */

import 'package:lost_dart/lost_dart.dart';

class Baz{
  String name;
  
  Baz([this.name = '']);
}

class Bar{
  Baz baz;
  Bar(this.baz);
}

class Foo{
  Bar bar;
}

void main() {
  // Create IoC container
  Container container = new Container();
  // Create configuration
  Configuration config = new InCodeConfiguration()
    // Add Baz
    ..add("baz", (Container container, Map params){
      return new Baz(params['name']);
    })
    // Add Bar
    ..add("bar", (Container container, Map params){
      // Find baz
      Baz baz = container.resolve("baz");
      // Create Bar with constructor injection
      Bar bar = new Bar(baz);
      return bar;
    })
    ..add("foo", (Container container, Map params){
      // Create Foo
      Foo foo = new Foo();
      // Find bar
      Bar bar = container.resolve("bar");
      // Assign bar to foo - property injection
      foo.bar = bar;
      return foo;
    });
  // Add configuration
  container.add(config);
  // Check what we have
  Baz baz = container.resolve("baz", {'name':'Test'});
  print("Baz name ${baz.name}");
  
  Baz baz1 = container.resolve("baz");
  print("Baz1 name ${baz.name}");
  
  Bar bar = container.resolve("bar");
  print("Baz in Bar name ${bar.baz.name}");
}