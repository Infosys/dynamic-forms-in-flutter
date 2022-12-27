// “Copyright 2022 Infosys Ltd.
// Use of this source code is governed by Apache License 2.0 that can be found in the LICENSE file or at
// http://www.apache.org/licenses/LICENSE-2.0 .”

import 'package:dynamic_forms/dynamic_form/widgets/edit_options/edit_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:provider/provider.dart';

class FormBuilderTextFieldWidget extends StatelessWidget {
  final String name;
  final dynamic map;
  final bool ispreview;

  const FormBuilderTextFieldWidget(
      {required this.name, required this.map, this.ispreview = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int maxLines = int.parse(map['maxLines']);
    // assert(maxLines is int);
    return Row(
      children: [
        Expanded(
          flex: 10,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: FormBuilderTextField(
              name: name,
              readOnly: map['readOnly'],
              obscureText: map['obscureText'],
              maxLines: maxLines,
              decoration: InputDecoration(
                label: Text(map['label'] ?? ""),
                hintText: map['hintText'] ?? "",
                border: maxLines > 1
                    ? const OutlineInputBorder()
                    : const UnderlineInputBorder(),
              ),
            ),
          ),
        ),
        !ispreview
            ? Expanded(
                flex: 4,
                child: EditWidget(
                  map: map,
                  type: "textField",
                ))
            : Container()
      ],
    );
  }
}
