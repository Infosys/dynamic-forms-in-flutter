// “Copyright 2022 Infosys Ltd.
// Use of this source code is governed by Apache License 2.0 that can be found in the LICENSE file or at
// http://www.apache.org/licenses/LICENSE-2.0 .”

import 'dart:developer';
import 'package:dynamic_forms/dynamic_form/dynamic_form_view_model.dart';
import 'package:dynamic_forms/dynamic_form/widgets/widget_configurations/radio_configurations.dart';
import 'package:dynamic_forms/dynamic_form/widgets/widget_configurations/button_configuration.dart';
import 'package:dynamic_forms/dynamic_form/widgets/widget_configurations/divider_configurations.dart';
import 'package:dynamic_forms/dynamic_form/widgets/widget_configurations/dropdown_configurations.dart';
import 'package:dynamic_forms/dynamic_form/widgets/widget_configurations/switch_configurations.dart';
import 'package:dynamic_forms/dynamic_form/widgets/widget_configurations/text_heading_configurations.dart';
import 'package:dynamic_forms/dynamic_form/widgets/widget_configurations/textfield_configurations.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class EditorConfigurations extends StatelessWidget {
  const EditorConfigurations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Column(
          children: [
            context.read<DynamicFormModel>().newFormSelected == true
                ? DropdownButtonFormField<String>(
                    // isExpanded: context.watch<DynamicFormModel>().getadding,
                    decoration: InputDecoration(
                      label: const Text("Select Form Type"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    focusColor: Colors.white,
                    items: const [
                      DropdownMenuItem<String>(
                          value: "Pledge", child: Text("Pledge")),
                      DropdownMenuItem<String>(
                          value: "Harvest", child: Text("Harvest")),
                      DropdownMenuItem<String>(
                          value: "Request", child: Text("Request")),
                    ],
                    hint: const Text("Select type of form"),
                    onChanged: (value) {
                      context.read<DynamicFormModel>().setselectedform(value!);
                    },
                  )
                : SizedBox.shrink(),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField<String>(
              // isExpanded: context.watch<DynamicFormModel>().getadding,
              decoration: InputDecoration(
                label: const Text("Select Field Type"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              focusColor: Colors.white,
              items: const [
                DropdownMenuItem<String>(
                    value: "textField", child: Text("Text Field")),
                DropdownMenuItem<String>(
                    value: "dropdown", child: Text("Dropdown")),
                DropdownMenuItem<String>(
                    value: "radioButtons", child: Text("Radio Buttons")),
                DropdownMenuItem<String>(
                    value: "button", child: Text("Button")),
                DropdownMenuItem<String>(
                    value: "textHeading", child: Text("Text Heading")),
                DropdownMenuItem<String>(
                    value: "switchField", child: Text("Switch Field")),
                DropdownMenuItem<String>(
                    value: "pageDivider", child: Text("Page Divider")),
              ],
              hint: const Text("Select type of field"),
              onChanged: (value) {
                context.read<DynamicFormModel>().setFieldType(value);
                (context.read<DynamicFormModel>().fieldType.toString());
              },
            ),
            const SizedBox(
              height: 20,
            ),
            context.read<DynamicFormModel>().getadding
                ? Container(
                    width: width,
                    child: Text("Select Field Type To Add",
                        style: TextStyle(color: Colors.red)),
                  )
                : Container(),
            context.read<DynamicFormModel>().fieldType == "textField"
                ? EditorTextField(
                    edit: context.read<DynamicFormModel>().getedit,
                    map: context.read<DynamicFormModel>().geteditmap,
                  )
                : context.read<DynamicFormModel>().fieldType == "dropdown"
                    ? DropdownConfigurations(
                        edit: context.read<DynamicFormModel>().getedit,
                        map: context.read<DynamicFormModel>().geteditmap,
                      )
                    : context.read<DynamicFormModel>().fieldType ==
                            "radioButtons"
                        ? RadioConfigurations()
                        : context.read<DynamicFormModel>().fieldType == "button"
                            ? ButtonConfiguration(
                                edit: context.read<DynamicFormModel>().getedit,
                                map:
                                    context.read<DynamicFormModel>().geteditmap,
                              )
                            : context.read<DynamicFormModel>().fieldType ==
                                    "textHeading"
                                ? TextHeadingConfigurations(
                                    edit: context
                                        .read<DynamicFormModel>()
                                        .getedit,
                                    map: context
                                        .read<DynamicFormModel>()
                                        .geteditmap,
                                  )
                                : context.read<DynamicFormModel>().fieldType ==
                                        "switchField"
                                    ? SwitchCongigurations(
                                        edit: context
                                            .read<DynamicFormModel>()
                                            .getedit,
                                        map: context
                                            .read<DynamicFormModel>()
                                            .geteditmap,
                                      )
                                    : context
                                                .read<DynamicFormModel>()
                                                .fieldType ==
                                            "pageDivider"
                                        ? DividerConfigurations()
                                        : Text(
                                            "Please select type of field first.",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge
                                                ?.copyWith(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
