import 'package:flutter/material.dart';




// import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'package:stacked/stacked.dart';
import 'package:zc_desktop_flutter/ui/appbar/app_bar.dart';
import 'package:zc_desktop_flutter/ui/views/profile_dialog/profile_dialog_view.dart';
import 'package:zc_desktop_flutter/ui/views/widgets/center_list_tile/center_tile.dart';

import 'package:zc_desktop_flutter/ui/views/widgets/popup_menu_button.dart';


import 'package:zcdesk_ui/zcdesk_ui.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(child: buildAppBar(context, true)),
            buildMenuItem(context),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      'Welcome ${model.testString}',
                      style: headline3,
                    ),
                  ),
     
                    alignment: Alignment.topCenter,
                    child: centertitlecard(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}