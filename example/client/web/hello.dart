//Copyright (C) 2012-2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

library hello;

import 'dart:html';
import 'package:lost_dart/lost_dart.dart';

void main() {
  // Create container
  Container ctr = new Container();
  // Bind controller with one constructor argument
  ctr.bind(Controller).addConstructorTypeArg(Model);
   // Bind model with constant as property
  ctr.bind(Model).setConstProperty("name", "car");
  
  
  // Get controller
  Controller controller = ctr.get(Controller);
  // Print info
  print("Controller active status is ${controller.active} with model ${controller.model.name}");
}


class Controller {
  Model model;
  bool active = false;
  
  Controller(this.model);
}

class Model {
  String name;
}