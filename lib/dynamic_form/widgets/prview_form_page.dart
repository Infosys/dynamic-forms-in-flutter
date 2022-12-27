// “Copyright 2022 Infosys Ltd.
// Use of this source code is governed by Apache License 2.0 that can be found in the LICENSE file or at
// http://www.apache.org/licenses/LICENSE-2.0 .”

import 'package:dynamic_forms/dynamic_form/dynamic_form_view_model.dart';
import 'package:dynamic_forms/dynamic_form/widgets/form_widgets/form_builder_divider.dart';
import 'package:dynamic_forms/dynamic_form/widgets/form_widgets/form_builder_dropdown.dart';
import 'package:dynamic_forms/dynamic_form/widgets/form_widgets/form_builder_radiobutton.dart';
import 'package:dynamic_forms/dynamic_form/widgets/form_widgets/form_builder_switchbutton.dart';
import 'package:dynamic_forms/dynamic_form/widgets/form_widgets/form_button.dart';
import 'package:dynamic_forms/dynamic_form/widgets/form_widgets/formbuildertextfield.dart';
import 'package:dynamic_forms/dynamic_form/widgets/form_widgets/text_headings.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class PreviewFormPage extends StatelessWidget {
  const PreviewFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> bodyElements = [];
    bodyElementsFunction() {
      var data = context.read<DynamicFormModel>().getForm;
      data!.forEach((map) {
        String value = map['type'].toString();
        switch (value) {
          case "textField":
            (map);
            bodyElements.add(FormBuilderTextFieldWidget(
              map: map,
              name: map['name'],
            ));
            break;
          case "dropdown":
            bodyElements.add(FormBuilderDropdowns(map: map, name: map['name']));
            break;
          case "radioButtons":
            bodyElements.add(FormBuilderRadioButtons(
              map: map,
              name: map['name'],
            ));
            break;
          case "button":
            bodyElements.add(FormButton(
              map: map,
            ));
            break;
          case "textHeading":
            bodyElements.add(TextHeadings(
              map: map,
            ));
            break;
          case "switchField":
            bodyElements.add(FormBuilderSwitchButton(
              map: map,
            ));
            break;
          case "pageDivider":
            bodyElements.add(FormBuilderDivider(
              map: map,
            ));
            break;
        }
      });
      return bodyElements;
    }

    return context.read<DynamicFormModel>().getForm!.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
                height: 200,
                child: Text(
                  "Widget will render here.",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.grey),
                )),
          )
        : Column(
            children: bodyElementsFunction(),
          );
  }
}
