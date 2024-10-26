import 'package:chatbot/ui/company/candidate.dart';
import 'package:chatbot/ui/job/list_jobs.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../list/edit_product_screen.dart';
import '../list/number.dart';
import '../cart/cart_company_screen.dart';
import '../cart/cart_manager.dart';
import '../cart/notification_manager.dart';

import '../user_provider.dart';
import '../list/admin_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'top_right_badge.dart';

class CompanyOverviewScreen extends StatefulWidget {
  const CompanyOverviewScreen({super.key});

  @override
  State<CompanyOverviewScreen> createState() => _CompanyOverviewScreenState();
}

class _CompanyOverviewScreenState extends State<CompanyOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 830,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/companybackground.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60, left: 40, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Xin chào nhà tuyển dụng',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50)),
                      child: buildRingIcon(),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blue,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.person_2_rounded,
                                size: 40,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 240,
                            height: 70,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    user?.name ?? '',
                                    style: TextStyle(fontSize: 22),
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 18,
                          ),
                        ],
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Danh mục của bạn ',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // danh mục của bạn
                            Category(),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Dịch vụ của bạn',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //dịch vụ cua bạn
                            Service(),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Dành cho bạn',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //dành cho bạn
                            ForYou()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRingIcon() {
    return Consumer<NotificationManager>(
      builder: (context, notificationManager, child) => TopRightBadge(
        data: notificationManager.jobCount,
        child: IconButton(
          icon: const Icon(
            Icons.notifications_rounded,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(CartCompanyScreen.routeName);
          },
        ),
      ),
    );
  }
}

class ForYou extends StatelessWidget {
  const ForYou({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 89,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(255, 255, 207, 223)),
                  child: const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: FaIcon(
                      FontAwesomeIcons.gift,
                      size: 28,
                      color: Colors.pink,
                    ),
                  ),
                ),
              ),
              const Text(
                'Quà tặng',
                style: TextStyle(
                  fontSize: 14, // Kích thước của văn bản
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Container(
          width: 89,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(255, 255, 250, 208)),
                  child: const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: FaIcon(
                      FontAwesomeIcons.medal,
                      size: 28,
                      color: Colors.yellow,
                    ),
                  ),
                ),
              ),
              const Text(
                'Tích điểm',
                style: TextStyle(
                  fontSize: 14, // Kích thước của văn bản
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Container(
          width: 89,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(255, 253, 200, 197)),
                  child: const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: FaIcon(
                      FontAwesomeIcons.tags,
                      size: 28,
                      color: Color.fromARGB(255, 255, 0, 0),
                    ),
                  ),
                ),
              ),
              const Text(
                'Ưu đãi',
                style: TextStyle(
                  fontSize: 14, // Kích thước của văn bản
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Service extends StatelessWidget {
  const Service({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 89,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListJob()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 255, 212, 209)),
                    child: const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: FaIcon(
                        FontAwesomeIcons.chalkboardUser,
                        size: 28,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
              const Text(
                'Dịch vụ ',
                style: TextStyle(
                  fontSize: 14, // Kích thước của văn bản
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Container(
          width: 89,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NumberFormatDemo()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 184, 255, 186)),
                    child: const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: FaIcon(
                        FontAwesomeIcons.wallet,
                        size: 28,
                        color: Color.fromARGB(255, 9, 160, 12),
                      ),
                    ),
                  ),
                ),
              ),
              const Text(
                'Ví của tôi',
                style: TextStyle(
                  fontSize: 14, // Kích thước của văn bản
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Category extends StatelessWidget {
  const Category({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 89,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      EditJobScreen.routeName,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 255, 235, 222)),
                    child: const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: FaIcon(
                        FontAwesomeIcons.solidPaperPlane,
                        size: 28,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
              ),
              const Text(
                'Đăng tin tuyển dụng',
                style: TextStyle(
                  fontSize: 14, // Kích thước của văn bản
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Container(
          width: 89,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      UserJobsScreen.routeName,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(255, 212, 255, 212),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: FaIcon(
                        FontAwesomeIcons.tableList,
                        size: 28,
                        color: Color.fromARGB(255, 66, 194, 70),
                      ),
                    ),
                  ),
                ),
              ),
              const Text(
                'Quản lí tin đăng',
                style: TextStyle(
                  fontSize: 14, // Kích thước của văn bản
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Container(
          width: 89,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    final cartManager = context.read<CartManager>();
                    print(cartManager);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CartItemListPage(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 220, 238, 255)),
                    child: const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: FaIcon(
                        FontAwesomeIcons.addressBook,
                        size: 28,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
              const Text(
                'Quản lí ứng viên',
                style: TextStyle(
                  fontSize: 14, // Kích thước của văn bản
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
