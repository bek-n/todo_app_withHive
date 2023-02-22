import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:todo_app/controller/notes_controller.dart';

import '../style/style.dart';
import 'home_page.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  TextEditingController note = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();

  bool isEmpty = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo',
            style:
                Style.textStyleRegular(size: 20, textColor: Style.whiteColor)),
        backgroundColor: const Color(0xff24A19C),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextFormField(
              style: Style.textStyleRegular2(),
              controller: note,
              onChanged: (value) {
                if (value.isEmpty) {
                  isEmpty = true;
                } else {
                  isEmpty = false;
                }
                setState(() {});
              },
              decoration: InputDecoration(
                  label: const Text('Write your notes'),
                  labelStyle: Style.textStyleRegular2(size: 20),
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(35)),
                      borderSide: BorderSide(color: Style.primaryColor)),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(35)),
                      borderSide: BorderSide(color: Style.primaryColor))),
            ),
          ),
          150.verticalSpace,
          GestureDetector(
            onTap: () {
              if (note.text.isNotEmpty) {
                context.read<ToDoController>().createNote(
                    name: note.text, date: DateTime.now().toString());
                QuickAlert.show(
                  // autoCloseDuration: Duration(seconds: 2),
                  animType: QuickAlertAnimType.slideInUp,
                  confirmBtnColor: const Color(0xff24A19C),
                  context: context,
                  type: QuickAlertType.success,
                  text: 'Todo added Successfully!',
                  onConfirmBtnTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const HomePage())),
                        (route) => false);
                  },
                );
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              height: 60.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: isEmpty
                      ? Style.primaryDisabledGradient
                      : Style.linearGradient,
                  borderRadius: const BorderRadius.all(Radius.circular(100))),
              child: Center(
                child: Text(
                  'Add',
                  style: Style.textStyleRegular(textColor: Style.whiteColor),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
