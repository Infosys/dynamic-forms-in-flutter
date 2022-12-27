// “Copyright 2022 Infosys Ltd.
// Use of this source code is governed by Apache License 2.0 that can be found in the LICENSE file or at
// http://www.apache.org/licenses/LICENSE-2.0 .”

import 'package:dynamic_forms/dynamic_form/dynamic_form_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class TextHeadingConfigurations extends StatelessWidget {
  const TextHeadingConfigurations(
      {required this.edit, required this.map, Key? key})
      : super(key: key);

  final bool edit;
  final Map map;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return FormBuilder(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormBuilderTextField(
              name: "text",
              initialValue: edit ? map['text'] : "",
              decoration: const InputDecoration(label: Text("Heading Text")),
              validator: FormBuilderValidators.required(
                  errorText: "Heading text is required."),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select position of heading",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                  FormBuilderRadioGroup(
                    initialValue: edit ? map['position'] : "",
                    name: 'position',
                    options: ["Left Aligned", "Center Aligned", "Right Aligned"]
                        .map((val) => FormBuilderFieldOption(
                              value: val,
                              child: Text(val),
                            ))
                        .toList(growable: false),
                    controlAffinity: ControlAffinity.trailing,
                    validator: FormBuilderValidators.required(
                        errorText: "Select position for heading."),
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select size of heading",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                  FormBuilderRadioGroup(
                    initialValue: edit ? map['size'] : "",
                    name: 'size',
                    options: [
                      FormBuilderFieldOption(
                        value: "titleLarge",
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Heading 1",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                          ),
                        ),
                      ),
                      FormBuilderFieldOption(
                        value: "titleMedium",
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Heading 2",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                          ),
                        ),
                      ),
                      FormBuilderFieldOption(
                        value: "titleSmall",
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Heading 3",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                    validator: FormBuilderValidators.required(
                        errorText: "Select size for heading."),
                  )
                ],
              ),
            ),

            SizedBox(
              height: 20,
            ), //  FormBuilderRangeSlider(name: "maxLines", min: 1, max: 4,divisions: 3,initialValue: RangeValues(1,4),decoration: InputDecoration(label: Text("Select max Lines")),)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() == true) {
                        formKey.currentState!.save();
                      } else {
                        return;
                      }

                      Map temp = {};
                      formKey.currentState!.value.forEach((key, value) {
                        temp[key] = value;
                      });
                      temp['type'] = context.read<DynamicFormModel>().fieldType;

                      // if edit
                      // else if adding
                      // else add to end

                      if (edit) {
                        int ind = context
                            .read<DynamicFormModel>()
                            .getForm!
                            .indexOf(map);
                        context.read<DynamicFormModel>().editinform(ind, temp);

                        context.read<DynamicFormModel>().setedit(false, {});
                      } else if (context.read<DynamicFormModel>().getadding) {
                        context
                            .read<DynamicFormModel>()
                            .addinFormusingplus(temp);
                      } else {
                        context.read<DynamicFormModel>().addinForm(temp);
                      }

                      //to remove the config widget after addition into form
                      context.read<DynamicFormModel>().setFieldType("");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: const Text(
                        "Confirm",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(24, 160, 133, 0.82)),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
