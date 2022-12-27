// “Copyright 2022 Infosys Ltd.
// Use of this source code is governed by Apache License 2.0 that can be found in the LICENSE file or at
// http://www.apache.org/licenses/LICENSE-2.0 .”

import 'package:dynamic_forms/dynamic_form/dynamic_form_view_model.dart';
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Widget widgetSelection(map) {
      switch (map['type']) {
        case "textField":
          return FormBuilderTextFieldWidget(
            map: map,
            name: map['name'],
            ispreview: true,
          );

        case "dropdown":
          return FormBuilderDropdowns(
            map: map,
            name: map['name'],
            ispreview: true,
          );

        case "radioButtons":
          return FormBuilderRadioButtons(
            map: map,
            name: map['name'],
            ispreview: true,
          );

        case "button":
          return FormButton(
            map: map,
            ispreview: true,
          );

        case "textHeading":
          return TextHeadings(
            map: map,
            ispreview: true,
          );

        case "switchField":
          return FormBuilderSwitchButton(
            map: map,
            ispreview: true,
          );

        default:
          return Container();
      }
    }

    List<Widget> bodyElements = [];
    List<List<Widget>> stepperbody = [];
    bodyElementsFunction() {
      int pagedividercount = 0;
      var data = context.read<DynamicFormModel>().getForm;
      List<Widget> tempstepperbody = [];
      List<Widget> temp = [];
      for (var map in data!) {
        if (map["type"] == "pageDivider") {
          pagedividercount = pagedividercount + 1;
          for (var element in tempstepperbody) {
            temp.add(element);
          }
          stepperbody.add(temp);
          temp = [];
          tempstepperbody.clear();
        } else {
          tempstepperbody.add(widgetSelection(map));
        }
      }
      if (tempstepperbody.isNotEmpty) {
        for (var element in tempstepperbody) {
          temp.add(element);
        }
        stepperbody.add(temp);
      }
      context.read<DynamicFormModel>().settotalSteps(pagedividercount);

      if (pagedividercount != 0) {
        List<Step> dummy = [];
        for (var element in stepperbody) {
          dummy.add(Step(
              title: const Text(""),
              content: Column(
                children: element,
              )));
        }

        bodyElements.add(Container(
            width: width,
            height: height,
            child: Stepper(
                onStepContinue: context.watch<DynamicFormModel>().continued,
                onStepCancel: context.watch<DynamicFormModel>().cancel,
                type: StepperType.horizontal,
                currentStep: context.watch<DynamicFormModel>().getcurrentStep,
                steps: dummy)));
      } else {
        bodyElements = stepperbody[0];
      }

      return bodyElements;
    }

    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              height: 400,
              child: context.read<DynamicFormModel>().getForm!.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          "Form will render here.",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: Colors.grey),
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: bodyElementsFunction(),
                      ),
                    )),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                height: 400,
                child: context.read<DynamicFormModel>().getFormString() == "[]"
                    ? Center(
                        child: Text(
                          "Json will render here.",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: Colors.grey),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            context.read<DynamicFormModel>().getFormString(),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: Colors.grey),
                          ),
                        ),
                      ),
              ),
            ))
      ],
    );
  }
}
