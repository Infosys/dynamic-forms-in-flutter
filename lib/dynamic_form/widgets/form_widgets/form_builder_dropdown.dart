// “Copyright 2022 Infosys Ltd.
// Use of this source code is governed by Apache License 2.0 that can be found in the LICENSE file or at
// http://www.apache.org/licenses/LICENSE-2.0 .”

import 'package:dynamic_forms/dynamic_form/widgets/edit_options/edit_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderDropdowns extends StatelessWidget {
  const FormBuilderDropdowns(
      {required this.name, required this.map, this.ispreview = false, Key? key})
      : super(key: key);

  final String name;
  final dynamic map;
  final bool ispreview;

  @override
  Widget build(BuildContext context) {
    List<String> items = List<String>.from(map['items']);
    return Row(
      children: [
        Expanded(
          flex: 10,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 0),
            child: FormBuilderDropdown<String>(
                decoration: InputDecoration(
                  label: Text(map['label'] ?? ""),
                  hintText: map['hintText'] ?? "",
                  border: const OutlineInputBorder(),
                ),
                name: name,
                items: items
                    .map((val) => DropdownMenuItem(
                          alignment: AlignmentDirectional.centerStart,
                          value: val,
                          child: Text(val),
                        ))
                    .toList()),
          ),
        ),
        !ispreview
            ? Expanded(
                flex: 4,
                child: EditWidget(
                  map: map,
                  type: "dropdown",
                ))
            : Container()
      ],
    );
  }
}
