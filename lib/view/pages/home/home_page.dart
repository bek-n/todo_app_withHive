import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/notes_controller.dart';
import 'package:todo_app/view/pages/home/todo_page.dart';
import '../../../controller/user_controller.dart';
import '../../components/cached_network_image.dart';
import '../style/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserController>().getUser();
      context.read<ToDoController>().getNote();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          CustomImageNetwork(
              radius: 50,
              height: 80.h,
              width: 80.w,
              image: context.watch<UserController>().user?.avatar ?? ""),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: context.watch<ToDoController>().boxTodo?.values.length?? 0,
              itemBuilder: ((context, index) => Padding(
                    padding:
                        const EdgeInsets.only(left: 24, right: 24, top: 24),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                          color: Style.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Row(
                        children: [
                          23.horizontalSpace,
                          Text(
                           context.watch<ToDoController>().boxTodo?.values.elementAt(index).title ?? '',
                            style: Style.textStyleRegular(),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ),
        ],
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: ((context) => const ToDoPage())));
        },
        child: Container(
          width: 65.w,
          height: 65.h,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, gradient: Style.linearGradient),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
