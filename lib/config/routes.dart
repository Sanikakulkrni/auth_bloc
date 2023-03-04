import 'package:flutter/widgets.dart';

import 'package:phone_bloc/Bloc/bloc/app_bloc.dart';
import 'package:phone_bloc/screens/LogInScreen.dart';
import 'package:phone_bloc/screens/homescreen.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginScreen.page()];
  }
}
