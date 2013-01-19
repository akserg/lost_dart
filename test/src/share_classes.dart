//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart_test;

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

