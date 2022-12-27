// “Copyright 2022 Infosys Ltd.
// Use of this source code is governed by Apache License 2.0 that can be found in the LICENSE file or at
// http://www.apache.org/licenses/LICENSE-2.0 .”

import 'package:dynamic_forms/dynamic_form/model/dropdown_options_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import '../../dynamic_form_view_model.dart';

class DropdownConfigurations extends StatelessWidget {
  final bool edit;
  final Map map;

  const DropdownConfigurations(
      {required this.edit, required this.map, Key? key})
      : super(key: key);
  String convert(String str) {
    int n = str.length;

    for (var i = 0; i < n; i++) {
      if (str[i] == ' ') {
        str[i] == "_";
      } else {
        str[i].toLowerCase();
      }
    }

    return str;
  }

  @override
  Widget build(BuildContext context) {
    String? jsonString;

    return ChangeNotifierProvider<DropDownOptionsModel>(
        create: (context) => DropDownOptionsModel(),
        builder: (context, _) => FormBuilder(
            key: context.read<DropDownOptionsModel>().formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: "name",
                    initialValue: edit
                        ? map['name']
                        : context
                                .read<DropDownOptionsModel>()
                                .formKey
                                .currentState
                                ?.fields['label']
                                .toString() ??
                            " ",
                    decoration: const InputDecoration(
                      label: Text("Enter field name (Unique*)"),
                    ),
                    validator: FormBuilderValidators.required(
                        errorText: "Unique field name is required."),
                  ),
                  FormBuilderTextField(
                    initialValue: edit ? map['label'] : "",
                    name: "label",
                    decoration: const InputDecoration(
                      label: Text("Enter label name"),
                    ),
                    validator: FormBuilderValidators.required(
                        errorText: "label name is required"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Enter options for dropdown",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.grey)),
                    ],
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount:
                        context.watch<DropDownOptionsModel>().options.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          Row(children: <Widget>[
                            Flexible(
                              fit: FlexFit.loose,
                              child: dropdownOptionsUI(index),
                            ),
                          ]),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
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
                            if (context
                                    .read<DropDownOptionsModel>()
                                    .formKey
                                    .currentState
                                    ?.validate() ==
                                true) {
                              context
                                  .read<DropDownOptionsModel>()
                                  .formKey
                                  .currentState!
                                  .save();
                            } else {
                              return;
                            }
                            Map temp = {};
                            context
                                .read<DropDownOptionsModel>()
                                .formKey
                                .currentState!
                                .value
                                .forEach((key, value) {
                              temp[key] = value;
                            });
                            List<String> tempOptions = [];
                            for (int i = 0;
                                i <
                                    context
                                        .read<DropDownOptionsModel>()
                                        .options
                                        .length;
                                i++) {
                              if (temp['options_$i'] != null) {
                                tempOptions.add(temp['options_$i']);
                              }
                            }
                            temp['type'] =
                                context.read<DynamicFormModel>().fieldType;
                            temp['items'] = tempOptions;
                            // if edit
                            // else if adding
                            // else add to end

                            if (edit) {
                              int ind = context
                                  .read<DynamicFormModel>()
                                  .getForm!
                                  .indexOf(map);
                              context
                                  .read<DynamicFormModel>()
                                  .editinform(ind, temp);

                              context
                                  .read<DynamicFormModel>()
                                  .setedit(false, {});
                            } else if (context
                                .read<DynamicFormModel>()
                                .getadding) {
                              context
                                  .read<DynamicFormModel>()
                                  .addinFormusingplus(temp);
                            } else {
                              context.read<DynamicFormModel>().addinForm(temp);
                            }

                            //to remove the config widget after addition into form
                            context.read<DynamicFormModel>().setFieldType("");
                            context
                                .read<DropDownOptionsModel>()
                                .formKey
                                .currentState
                                .reset();
                            context.read<DropDownOptionsModel>().resetOptions;
                            (context
                                .read<DropDownOptionsModel>()
                                .formKey
                                .currentState!
                                .value
                                .toString());
                            (jsonString!.toString());
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
              ),
            )));
  }

  Widget dropdownOptionsUI(index) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Flexible(
                flex: 1,
                child: FormBuilderTextField(
                  name: "options_$index",
                  validator: FormBuilderValidators.required(
                      errorText: "Dropdown options can't be empty."),
                  initialValue:
                      context.read<DropDownOptionsModel>().options[index],
                  decoration:
                      InputDecoration(label: Text("Option ${index + 1}")),
                )),
            Visibility(
              visible: index ==
                  context.read<DropDownOptionsModel>().options.length - 1,
              child: SizedBox(
                width: 35,
                child: IconButton(
                  icon: const Icon(
                    Icons.add_circle,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    context.read<DropDownOptionsModel>().addOptions("");
                    ("working");
                  },
                ),
              ),
            ),
            Visibility(
              visible: index > 0,
              child: SizedBox(
                width: 35,
                child: IconButton(
                  icon: const Icon(
                    Icons.remove_circle,
                    color: Colors.redAccent,
                  ),
                  onPressed: () {
                    context.read<DropDownOptionsModel>().removeOptions(index);
                  },
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
