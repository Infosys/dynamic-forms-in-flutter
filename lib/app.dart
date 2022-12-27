// “Copyright 2022 Infosys Ltd.
// Use of this source code is governed by Apache License 2.0 that can be found in the LICENSE file or at
// http://www.apache.org/licenses/LICENSE-2.0 .”

import 'package:dynamic_forms/dynamic_form/dynamic_form_view.dart';
import 'package:dynamic_forms/utils/app_router.dart';
import 'package:dynamic_forms/utils/app_theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Forms in Flutter',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightAppTheme,
      themeMode: ThemeMode.system,
      routes: AppRouter.routes,
      locale: const Locale('en', "IN"),
      home: const DynamicFormView(),
    );
  }
}
