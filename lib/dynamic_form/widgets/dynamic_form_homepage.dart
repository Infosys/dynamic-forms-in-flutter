// “Copyright 2022 Infosys Ltd.
// Use of this source code is governed by Apache License 2.0 that can be found in the LICENSE file or at
// http://www.apache.org/licenses/LICENSE-2.0 .”

import 'package:dynamic_forms/dynamic_form/dynamic_form_view_model.dart';
import 'package:dynamic_forms/dynamic_form/form_preview/preview_form.dart';
import 'package:dynamic_forms/dynamic_form/widgets/form_configuration_editor.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class DynamicFormHomePage extends StatefulWidget {
  const DynamicFormHomePage({Key? key}) : super(key: key);

  @override
  State<DynamicFormHomePage> createState() => _DynamicFormHomePageState();
}

class _DynamicFormHomePageState extends State<DynamicFormHomePage> {
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Color.fromRGBO(24, 160, 133, 0.82),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration:
                          context.watch<DynamicFormModel>().getgoToNextPage
                              ? const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                  color: Colors.white,
                                  width: 1.0,
                                )))
                              : const BoxDecoration(),
                      child: const Text(
                        "Form Editor",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration:
                          !context.watch<DynamicFormModel>().getgoToNextPage
                              ? const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                  color: Colors.white,
                                  width: 1.0,
                                )))
                              : const BoxDecoration(),
                      child: const Text(
                        "Preview Section",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ],
              )),
          body: !context.watch<DynamicFormModel>().getgoToNextPage
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(children: [
                    
                      PreviewFormPage(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xff008080))),
                                onPressed: () {
                                  context
                                      .read<DynamicFormModel>()
                                      .setgoToNextPage(true);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "Back",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: 60,
                          ),
                        ],
                      ),
                    ]),
                  ),
                )
              : FormConfigurationEditor()),
    );
  }
}
