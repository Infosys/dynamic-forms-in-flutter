// “Copyright 2022 Infosys Ltd.
// Use of this source code is governed by Apache License 2.0 that can be found in the LICENSE file or at
// http://www.apache.org/licenses/LICENSE-2.0 .”

import 'package:dynamic_forms/dynamic_form/dynamic_form_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class EditorTextField extends StatelessWidget {
  final bool edit;
  final Map map;
  const EditorTextField({required this.edit, required this.map, Key? key})
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
              initialValue: edit ? map['name'].toString() : "",
              name: "name",
              decoration: const InputDecoration(
                  label: Text("Enter field name (Unique*)")),
              validator: FormBuilderValidators.required(
                  errorText: "Unique field-name is required."),
            ),
            FormBuilderTextField(
              initialValue: edit ? map['label'].toString() : "",
              name: "label",
              decoration:
                  const InputDecoration(label: Text("Enter label name")),
              validator: FormBuilderValidators.required(
                  errorText: "Label name is required."),
            ),
            FormBuilderTextField(
              initialValue: edit ? map['hintText'].toString() : "",
              name: "hintText",
              decoration: const InputDecoration(label: Text("Enter hint text")),
            ),
            SizedBox(
              width: 200,
              child: FormBuilderTextField(
                name: "maxLines",
                initialValue: edit ? map['maxLines'] : "1",
                decoration:
                    const InputDecoration(label: Text("Enter max lines")),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.numeric(
                      errorText: 'Enter only numeric value.'),
                  FormBuilderValidators.max(7,
                      errorText: 'Enter maxLines in range of 1-7'),
                ]),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: FormBuilderSwitch(
                  name: "readOnly",
                  title: const Text("Read Only"),
                  initialValue: edit ? map['readOnly'] : false,
                )),
                Expanded(
                    child: FormBuilderSwitch(
                  name: "obscureText",
                  title: const Text("Obscure Text"),
                  initialValue: edit ? map['obscureText'] : false,
                )),
              ],
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
                      //saving form logic
                      if (formKey.currentState?.validate() == true) {
                        formKey.currentState!.save();
                      } else {
                        return;
                      }
                      // call by value and adding our type variable
                      Map<String, Object?> temp = {};
                      formKey.currentState!.value.forEach((key, value) {
                        temp[key] = value;
                      });
                      temp['type'] = context.read<DynamicFormModel>().fieldType;

                      // if edit
                      // else if adding
                      // else if add to end

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
