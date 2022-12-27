// “Copyright 2022 Infosys Ltd.
// Use of this source code is governed by Apache License 2.0 that can be found in the LICENSE file or at
// http://www.apache.org/licenses/LICENSE-2.0 .”

import 'dart:developer';
import 'package:dynamic_forms/dynamic_form/dynamic_form_view_model.dart';
import 'package:dynamic_forms/dynamic_form/model/dropdown_options_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class RadioConfigurations extends StatelessWidget {
  RadioConfigurations({Key? key}) : super(key: key);

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
                    initialValue: context
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
                    name: "label",
                    decoration: const InputDecoration(
                      label: Text("Enter label name"),
                    ),
                    validator: FormBuilderValidators.required(
                        errorText: "label name is required"),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  //  FormBuilderDropdown(name: "name",
                  //   items: options.map((val)=>DropdownMenuItem(
                  //                         alignment: AlignmentDirectional.centerStart,
                  //                         value: val,
                  //                         child: Text(val),)).toList(),

                  //   ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Enter options for radio button.",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.grey)),
                    ],
                  ),

                  // Row(
                  //   children: [

                  //     Expanded(child: FormBuilderSwitch(name: "readOnly", title: const Text("Read Only"), initialValue: false,)),
                  //     Expanded(child: SizedBox(),flex: 1,)
                  //   ],

                  // ),

                  ListView.separated(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
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
                    separatorBuilder: (context, index) => Divider(),
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
                            temp['options'] = tempOptions;
                            // (temp.toString());
                            context.read<DynamicFormModel>().addinForm(temp);
                            context
                                .read<DropDownOptionsModel>()
                                .formKey
                                .currentState
                                .reset();
                            context.read<DropDownOptionsModel>().resetOptions;
                            // (tempOptions.toString());
                            // context.read<DropDownOptionsModel>().formKey.currentState.
                            (context
                                .read<DropDownOptionsModel>()
                                .formKey
                                .currentState!
                                .value
                                .toString());
                            (jsonString!.toString());
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
              ),
            )));
  }

  Widget dropdownOptionsUI(index) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      void setOptions() {
        setState(() {
          context.read<DropDownOptionsModel>().resetOptions();
        });
      }

      return Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Flexible(
                flex: 1,
                child: FormBuilderTextField(
                  name: "options_$index",
                  validator: FormBuilderValidators.required(
                      errorText: "Radio options can't be empty."),
                  initialValue:
                      context.read<DropDownOptionsModel>().options[index],
                  decoration:
                      InputDecoration(label: Text("Option ${index + 1}")),
                )),
            Visibility(
              child: SizedBox(
                width: 35,
                child: IconButton(
                  icon: Icon(
                    Icons.add_circle,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    context.read<DropDownOptionsModel>().addOptions("");
                    ("working");
                  },
                ),
              ),
              visible: index ==
                  context.read<DropDownOptionsModel>().options.length - 1,
            ),
            Visibility(
              child: SizedBox(
                width: 35,
                child: IconButton(
                  icon: Icon(
                    Icons.remove_circle,
                    color: Colors.redAccent,
                  ),
                  onPressed: () {
                    context.read<DropDownOptionsModel>().removeOptions(index);
                    // context.read<DropDownOptionsModel>().formKey.currentState!.fields['options_$index']
                    // ?.dispose();
                  },
                ),
              ),
              visible: index > 0,
            )
          ],
        ),
      );
    });
  }

  // void addEmailControl(context) {
  //   context.read<DropDownOptionsModel>().options.add("");

  // }

  // void removeEmailControl(index) {

  //     if (options.length > 1) {
  //       options.removeAt(index);
  //     }

  // }

}
