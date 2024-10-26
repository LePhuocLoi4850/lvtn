import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/cart_item.dart';
import 'cart_manager.dart';
// import 'notification_manager.dart';

class MyNotification extends StatelessWidget {
  final String notification;
  final CartItem cardItem;

  const MyNotification({
    required this.notification,
    required this.cardItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cardItem.id),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        context.read<CartManager>().clearItem(notification);
        print(cardItem);
      },
      child: buildItemCard(),
    );
  }

  Widget buildItemCard() {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(cardItem.image),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ứng tuyển thành công'),
              Text(
                'Vị trí: ${cardItem.title}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// // import '../orders/order_manager.dart';
// import 'package:provider/provider.dart';

// import '../../models/cart_item.dart';
// import '../share/dialog_utils.dart';
// import 'cart_manager.dart';

// class MyNotification extends StatefulWidget {
//   static const routeName = '/cart';
//   final String notification;
//   final CartItem cardItem;

//   const MyNotification(
//       {required this.notification, required this.cardItem, super.key});

//   @override
//   State<MyNotification> createState() => _MyNotificationState();
// }

// class _MyNotificationState extends State<MyNotification> {
//   int _currentIndex = 0;
//   final List<bool> _isSelectedList = [true, false, false, false];

//   void _showMale(BuildContext ctx) {
//     showModalBottomSheet(
//       elevation: 10,
//       context: ctx,
//       builder: (ctx) => SizedBox(
//         width: 410,
//         height: 150,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               height: 50,
//               decoration: const BoxDecoration(color: Colors.grey),
//               child: const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Tùy chọn',
//                     style: TextStyle(fontSize: 24),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 15),
//               child: GestureDetector(
//                   onTap: () {},
//                   child: const Text(
//                     'Đánh dấu đã đọc',
//                     style: TextStyle(fontSize: 24),
//                   )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(width: 1.8, color: Colors.blue),
//                         borderRadius: BorderRadius.circular(50)),
//                     width: 130,
//                     height: 50,
//                     child: ToanBo(0),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(width: 1.8, color: Colors.blue),
//                         borderRadius: BorderRadius.circular(50)),
//                     width: 140,
//                     height: 50,
//                     child: TuyenDung(1),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(width: 1.8, color: Colors.blue),
//                         borderRadius: BorderRadius.circular(50)),
//                     width: 130,
//                     height: 50,
//                     child: ViecLam(2),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(width: 1.8, color: Colors.blue),
//                         borderRadius: BorderRadius.circular(50)),
//                     width: 130,
//                     height: 50,
//                     child: HeThong(3),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: IndexedStack(
//               index: _currentIndex,
//               children: [
//                 buildToanBo(),
//                 buildTuyenDung(),
//                 buildViecLam(),
//                 buildHeThong(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildToanBo() {
//     return Dismissible(
//       key: ValueKey(widget.cardItem.id),
//       background: Container(
//         color: Theme.of(context).colorScheme.error,
//         alignment: Alignment.centerRight,
//         padding: const EdgeInsets.only(right: 20),
//         margin: const EdgeInsets.symmetric(
//           horizontal: 15,
//           vertical: 4,
//         ),
//         child: const Icon(
//           Icons.delete,
//           color: Colors.white,
//           size: 40,
//         ),
//       ),
//       direction: DismissDirection.endToStart,
//       confirmDismiss: (direction) {
//         return showConfirmDialog(
//           context,
//           'Do you want to remove the item from the cart?',
//         );
//       },
//       onDismissed: (direction) {
//         context.read<CartManager>().clearItem(widget.notification);
//       },
//       child: Card(
//         margin: const EdgeInsets.symmetric(
//           horizontal: 15,
//           vertical: 4,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8),
//           child: ListTile(
//             leading: CircleAvatar(
//               backgroundImage: NetworkImage(widget.cardItem.image),
//             ),
//             title: Text(widget.cardItem.title),
//             subtitle: Text(
//                 'Total:${(widget.cardItem.luong * widget.cardItem.quantity)}vnđ'),
//             trailing: Text('sl:${widget.cardItem.quantity}'),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildTuyenDung() {
//     return Center(
//       child: Text(
//         'Tuyển Dụng',
//         style: TextStyle(fontSize: 20),
//       ),
//     );
//   }

//   Widget buildViecLam() {
//     return Center(
//       child: Text(
//         'Việc Làm',
//         style: TextStyle(fontSize: 20),
//       ),
//     );
//   }

//   Widget buildHeThong() {
//     return Center(
//       child: Text(
//         'Hệ Thống',
//         style: TextStyle(fontSize: 20),
//       ),
//     );
//   }

//   Widget buildSettingButton(BuildContext context) {
//     return IconButton(
//       onPressed: () => _showMale(context),
//       icon: const Icon(Icons.settings),
//     );
//   }

//   Widget ToanBo(int index) {
//     return ElevatedButton(
//       onPressed: () {
//         setState(() {
//           for (int i = 0; i < _isSelectedList.length; i++) {
//             if (i == index) {
//               _isSelectedList[i] = true;
//             } else {
//               _isSelectedList[i] = false;
//             }
//           }
//           _currentIndex = index;
//         });
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: _isSelectedList[index] ? Colors.blue : Colors.white,
//       ),
//       child: Text(
//         'Toàn bộ',
//         style: TextStyle(
//           fontSize: 15,
//           color: _isSelectedList[index] ? Colors.white : Colors.blue,
//         ),
//       ),
//     );
//   }

//   Widget TuyenDung(int index) {
//     return ElevatedButton(
//       onPressed: () {
//         setState(() {
//           for (int i = 0; i < _isSelectedList.length; i++) {
//             if (i == index) {
//               _isSelectedList[i] = true;
//             } else {
//               _isSelectedList[i] = false;
//             }
//           }
//           _currentIndex = index;
//         });
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: _isSelectedList[index] ? Colors.blue : Colors.white,
//       ),
//       child: Text(
//         'Tuyển Dụng',
//         style: TextStyle(
//           fontSize: 15,
//           color: _isSelectedList[index] ? Colors.white : Colors.blue,
//         ),
//       ),
//     );
//   }

//   Widget ViecLam(int index) {
//     return ElevatedButton(
//       onPressed: () {
//         setState(() {
//           for (int i = 0; i < _isSelectedList.length; i++) {
//             if (i == index) {
//               _isSelectedList[i] = true;
//             } else {
//               _isSelectedList[i] = false;
//             }
//           }
//           _currentIndex = index;
//         });
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: _isSelectedList[index] ? Colors.blue : Colors.white,
//       ),
//       child: Text(
//         'Việc làm',
//         style: TextStyle(
//           fontSize: 15,
//           color: _isSelectedList[index] ? Colors.white : Colors.blue,
//         ),
//       ),
//     );
//   }

//   Widget HeThong(int index) {
//     return ElevatedButton(
//       onPressed: () {
//         setState(() {
//           for (int i = 0; i < _isSelectedList.length; i++) {
//             if (i == index) {
//               _isSelectedList[i] = true;
//             } else {
//               _isSelectedList[i] = false;
//             }
//           }
//           _currentIndex = index;
//         });
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: _isSelectedList[index] ? Colors.blue : Colors.white,
//       ),
//       child: Text(
//         'Hệ thống',
//         style: TextStyle(
//           fontSize: 15,
//           color: _isSelectedList[index] ? Colors.white : Colors.blue,
//         ),
//       ),
//     );
//   }
// }
