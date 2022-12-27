// “Copyright 2022 Infosys Ltd.
// Use of this source code is governed by Apache License 2.0 that can be found in the LICENSE file or at
// http://www.apache.org/licenses/LICENSE-2.0 .”

import 'package:dynamic_forms/dynamic_form/widgets/edit_options/edit_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderSwitchButton extends StatelessWidget {
  const FormBuilderSwitchButton(
      {Key? key, required this.map, this.ispreview = false})
      : super(key: key);

  final dynamic map;

  final bool ispreview;
  @override
  Widget build(BuildContext context) {
    var initialValue = map['initialValue'] == true;
    return Row(
      children: [
        Expanded(
          flex: 10,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: FormBuilderSwitch(
              name: map['name'],
              title: Text(
                map['title'],
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w400),
              ),
              initialValue: initialValue,
            ),
          ),
        ),
        !ispreview
            ? Expanded(
                flex: 4,
                child: EditWidget(
                  map: map,
                  type: "switchField",
                ))
            : Container()
      ],
    );
  }
}
