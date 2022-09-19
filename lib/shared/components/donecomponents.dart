import 'package:app1/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  required VoidCallback function,
  required String text,
}) =>
    Container(
      width: width,
      color: background,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultFromField({
  bool isClickable = true,
  bool readOnly = false,
  required TextEditingController controller,
  required TextInputType type,
  VoidCallback? Function(String s)? onSubmit,
  required String? Function(String? s) validate,
  required String label,
  required IconData prefixIcon,
  IconData? suffixIcon,
  bool isPassword = false,
  VoidCallback? suffixPressed,
  VoidCallback? onTap,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      validator: validate,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffixIcon))
            : null,
        border: OutlineInputBorder(),
      ),
      onTap: onTap,
      enabled: isClickable,
      readOnly: readOnly,
      // showCursor: true,
    );

Widget buildTaskItem(Map model, context) {
  return Dismissible(
    key: Key(model['id'].toString()),
    onDismissed: (direction) {
      AppCubit.get(context).deleteData(id: model['id']);
    },
    background: Container(color: Colors.red[300], padding: const EdgeInsets.all(9.0),
      child: Text(
        'Delete?!',
        style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold
        ),
      ),
    ),
    child: Material(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              backgroundColor: Colors.greenAccent[200],
              child: Text('${model['time']}', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${model['description']}',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'new', id: model['id']);
              },
              icon: Icon(Icons.autorenew_outlined, color: Colors.blue[300],size: 30,),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'archived', id: model['id']);
              },
              icon: Icon(Icons.archive_outlined, color: Colors.blueGrey[300],size: 30,),
            ),
          ],
        ),
      ),
    ),
  );
}