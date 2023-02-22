import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/view/pages/home/home_page.dart';

import '../../controller/auth_controller.dart';

class GoogleFacebook extends StatelessWidget {
  const GoogleFacebook({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
              child: GestureDetector(
                 onTap: () async {
                  
            context.read<AuthController>().loginGoogle(() {
              
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                  (route) => false);
            });
          },
                child: Logo(
                          Logos.google,
                          size: 70,
                        ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
              child: Logo(
            Logos.facebook_logo,
            size: 70,
          )),
        ),
      ],
    );
  }
}
