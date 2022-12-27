// “Copyright 2022 Infosys Ltd.
// Use of this source code is governed by Apache License 2.0 that can be found in the LICENSE file or at
// http://www.apache.org/licenses/LICENSE-2.0 .”

import 'package:dynamic_forms/dynamic_form/dynamic_form_view_model.dart';
import 'package:dynamic_forms/dynamic_form/widgets/dynamic_form_homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DynamicFormView extends StatelessWidget {
  static const String routeName = '/dynamicform';

  const DynamicFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DynamicFormModel>(
        create: (context) => DynamicFormModel(),
        builder: (context, _) => Scaffold(
              appBar: AppBar(
                title: const Text("Dynamic Forms in Flutter"),
              ),
              body: const Center(child: DynamicFormHomePage()),
            ));
  }
}
