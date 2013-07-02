##Lost Dart

Lost Dart is lightweight dependency injection framework for Dart client and server applications.

[![](https://drone.io/akserg/lost_dart/status.png)](https://drone.io/akserg/lost_dart/latest)

It helps you split your application into a collection of loosely-coupled pieces and then glue them back together in a flexible manner. Its aim is to make wide range of Dart applications easier to:
* Manage source code;
* Encouraging code modularisation;
* Separations of concerns;
* Good unit testing practices.

###Set up
Lost Dart is available under the lost_dart pub package. Simply add a dependency to your pubspec.yaml file:

<pre class="syntax brush-javascript">
...
dependencies:
  lost_dart: any
</pre> 

Then run pub install and you’ll have everything you need to get started.

##The core concepts of Lost Dart by examples

###Instantiation

A simple example of using the Lost Dart is that to construct an instance of an object. 

<pre class="syntax brush-javascript">
import 'package:lost_dart/lost_dart.dart';

// Class Baz
class Baz{
  String name;
  
  Baz([this.name = ""]);
}

void main() {
  // Create container
  Container container = new Container();
  
  // Bind Baz
  container.bind(Baz);
  
  // Resolve baz by type
  Baz baz = container.get(Baz);
  assert(baz != null);
  assert(baz.name == "");
}
</pre>

###Constructor injection: Constant arguments

Constant values are set an constructor argument:

<pre class="syntax brush-javascript">
import 'package:lost_dart/lost_dart.dart';

// Class Baz
class Baz{
  String name;
  int number = 22;
  
  Baz([this.name = ""]);
}

void main() {
  // Create IoC container
  Container container = new Container();
  // Bind Baz
  container.bind(Baz).addConstructorConstArg("Test");

  // Resolve baz
  Baz baz = container.get(Baz);

  // Test result
  assert(baz.name == "Test");
}
</pre>

###Constructor injection: Dependencies

A tree of dependencies are instantiated and injected using the constructor argument or property:

<pre class="syntax brush-javascript">
import 'package:lost_dart/lost_dart.dart';

// application code
class Baz{
  String name;
  int number = 22;

  Baz([this.name = "99"]);
}

class Bar{
  Baz baz;
  Bar(this.baz);
}


void main() {
  // Create IoC container
  Container container = new Container();

  container.bind(Baz);
  container.bind(Bar).addConstructorTypeArg(Baz);

  // Resolve baz
  Baz baz = container.get(Baz);

  // Test result of baz
  assert(baz != null);
  assert(baz.name == "99");
  assert(baz.number == 22);

  // Resolve bar
  Bar bar = container.get(Bar);

  // Test result of bar
  assert(bar != null);
  assert(bar.baz.name == "99");
}
</pre>

###Property injection: Constant values

Constant values are set in the property:

<pre class="syntax brush-javascript">
import 'package:lost_dart/lost_dart.dart';

// application code
class Baz{
  String name;
  int number = 22;

  Baz([this.name = "99"]);
}

void main() {
  // Create IoC container
  Container container = new Container();

  // Bind Baz
  container.bind(Baz).setConstProperty("number", 33);

  // Resolve baz
  Baz baz = container.get(Baz);
  
  // Test result
  assert(baz.name == "99");
  assert(baz.number == 33);
}
</pre>

###Property injection: Dependencies

A tree of dependencies are instantiated and injected using the property:

<pre class="syntax brush-javascript">
import 'package:lost_dart/lost_dart.dart';

// application code
class Baz{
  String name;

  Baz([this.name = "99"]);
}

class Bar{
  Baz baz;

  Bar();
}

void main() {

  // Create IoC container
  Container container = new Container();

  // Bind Bar
  container.bind(Bar).setTypeProperty("baz", Bar);

  // Bind Baz
  container.bind(Baz);

  // Resolve bar
  Bar bar = container.get(Bar);
  
  // Test result
  assert(bar.baz != null);
  assert(bar.baz.name == "99");
}</pre>

###Factory methods

Factory methods can be used to generate injected values

<pre class="syntax brush-javascript">
import 'package:lost_dart/lost_dart.dart';

//application code
class Baz{
  String name;
  
  Baz(this.name);
}

void main() {
  // Create IoC container
  Container container = new Container();
  
  // Add Baz
  container.bind(Baz).toFactory((){
    return new Baz("1");
  });
  
  // Resolve baz
  Baz baz = container.get(Baz);

  // Test prototype result
  assert(baz != null);
  assert(baz.name == '1');
}
</pre>

###Object scopes

Lost Dart supports two scopes: singleton and prototype. The first is used by default and does not need to be explicitly specified in binding.

<pre class="syntax brush-javascript">
import 'package:lost_dart/lost_dart.dart';

//application code
class Baz{
}

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
</pre>

###Multi injection

Lost Dart allows you to inject multiple objects bound to a particular type or interface. There are <pre class="syntax brush-javascript">Weapon interface</pre>, and two implementations, <pre class="syntax brush-javascript">Sword</pre> and <pre class="syntax brush-javascript">Dagger</pre>.
The constructor of <pre class="syntax brush-javascript">Samurai</pre> class takes an array of <pre class="syntax brush-javascript">Weapon</pre>. Use <pre class="syntax brush-javascript">bindAsList</pre> method of <pre class="syntax brush-javascript">Container</pre> and specify you items here.

<pre class="syntax brush-javascript">
import 'package:lost_dart/lost_dart.dart';

/**
 * Asbtract class Weapon
 */
abstract class Weapon
{
  /**
   * Hit the [target].
   */
  String Hit(String target);
}

/**
 * Sword Weapon
 */
class Sword implements Weapon 
{
  /**
   * Hit the [target].
   */
  String Hit(String target) 
  {
    return "Slice " + target + " in half";
  }
}

/**
 * Dagger Weapon
 */
class Dagger implements Weapon 
{
  /**
   * Hit the [target].
   */
  String Hit(String target) 
  {
    return "Stab " + target + " to death";
  }
}

/**
 * Samurai fully equipped.
 */
class Samurai 
{
  List<Weapon> allWeapons;

  Samurai(List<Weapon> this.allWeapons); 

  /**
   * Just attack the [target].
   */
  void Attack(String target) 
  {
    for (Weapon weapon in this.allWeapons) {
      print(weapon.Hit(target));
    }
  }
}

void main() {
  Container container = new Container();
  // Bind weapons
  container.bind(Sword);
  container.bind(Dagger);
  // Bind weapons in list
  container.bindAsList("weapons").addAllTypesToList([Sword, Dagger]);
  // Bind Samurai
  container.bind(Samurai).addConstructorRefArg("weapons");
  
  // Get samurai 
  Samurai samurai = container.get(Samurai);
  // Atack
  samurai.Attack("your enemy");
}
</pre>
