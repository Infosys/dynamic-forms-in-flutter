// “Copyright 2022 Infosys Ltd.
// Use of this source code is governed by Apache License 2.0 that can be found in the LICENSE file or at
// http://www.apache.org/licenses/LICENSE-2.0 .”
import 'package:dynamic_forms/dynamic_form/dynamic_form_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class ButtonConfiguration extends StatelessWidget {
  final bool edit;
  final Map map;
  const ButtonConfiguration({required this.edit, required this.map, Key? key})
      : super(key: key);

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
              name: "title",
              initialValue: edit ? map['title'] : "",
              decoration:
                  const InputDecoration(label: Text("Enter title of button")),
              validator: FormBuilderValidators.required(
                  errorText: "Title name is required."),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select position of button",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                  FormBuilderRadioGroup(
                    name: 'position',
                    initialValue: edit ? map['position'] : "",
                    options: ["Left Aligned", "Center Aligned", "Right Aligned"]
                        .map((eye) => FormBuilderFieldOption(
                              value: eye,
                              child: Text(eye),
                            ))
                        .toList(growable: false),
                    controlAffinity: ControlAffinity.trailing,
                    validator: FormBuilderValidators.required(
                        errorText: "Select one option."),
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
                    "Select functionality for button",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                  FormBuilderCheckboxGroup<String>(
                    decoration: const InputDecoration(),
                    name: 'functions',
                    options: const [
                      FormBuilderFieldOption(value: 'Save'),
                      FormBuilderFieldOption(value: 'Validate'),
                    ],
                    initialValue: const ["Save"],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.minLength(1,
                          errorText: 'Select minimum 1 option'),
                      FormBuilderValidators.maxLength(3),
                    ]),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
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
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(24, 160, 133, 0.82)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        "Confirm",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
