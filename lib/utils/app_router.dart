// “Copyright 2022 Infosys Ltd.
// Use of this source code is governed by Apache License 2.0 that can be found in the LICENSE file or at
// http://www.apache.org/licenses/LICENSE-2.0 .”

import 'package:dynamic_forms/dynamic_form/dynamic_form_view.dart';
import 'package:flutter/material.dart';

class AppRouter {
  AppRouter._();

  static Map<String, Widget Function(BuildContext)> routes = {
    DynamicFormView.routeName: (context) => const DynamicFormView(),
  };

  static Route<dynamic>? onUnknownRoute(RouteSettings settings) {
    return null;
  }
}
