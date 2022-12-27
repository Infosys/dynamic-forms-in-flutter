// “Copyright 2022 Infosys Ltd.
// Use of this source code is governed by Apache License 2.0 that can be found in the LICENSE file or at
// http://www.apache.org/licenses/LICENSE-2.0 .”

import 'package:dynamic_forms/dynamic_form/widgets/edit_options/edit_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderRadioButtons extends StatelessWidget {
  const FormBuilderRadioButtons(
      {Key? key, required this.name, required this.map, this.ispreview = false})
      : super(key: key);
  final dynamic map;
  final String name;
  final bool ispreview;

  @override
  Widget build(BuildContext context) {
    List<String> options = List<String>.from(map['options']);
    return Row(
      children: [
        Expanded(
          flex: 10,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 7, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  map['label'],
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500, color: Colors.grey),
                ),
                FormBuilderRadioGroup<String>(
                  decoration: InputDecoration(
                      labelStyle: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                              fontWeight: FontWeight.w500, color: Colors.grey)),
                  initialValue: null,
                  name: name,
                  onChanged: (value) {
                    (value.toString());
                  },
                  options: options
                      .map((eye) => FormBuilderFieldOption(
                            value: eye,
                            child: Text(eye),
                          ))
                      .toList(growable: false),
                  controlAffinity: ControlAffinity.trailing,
                ),
              ],
            ),
          ),
        ),
        !ispreview
            ? Expanded(
                flex: 4,
                child: EditWidget(
                  map: map,
                  type: "radioButtons",
                ))
            : Container()
      ],
    );
  }
}
