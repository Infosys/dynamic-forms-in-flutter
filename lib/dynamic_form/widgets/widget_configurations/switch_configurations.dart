// “Copyright 2022 Infosys Ltd.
// Use of this source code is governed by Apache License 2.0 that can be found in the LICENSE file or at
// http://www.apache.org/licenses/LICENSE-2.0 .”

import 'package:dynamic_forms/dynamic_form/dynamic_form_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class SwitchCongigurations extends StatelessWidget {
  final bool edit;
  final Map map;
  const SwitchCongigurations({required this.edit, required this.map, Key? key})
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
              initialValue: edit ? map['name'] : "",
              name: "name",
              decoration: const InputDecoration(
                  label: Text("Enter field name (Unique*)")),
              validator: FormBuilderValidators.required(
                  errorText: "Unique field name is required."),
            ),
            FormBuilderTextField(
              initialValue: edit ? map['title'] : "",
              name: "title",
              decoration: const InputDecoration(
                  label: Text("Enter title for switch button.")),
              validator: FormBuilderValidators.required(
                  errorText: "Switch title is required."),
            ),

            FormBuilderSwitch(
              name: 'initialValue',
              title: Text(
                "Initial value of switch",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              secondary: Icon(Icons.check_box_outlined),
              initialValue: edit ? map['initialValue'] : false,
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
                      // Map<String, dynamic> demo = formKey.currentState!.value;
                      // (formKey.currentState!.value.toString());
                      Map temp = {};
                      formKey.currentState!.value.forEach((key, value) {
                        temp[key] = value;
                      });
                      temp['type'] = context.read<DynamicFormModel>().fieldType;
                      // (temp.toString());

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
