import 'package:saumap/pages/Tabs.dart';
import 'package:saumap/pages/bgm/examplePage.dart';
import 'package:saumap/pages/marker/FormPage.dart';

final routes = {
  '/': (context) => Tabs(),
  '/form': (context) => FormPage(),
  '/example': (context) => ExamplePage()
};
