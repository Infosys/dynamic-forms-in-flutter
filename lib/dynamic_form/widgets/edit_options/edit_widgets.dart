// “Copyright 2022 Infosys Ltd.
// Use of this source code is governed by Apache License 2.0 that can be found in the LICENSE file or at
// http://www.apache.org/licenses/LICENSE-2.0 .”

import 'package:dynamic_forms/dynamic_form/dynamic_form_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditWidget extends StatelessWidget {
  const EditWidget({required this.map, required this.type, Key? key})
      : super(key: key);

  final dynamic map;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green[100],
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: GestureDetector(
              onTap: () {
                context.read<DynamicFormModel>().moveup(map);
              },
              child: const ImageIcon(
                AssetImage('dynamic_form_edit_icon/arrow-up.png'),
                size: 20,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green[100],
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: GestureDetector(
              onTap: () {
                context.read<DynamicFormModel>().movedown(map);
              },
              child: const ImageIcon(
                AssetImage('dynamic_form_edit_icon/arrow-down.png'),
                size: 20,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: GestureDetector(
            onTap: () {
              int index =
                  context.read<DynamicFormModel>().getForm!.indexOf(map);
              context.read<DynamicFormModel>().setadding(true, index);
            },
            child: const ImageIcon(
              AssetImage('dynamic_form_edit_icon/add.png'),
              size: 25,
              color: Colors.green,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: GestureDetector(
            onTap: () {
              context.read<DynamicFormModel>().removefromform(map);
            },
            child: const ImageIcon(
              AssetImage('dynamic_form_edit_icon/trash.png'),
              size: 25,
              color: Colors.redAccent,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: GestureDetector(
            onTap: () {
              context.read<DynamicFormModel>().setFieldType(type);
              context.read<DynamicFormModel>().setedit(true, map);
            },
            child: const ImageIcon(
              AssetImage('dynamic_form_edit_icon/gear.png'),
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
