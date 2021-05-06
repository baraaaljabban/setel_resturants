import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setel/core/injection_service.dart' as di;
import 'package:setel/init_page.dart';

import 'core/simple_bloc_delegate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Bloc.observer = SimpleBlocDelegate();
  runApp(App());
}
