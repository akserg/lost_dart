##Lost Dart

Lost Dart is lightweight dependency injection framework for Dart client and server applications.

[![](https://drone.io/akserg/lost_dart/status.png)](https://drone.io/akserg/lost_dart/latest)

It helps you split your application into a collection of loosely-coupled pieces and then glue them back together in a flexible manner. Its aim is to make wide range of Dart applications easier to:

* Manage source code;
* Encouraging code modularisation;
* Separations of concerns;
* Good unit testing practices.

###Set up

Lost Dart is available under the `lost_dart` pub package. Simply add a dependency to your `pubspec.yaml` file:

```
...
dependencies:
  lost_dart: any
``` 

Then run `pub install` and you will have everything you need to get started.

##The core concepts of Lost Dart by examples

###Instantiation

A simple example of using the Lost Dart is that to construct an instance of an object. 

```
import 'package:lost_dart/lost_dart.dart';

// Class Baz
class Baz {
  String name;

  Baz([this.name = ""]);
}

void main() {
  // Create container
  Container container = new Container();

  // Bind Baz
  container.bind(Baz);
  container.bindAs("baz2").to(Baz);

  // Resolve baz by type
  Baz baz = container.get(Baz);
  Baz baz2 = container.getAs("baz2");

  assert(baz.name == "");
  assert(baz2.name == "");
}
```

###Inheritance

You may get an instance of an interface via implementation class:

```
import 'package:lost_dart/lost_dart.dart';

// Class Baz
abstract class Baz {
  Baz(String name);
  
  String doBaz(int baz);
}

class Bar implements Baz {
  String name;
  
  Bar(this.name);
  
  String doBaz(int baz) {
    return name += ' ' + baz.toString();
  }
}

void main() {
  // Create container
  Container container = new Container();

  // Bind Baz with Bar implementation
  container.bind(Baz).to(Bar).addConstructorConstArg('Baz');

  // Resolve baz by type
  Baz baz = container.get(Baz);

  assert(baz.doBaz(1) == "Baz 1");
}
```


###Constructor injection: Constant arguments

Constant values are set an constructor argument:

```
import 'package:lost_dart/lost_dart.dart';

// Class Baz
class Baz {
  String name;
  int number = 22;
  
  Baz([this.name = ""]);
}

void main() {
  // Create IoC container
  Container container = new Container();
  // Bind Baz
  container.bind(Baz).addConstructorConstArg("Test");
  container.bindAs("baz2").to(Baz).addConstructorConstArg("Test2");

  // Resolve baz
  Baz baz = container.get(Baz);
  Baz baz2 = container.getAs("baz2");

  // Test result
  assert(baz.name == "Test");
  assert(baz2.name == "Test2");
}
```

###Constructor injection: Dependencies

A tree of dependencies are instantiated and injected using the constructor argument:

```
import 'package:lost_dart/lost_dart.dart';

// application code
class Baz {
  String name;
  int number = 22;

  Baz([this.name = "99"]);
}

class Bar {
  Baz baz;
  Bar(this.baz);
}


void main() {
  // Create IoC container
  Container container = new Container();

  container.bind(Baz);
  container.bind(Bar).addConstructorTypeArg(Baz);
  container.bindAs("bar2").to(Bar).addConstructorTypeArg(Baz);

  // Resolve bar
  Bar bar = container.get(Bar);
  Bar bar2 = container.getAs("bar2");

  // Test result of bar
  assert(bar != null);
  assert(bar.baz.name == "99");
  assert(bar2 != null);
  assert(bar2.baz.name == "99");
  assert(bar.baz == bar.baz);
}
```

###Property injection: Constant values

Constant values are set in the property:

```
import 'package:lost_dart/lost_dart.dart';

// application code
class Baz {
  String name;
  int number = 22;

  Baz([this.name = "99"]);
}

void main() {
  // Create IoC container
  Container container = new Container();

  // Bind Baz
  container.bind(Baz).setConstProperty("number", 33);
  container.bindAs("baz2").to(Baz).setConstProperty("number", 44);

  // Resolve baz
  Baz baz = container.get(Baz);
  Baz baz2 = container.getAs("baz2");
  
  // Test result
  assert(baz.number == 33);
  assert(baz2.number == 44);
}
```

###Property injection: Dependencies

A tree of dependencies are instantiated and injected using the property:

```
import 'package:lost_dart/lost_dart.dart';

// application code
class Baz {
  String name;

  Baz([this.name = "99"]);
}

class Bar {
  Baz baz;

  Bar();
}

void main() {

  // Create IoC container
  Container container = new Container();

  // Bind Baz
  container.bind(Baz);

  // Bind Bar
  container.bind(Bar).setTypeProperty("baz", Baz);
  container.bindAs("bar2").to(Bar).setTypeProperty("baz", Baz);

  // Resolve bar
  Bar bar = container.get(Bar);
  Bar bar2 = container.getAs("bar2");
  
  // Test result
  assert(bar.baz.name == bar2.baz.name);
}
```

###Factory methods

The Factory methods have maximum flexibility to generate any type of injected values:

```
import 'package:lost_dart/lost_dart.dart';

//application code
class Network {
  String uri;
  
  Network(this.uri);
}

class User {
  String name;
}

class Manager {
  Network network;
  User user;

  Manager(this.user);
}

void main() {
  // Create IoC container
  Container container = new Container();

  // Add host
  container.bindAs("host").toFactory((){
    return "http://127.0.0.1";
  });
  
  // Add Network
  container.bind(Network).addConstructorRefArg("host");
  
  // Add User
  container.bind(User).setConstProperty("name", "Admin");
  
  // Add Manager
  container.bind(Manager).toFactory((){
    Manager bar = new Manager(container.get(User));
    bar.network = container.get(Network);
    return bar;
  });
  
  // Resolve Manager
  Manager manager = container.get(Manager);

  // Test result
  assert(manager.network.uri == "http://127.0.0.1");
  assert(manager.user.name == "Admin");
}
```

###Object scopes

Lost Dart supports two scopes: `singleton` and `prototype`. The first is used by default and does not need to be explicitly specified in binding.
You may mark an object definition as `prototype` with method `asPrototype` and `Container` will return a new instance of prototype on each call of method `get`:

```
import 'package:lost_dart/lost_dart.dart';

//application code
class Baz {}

void main() {
  // Create IoC container
  Container container = new Container();
  
  // Add Baz
  container.bind(Baz).asPrototype();
  
  // Resolve baz - "prototype" scope.
  Baz baz = container.get(Baz);
  Baz baz1 = container.get(Baz);
  // Test prototype result
  assert(baz != baz1);
}
```

###Batch binding

To add an array of types in a `Container` you can use the `bindAll` method:

```
import 'package:lost_dart/lost_dart.dart';

class Baz {}

class Bar {}

class Foo {}

void main() {
  Container container = new Container();

  container.bindAll([Baz, Bar, Foo]);

  Foo foo = container.get(Foo);

  assert(foo != null);
}
```

###Multi injection

Lost Dart allows you to inject multiple objects bound to a particular type or interface. There are `Weapon` interface, and two implementations `Sword` and `Dagger`.
The constructor of `Samurai` class takes an array of `Weapon`. The `toFactory` method of `Binder` class returns the list of `Weapons` to be used in `Samurai` constructor:

```
import 'package:lost_dart/lost_dart.dart';

// Asbtract class Weapon
abstract class Weapon {
   // Hit the [target].
  String Hit(String target);
}

// Sword Weapon
class Sword implements Weapon {
  // Hit the [target].
  String Hit(String target) {
    return "Slice " + target + " in half";
  }
}

// Dagger Weapon
class Dagger implements Weapon {
   // Hit the [target].
  String Hit(String target) {
    return "Stab " + target + " to death";
  }
}

// Samurai fully equipped.
class Samurai {
  List<Weapon> allWeapons;

  Samurai(List<Weapon> this.allWeapons); 

  // Just attack the [target].
  void Attack(String target) {
    for (Weapon weapon in this.allWeapons) {
      print(weapon.Hit(target));
    }
  }
}

void main() {
  Container container = new Container();
  
  // Bind Sword
  container.bind(Sword);
  // Bind Sword
  container.bind(Dagger);
  // Bind weapons as list
  container.bindAs("weapons").toFactory(() {
    return [container.get(Sword), container.get(Dagger)];
  });
  
  
  // Bind Samurai with list of weapons
  container.bind(Samurai).addConstructorRefArg("weapons");
  
  
  // Get samurai 
  Samurai samurai = container.get(Samurai);
  // Atack
  samurai.Attack("your enemy");
}
```
