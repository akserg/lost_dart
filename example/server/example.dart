import 'package:lost_dart/lost_dart.dart';

//application code
class Network{
  String uri;
  
  Network(this.uri);
}

class User {
  String name;
}

class Manager{
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
