##Lost Dart

Lost Dart is implementation of Inversion of Control container written on Dart language.

[![](https://drone.io/akserg/lost_dart/status.png)](https://drone.io/akserg/lost_dart/latest)

It manages dependency injection and dependency management. Its aim is to make wide range of Dart applications easier to:
* Manage source code;
* Encouraging code modularisation;
* Separations of concerns;
* Good unit testing practices.

Main class in Lost Dart is Container, exposes set of methods using to manage configurations and resolve instance by identifier. The configuration consists of object definitions implemented either in-code or like JSON objects (not implemented yet). Configuration wires the application together.  

```javascript
// Create IoC container
Container container = new Container();

// Create configuration
Configuration config = new InCodeConfiguration()
  // Add Baz
  ..add("baz", fun(Container container, Map params){
    return new Baz(params["name"]);
  })
  // Add Bar
  ..add("bar", fun(Container container, Map params){
    // Find baz
    Baz baz = container.resolve("baz");
    // Create Bar with constructor injection
    Bar bar = new Bar(baz);
    return bar;
  })
  // Add Foo
  ..add("foo", fun(Container container, Map params){
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

// Resolve baz
Baz baz = container.resolve("baz");
```

Container is not a singleton. Depends on development strategy or business requirements developer might implement set of configurations having relations any kind of complexity.

###Set up
Lost Dart is available under the lost_dart pub package. Simply add a dependency to your pubspec.yaml file:

```javascript
...
dependencies:
  lost_dart: any
``` 

Then run pub install and you’ll have everything you need to get started.

##The core concepts of Lost Dart by examples

###Instantiation

A simple example of using the Lost Dart is that to construct an instance of an object. 

```javascript
// Somewhere in developing library
class Baz{
  String name;
  
  Baz([this.name = ""]);
}

// Create IoC container
Container container = new Container();

// Configuration
Configuration config = new InCodeConfiguration()
  // Add Baz
  ..add("baz", fun(Container container, Map params){
    return new Baz();
  });

// Add configuration
container.add(config);

// Resolve baz
Baz baz = container.resolve("baz");

// Test result
assert(baz != null);
assert(baz.name == "");
```

###Constructor injection: Literals arguments

Literal values are set in the configuration:

```javascript
// Configuration
Configuration config = new InCodeConfiguration()
  // Add Baz
  ..add("baz", fun(Container container, Map params){
    return new Baz("Test");
  });

// …

// Test result
assert(baz.name == "Test");
```

###Constructor injection: Using a map of named literals

Developers might specify map of named literals in second argument to be used in class instantiation as constructor arguments: 

```javascript
Baz baz1 = container.resolve("baz", {"name":"Test"});
```

###Constructor injection: Dependencies

A tree of dependencies are instantiated and injected using the configuration:

```javascript
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

// Create IoC container
Container container = new Container();

// Create configuration
Configuration config = new InCodeConfiguration()
  // Add Baz
  ..add("baz", fun(Container container, Map params){
    return new Baz(params["name"]);
  })
  // Add Bar
  ..add("bar", fun(Container container, Map params){
    // Find baz
    Baz baz = container.resolve("baz");
    // Create Bar with constructor injection
    Bar bar = new Bar(baz);
    return bar;
  });

// Create IoC container
Container container = new Container();

// Add configuration
container.add(config);

// Resolve baz
Baz baz = container.resolve("baz");

// Test result of baz
assert(baz != null);
assert(baz.name == "");

// Resolve bar
Bar bar = container.resolve("bar");

// Test result of bar
assert(bar != null);
assert(bar.baz.name == "");
```

As you seen in previous example to use references to other instances of objects we may ask container to resolve reference on other instance:

```javascript
// Create configuration
Configuration config = new InCodeConfiguration()
  // Add Bar
  ..add("bar", fun(Container container, Map params){
  // Find baz
  Baz baz = container.resolve("baz");
  // Create Bar with constructor injection
  Bar bar = new Bar(baz);
  return bar;
})
```

###Property injection: Literal values

Literal values are set in the configuration:

```javascript
// application code
class Baz{
  String name;
  int number = 22;

  Baz([this.name = "99"]);
}

// Create configuration
Configuration config = new InCodeConfiguration()
  // Add Baz
  ..add("baz", fun(Container container, Map params){
    Baz baz = new Baz(params["name"]);
    Baz.number = 33;
    return baz;
  });


// Create IoC container
Container container = new Container();
// Add configuration
container.add(config);

// Resolve baz
Baz baz = container.resolve("baz", {"name":"123"});

// Test result
assert(baz.name == "123");
assert(baz.number == 33);
```

###Property injection: Dependencies

A tree of dependencies are instantiated and injected using the configuration:

```javascript
// application code
class Baz{
  String name;
  int number = 22;

  Baz([this.name = "99"]);
}

Class Bar{
  Baz baz;

  Bar();
}

// Create configuration
Configuration config = new InCodeConfiguration()
  // Add Baz
  ..add("baz", fun(Container container, Map params){
    return new Baz(params["name"]);
  })
  // Add Bar
  ..add("bar", fun(Container container, Map params){
    Bar bar = new Bar();
    bar.baz = container.resolve("baz");
    return bar;
  });


// Create IoC container
Container container = new Container();

// Add configuration
container.add(config);

// Resolve baz
Baz baz = container.resolve("baz");

// Resolve bar
Bar bar = container.resolve("bar");

// Test result
assert(baz.baz == baz);
```

###Object scopes

Lost Dart supports two scopes: singleton and prototype. The first is used by default and does not need to be explicitly specified in the configuration. Objects that use the singleton scope will only be instantiated once.

```javascript
//application code
class Baz{
  String name;
  int number = 22;

  Baz([this.name = "99"]);
}


// Create configuration
Configuration config = new InCodeConfiguration()
  // Add Baz
  ..add("baz", fun(Container container, Map params){
    Baz baz = new Baz();
    baz.name = params["name"];
    return baz;
  }, Scope.PROTOTYPE)
  // Add Bar
  ..add("bar", fun(Container container, Map params) {
    return new Bar();
  }

// Create IoC container
Container container = new Container();

// Add configuration
container.add(config);

// Resolve baz - "prototype" scope.
Baz baz = container.resolve("baz");
Baz baz1 = container.resolve("baz");
// Test prototype result
assert(baz != baz1);

// Resolve bar – "singleton" scope
Bar bar = container.resolve("bar");
Bar bar1 = container.resolve("bar");
// Test prototype result
assert(bar == bar1);
```

###Factory methods

Factory methods can be used to generate injected values

```javascript
Not implemented yet
```
