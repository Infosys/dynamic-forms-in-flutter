// “Copyright 2022 Infosys Ltd.
// Use of this source code is governed by Apache License 2.0 that can be found in the LICENSE file or at
// http://www.apache.org/licenses/LICENSE-2.0 .”

import 'package:dynamic_forms/dynamic_form/widgets/edit_options/edit_widgets.dart';
import 'package:flutter/material.dart';

class FormBuilderDivider extends StatelessWidget {
  const FormBuilderDivider(
      {required this.map, Key? key, this.ispreview = false})
      : super(key: key);

  final dynamic map;
  final bool ispreview;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 10,
          child: Divider(
            color: Colors.red,
          ),
        ),
        !ispreview
            ? Expanded(
                flex: 4,
                child: EditWidget(
                  map: map,
                  type: "pageDivider",
                ))
            : Container()
      ],
    );
  }
}
