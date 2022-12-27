// “Copyright 2022 Infosys Ltd.
// Use of this source code is governed by Apache License 2.0 that can be found in the LICENSE file or at
// http://www.apache.org/licenses/LICENSE-2.0 .”

import 'package:dynamic_forms/dynamic_form/dynamic_form_view_model.dart';
import 'package:dynamic_forms/dynamic_form/widgets/editor_configurations.dart';
import 'package:dynamic_forms/dynamic_form/widgets/prview_form_page.dart';
import 'package:dynamic_forms/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormConfigurationEditor extends StatelessWidget {
  const FormConfigurationEditor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Stack(children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      // color: Colors.white[200],
                      child: EditorConfigurations(),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 3,
                    child: Card(
                      elevation: 3,
                      child: Container(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [PreviewFormPage()],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xff008080))),
                      onPressed: () {
                        context.read<DynamicFormModel>().setgoToNextPage(false);
                        // context
                        //     .read<DynamicFormModel>()
                        //     .setNewFormSelected(false);
                        // context
                        //     .read<DynamicFormModel>()
                        //     .setSelectedTenantForm("");
                        // context.read<DynamicFormModel>().setIsSuccess(false);
                        // context.read<DynamicFormModel>().setshowAlert(false);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Preview",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                        ),
                      )),
                ),
                context.read<DynamicFormModel>().getForm!.isEmpty
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xff008080))),
                            onPressed: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Submit",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                              ),
                            )),
                      ),
                const SizedBox(
                  width: 20,
                ),
                context.read<DynamicFormModel>().getshowAlert
                    ? context.read<DynamicFormModel>().getIsSuccess
                        ? Text(
                            "Submited Successfully !",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold),
                          )
                        : Text(
                            "Error Occured !",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold),
                          )
                    : Container(),
              ],
            )
            //  Button("Previous", () {

            //  })
          ],
        ),
      ]),
    );
  }
}
