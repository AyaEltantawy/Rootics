import 'package:clippy_flutter/arc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rootics_final/controller/user_controller.dart';
import 'package:rootics_final/theme/app_colors.dart';
import 'package:rootics_final/theme/app_icons.dart';
import 'package:rootics_final/view/addProductAdvisor_page.dart';
import 'package:rootics_final/view/help_page.dart';
import 'package:rootics_final/view/login_page.dart';
import 'package:rootics_final/view/market_page.dart';
import 'package:rootics_final/view/myPlants_page.dart';
import 'package:rootics_final/view/profileInfo_page.dart';
import 'package:rootics_final/view/tasks_page.dart';

class ProfilePage extends StatelessWidget {
  final storage = GetStorage();
  final UserController userController = Get.put(UserController());

  void logout() {
    // Remove the token from storage
    storage.remove('token');

    // Navigate to login page
    Get.offNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Column(
    //     children: [
    //       Center(
    //         child: ElevatedButton(onPressed: logout, child: Text("logout")),
    //       ),
    //       Center(
    //         child: ElevatedButton(onPressed: ()=> Get.to(MarketPage()), child: Text("market")),
    //       ),
    //       Center(
    //         child: ElevatedButton(onPressed: ()=> Get.to(AddProductAdvisorPage()), child: Text("add product")),
    //       ),
    //     ],
    //   ),
    // );

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeitht = MediaQuery.of(context).size.height;
    //final navKey = GlobalKey<CurvedNavigationBarState>();
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Container(
            height: screenHeitht,
            width: screenWidth,
            decoration: BoxDecoration(
                gradient: RadialGradient(
                    colors: [AppColors().lightGreen, AppColors().darkGreen2],
                    focal: Alignment.center,
                    radius: .8)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Arc(
                          arcType: ArcType.CONVEX,
                          edge: Edge.BOTTOM,
                          height: 60,
                          child: Container(
                            height: screenHeitht * 0.28,
                            width: screenWidth,
                            color: AppColors().lightGreen,
                          )),
                      Arc(
                          arcType: ArcType.CONVEX,
                          edge: Edge.BOTTOM,
                          height: 60,
                          child: Container(
                            height: screenHeitht * 0.27,
                            width: screenWidth,
                            color: AppColors().darkGreen,
                          )),
                      Center(
                        child: Image.asset(
                          "lib/assets/images/logo.png",
                          width: 220,
                          height: 220,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeitht * 0.02,
                  ),
                  Container(
                    height: screenHeitht * 0.105,
                    width: screenWidth * 0.95,
                    decoration: BoxDecoration(
                      color: AppColors().darkGreen,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: InkWell(
                      onTap: () => Get.to(ProfileInfoPage()),
                      child: Obx(() {
                        if (userController.isLoading.value) {
                          return Center(child: CircularProgressIndicator());
                        } else if (userController.user.value == null) {
                          return Center(child: Text('No user data found'));
                        } else {
                          final user = userController.user.value;
                          return Row(children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 30),
                              child: CircleAvatar(
                                backgroundColor: AppColors().lightGreen,
                                backgroundImage: user.imageUrl != null
                                    ? NetworkImage(user.imageUrl!)
                                    : AssetImage('lib/assets/images/defaultUser.png')
                                        as ImageProvider,
                                radius: 30,
                                // child: Text(
                                //   userName[0].toUpperCase(),
                                //   style: TextStyle(
                                //       color: AppColors().darkGreen,
                                //       fontSize: 24,
                                //       fontWeight: FontWeight.bold),
                                // ),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    user.username!,
                                    style: TextStyle(
                                        color: AppColors().lightGreen,
                                        fontSize: 20),
                                  )),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Icon(
                              AppIcons.rightarrow,
                              color: AppColors().lightGreen,
                            )
                          ]);
                        }
                      }),
                    ),
                  ),
                  SizedBox(
                    height: screenHeitht * 0.02,
                  ),
                  Stack(
                    children: [
                      Arc(
                          arcType: ArcType.CONVEX,
                          edge: Edge.TOP,
                          height: 60,
                          child: Container(
                            height: screenHeitht * 1.1,
                            width: screenWidth,
                            color: AppColors().lightGreen,
                          )),
                      Positioned(
                        top: screenHeitht * 0.01,
                        child: Arc(
                            arcType: ArcType.CONVEX,
                            edge: Edge.TOP,
                            height: 60,
                            child: Container(
                              height: screenHeitht * 1.1,
                              width: screenWidth,
                              color: AppColors().darkGreen,
                            )),
                      ),
                      Positioned(
                        left: screenWidth * 0.03,
                        top: screenHeitht * 0.03,
                        child: Container(
                            height: screenHeitht * 1.1,
                            width: screenWidth * 0.95,
                            child: const Directionality(
                                textDirection: TextDirection.rtl,
                                child: ListV())),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class ListV extends StatefulWidget {
//   const ListV({super.key});

//   @override
//   State<ListV> createState() => _ListVState();
// }

// class _ListVState extends State<ListV> {
//   final storage = GetStorage();

//   void logout() {
//     storage.remove('token');
//     Get.offNamed('/login');
//   }

//   void pageRoute(int index) {
//     if (profileInfo.elementAt(index) == 4) {
//       logout();
//     } else {
//       Get.to(profileInfo.elementAt(index)['page']);
//     }
//   }

//   final List<Map> profileInfo = [
//     {
//       "icon": AppIcons.flowers,
//       "info": "نباتاتي",
//       "page": const MyPlantsPage(),
//     },
//     {
//       "icon": AppIcons.task,
//       "info": "قائمة المهام",
//       "page": TasksPage(),
//     },
//     {
//       "icon": AppIcons.shope,
//       "info": "السوق",
//       "page": MarketPage(),
//     },
//     {
//       "icon": AppIcons.help,
//       "info": "المساعدة",
//       "page": const HelpPage(),
//     },
//     {
//       "icon": AppIcons.logout,
//       "info": "تسجيل الخروج",
//       "page": const LoginPage(),
//     }
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: profileInfo.length,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: GestureDetector(
//             onTap: () => pageRoute(index),
//             child: Container(
//               decoration: BoxDecoration(
//                   color: AppColors().darkGreen3,
//                   borderRadius: BorderRadius.circular(30),
//                   border: Border.all(color: AppColors().lightGreen, width: 5)),
//               child: ListTile(
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 10),
//                 leading: Icon(profileInfo.elementAt(index)['icon']),
//                 title: Text(
//                   "${profileInfo.elementAt(index)['info']}",
//                   style: TextStyle(
//                       color: AppColors().lightGreen,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 trailing: const Icon(AppIcons.leftarrow),
//                 iconColor: AppColors().lightGreen,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

class ListV extends StatefulWidget {
  const ListV({super.key});

  @override
  State<ListV> createState() => _ListVState();
}

class _ListVState extends State<ListV> {
  final storage = GetStorage();

  void logout() {
    storage.remove('token');
    Get.offNamed('/login');
  }

  final List<Map> profileInfo = [
    {
      "icon": AppIcons.flowers,
      "info": "نباتاتي",
      "page": const MyPlantsPage(),
    },
    {
      "icon": AppIcons.task,
      "info": "قائمة المهام",
      "page": TasksPage(),
    },
    {
      "icon": AppIcons.shope,
      "info": "السوق",
      "page": MarketPage(),
    },
    {
      "icon": AppIcons.help,
      "info": "المساعدة",
      "page": const HelpPage(),
    }
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.custom(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      childrenDelegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index == profileInfo.length) {
            // Different button at the end
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: logout,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors().darkGreen3,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: AppColors().lightGreen, width: 5),
                  ),
                  child: GestureDetector(
                    onTap: () => logout(),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      leading: Icon(AppIcons.logout),
                      title: Text(
                        "تسجيل الخروج",
                        style: TextStyle(
                          color: AppColors().lightGreen,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: const Icon(AppIcons.leftarrow),
                      iconColor: AppColors().lightGreen,
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => Get.to(profileInfo.elementAt(index)['page']),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors().darkGreen3,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: AppColors().lightGreen, width: 5),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    leading: Icon(profileInfo.elementAt(index)['icon']),
                    title: Text(
                      "${profileInfo.elementAt(index)['info']}",
                      style: TextStyle(
                        color: AppColors().lightGreen,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Icon(AppIcons.leftarrow),
                    iconColor: AppColors().lightGreen,
                  ),
                ),
              ),
            );
          }
        },
        childCount: profileInfo.length + 1, // One extra for the logout button
      ),
    );
  }
}

