//Copyright (C) 2012-2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

library example;

import 'package:lost_dart/lost_dart.dart';

void main() {
  // Create container
  Container container = new Container();
  
  // Bind Baz
  container.bind(Baz).addConstructorConstArg("story");
  // Bind Bar
  container.bind(Bar).addConstructorTypeArg(Baz);
  // Bind Foo
  container.bind(Foo).setTypeProperty("bar", Bar);
  
  // Resolve baz
  Baz baz = container.get(Baz);
  print(baz);
  Foo foo = container.get(Foo);
  print(foo);
}

// Somewhere in developing library
class Baz {
  String name;

  Baz([this.name = ""]);
}

class Bar {
  Baz baz;
  Bar(this.baz);
}

class Foo {
  Bar bar;
}

abstract class Weapon {
  String name;
  
  Weapon(this.name);
}

class Gun extends Weapon {
  Gun() : super("Gun");
}

class MachineGun extends Weapon {
  MachineGun() : super("Machine Gun");
}