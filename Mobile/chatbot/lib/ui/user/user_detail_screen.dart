// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:intl/intl.dart';

// import '../../models/user.dart';

// class UserDetailScreen extends StatelessWidget {
//   static const routeName = '/user-detail';
//   const UserDetailScreen(
//     this.user, {
//     super.key,
//   });

//   final UserData user;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Chi tiêt việc làm'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             CardUser(user: user),
//           ],
//         ),
//       ),
//       bottomNavigationBar: const BottomButton(),
//     );
//   }
// }

// class CardUser extends StatelessWidget {
//   const CardUser({
//     super.key,
//     required this.user,
//   });

//   final UserData user;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 0.0,
//       color: Colors.white,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             DetailuserOne(user: user),
//             const SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: 170,
//                   height: 35,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromARGB(255, 211, 211, 211),
//                       shape: RoundedRectangleBorder(
//                         borderRadius:
//                             BorderRadius.circular(8), // Đặt borderRadius
//                       ), // Đặt màu nền cho nút
//                     ),
//                     onPressed: () {
//                       // Navigator.push(
//                       //     context,
//                       //     MaterialPageRoute(
//                       //         builder: (context) =>
//                       //             CompanyDetailPage(company: user.company)));
//                     },
//                     child: const Text(
//                       'Thông tin công ty',
//                       style: TextStyle(
//                           color: Colors.purple, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: 170,
//                   height: 35,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromARGB(
//                           255, 211, 211, 211), // Đặt màu nền cho nút
//                       shape: RoundedRectangleBorder(
//                         borderRadius:
//                             BorderRadius.circular(8), // Đặt borderRadius
//                       ),
//                     ),
//                     onPressed: () {
//                       // Navigator.push(
//                       //     context,
//                       //     MaterialPageRoute(
//                       //         builder: (context) => CompanyuserListPage(
//                       //               company: user.company,
//                       //             )));
//                     },
//                     child: const Text(
//                       'Việc làm khác',
//                       style: TextStyle(
//                           color: Colors.purple, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             const SizedBox(height: 10),
//             Container(
//               margin: const EdgeInsets.all(8),
//               height: 1,
//               width: 360,
//               color: const Color.fromARGB(
//                   255, 143, 143, 143), // Màu sắc của đường kẻ
//             ),
//             const SizedBox(height: 10),
//             // Thông tin công việc
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'THÔNG TIN CÔNG VIỆC',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//                 // lương
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8),
//                   child: Row(
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(right: 8),
//                         child: Icon(
//                           Icons.monetization_on,
//                           color: Colors.amber,
//                         ),
//                       ),
//                       const Text(
//                         'Mức lương:',
//                         style: TextStyle(
//                             fontSize: 17, fontWeight: FontWeight.bold),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 6),
//                         child: Text(
//                           '${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(user.luong)}',
//                           style: const TextStyle(
//                             fontSize: 17,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 //loại cv
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8),
//                   child: Row(
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(right: 8),
//                         child: Icon(
//                           Icons.wallet_travel_outlined,
//                           color: Colors.amber,
//                         ),
//                       ),
//                       const Text(
//                         'Loại hình công việc:',
//                         style: TextStyle(
//                             fontSize: 17, fontWeight: FontWeight.bold),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 6),
//                         child: Text(
//                           user.loai,
//                           style: const TextStyle(
//                             fontSize: 17,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 //số lượng
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8),
//                   child: Row(
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(right: 8),
//                         child: Icon(
//                           Icons.groups_outlined,
//                           color: Colors.amber,
//                         ),
//                       ),
//                       const Text(
//                         'Số lượng cần tuyển:',
//                         style: TextStyle(
//                             fontSize: 17, fontWeight: FontWeight.bold),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 6),
//                         child: Text(
//                           '${user.soluong.toStringAsFixed(0)} người',
//                           style: const TextStyle(
//                             fontSize: 17,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 //địa chỉ làm viêc
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(right: 8),
//                         child: Icon(
//                           Icons.wallet_travel_outlined,
//                           color: Colors.amber,
//                         ),
//                       ),
//                       const Text(
//                         'Địa chỉ làm việc:',
//                         style: TextStyle(
//                             fontSize: 17, fontWeight: FontWeight.bold),
//                       ),
//                       Flexible(
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 6),
//                           child: Text(
//                             user.diachi,
//                             softWrap: true,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Container(
//               margin: const EdgeInsets.all(8),
//               height: 1,
//               width: 360,
//               color: const Color.fromARGB(
//                   255, 143, 143, 143), // Màu sắc của đường kẻ
//             ),
//             const SizedBox(height: 10),
//             //lịch làm việc
//             Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               const Text(
//                 'Lịch LÀM VIỆC',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 ),
//               ),
//               // Thời gian
//               Padding(
//                   padding: const EdgeInsets.only(top: 8),
//                   child: Column(
//                     children: [
//                       const Row(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.only(right: 8),
//                             child: Icon(
//                               Icons.watch_later_outlined,
//                               color: Colors.amber,
//                             ),
//                           ),
//                           Text(
//                             'Thời gian làm việc:',
//                             style: TextStyle(
//                                 fontSize: 17, fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                       Align(
//                         alignment: Alignment.topLeft,
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 34),
//                           child: Text(
//                             user.lich,
//                             style: const TextStyle(
//                               fontSize: 17,
//                             ),
//                             maxLines: 10, // Số dòng tối đa
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ),
//                     ],
//                   )),
//             ]),
//             const SizedBox(height: 10),
//             Container(
//               margin: const EdgeInsets.all(8),
//               height: 1,
//               width: 360,
//               color: const Color.fromARGB(
//                   255, 143, 143, 143), // Màu sắc của đường kẻ
//             ),
//             const SizedBox(height: 10),
//             //yêu cầu
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'YÊU CẦU',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//                 // giới tính
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8),
//                   child: Row(
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(right: 8),
//                         child: FaIcon(
//                           FontAwesomeIcons.venusMars,
//                           color: Colors.amber,
//                           size: 20,
//                         ),
//                       ),
//                       const Text(
//                         'Giới tính:',
//                         style: TextStyle(
//                             fontSize: 17, fontWeight: FontWeight.bold),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 6),
//                         child: Text(
//                           user.gioitinh,
//                           style: const TextStyle(
//                             fontSize: 17,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 //độ tuổi
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8),
//                   child: Row(
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(right: 8),
//                         child: Icon(
//                           Icons.cake_outlined,
//                           color: Colors.amber,
//                         ),
//                       ),
//                       const Text(
//                         'Độ tuổi:',
//                         style: TextStyle(
//                             fontSize: 17, fontWeight: FontWeight.bold),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 6),
//                         child: Text(
//                           user.tuoi,
//                           style: const TextStyle(
//                             fontSize: 17,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 //học vấn
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8),
//                   child: Row(
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(right: 8),
//                         child: FaIcon(
//                           FontAwesomeIcons.graduationCap,
//                           color: Colors.amber,
//                           size: 20,
//                         ),
//                       ),
//                       const Text(
//                         'Học vấn:',
//                         style: TextStyle(
//                             fontSize: 17, fontWeight: FontWeight.bold),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 6),
//                         child: Text(
//                           user.hocvan,
//                           style: const TextStyle(
//                             fontSize: 17,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 //kinh nghiệm
//                 Column(
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.only(top: 8),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.only(right: 8),
//                             child: FaIcon(
//                               FontAwesomeIcons.medal,
//                               color: Colors.amber,
//                               size: 20,
//                             ),
//                           ),
//                           Text(
//                             'Kinh nghiệm:',
//                             style: TextStyle(
//                                 fontSize: 17, fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.topLeft,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 34),
//                         child: Text(
//                           user.kinhnghiem,
//                           style: const TextStyle(
//                             fontSize: 17,
//                           ),
//                           maxLines: 10, // Số dòng tối đa
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Container(
//               margin: const EdgeInsets.all(8),
//               height: 1,
//               width: 360,
//               color: const Color.fromARGB(
//                   255, 143, 143, 143), // Màu sắc của đường kẻ
//             ),
//             const SizedBox(height: 10),
//             //mô tả
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'MÔ TẢ CÔNG VIỆC',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 5),
//                   child: Text(
//                     user.description,
//                     style: const TextStyle(
//                         fontSize: 17,
//                         color: Color.fromARGB(255, 158, 155, 145)),
//                     maxLines: 20, // Số dòng tối đa
//                     overflow:
//                         TextOverflow.ellipsis, // Tràn dòng với dấu chấm elipsis
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Container(
//               margin: const EdgeInsets.all(8),
//               height: 1,
//               width: 360,
//               color: const Color.fromARGB(
//                   255, 143, 143, 143), // Màu sắc của đường kẻ
//             ),
//             const SizedBox(height: 10),
//             // yêu cầu khác
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'YÊU CẦU KHÁC',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8),
//                   child: Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 6),
//                         child: Text(
//                           user.yeucaukhac,
//                           style: const TextStyle(
//                             fontSize: 17,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Container(
//               margin: const EdgeInsets.all(8),
//               height: 1,
//               width: 360,
//               color: const Color.fromARGB(
//                   255, 143, 143, 143), // Màu sắc của đường kẻ
//             ),
//             const SizedBox(height: 10),
//             // phúc lợi
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'PHÚC LỢI',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8),
//                   child: Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 6),
//                         child: Text(
//                           user.phucloi,
//                           style: const TextStyle(
//                             fontSize: 17,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DetailuserOne extends StatelessWidget {
//   const DetailuserOne({
//     super.key,
//     required this.user,
//   });

//   final user user;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           width: 70,
//           height: 70,
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: const Color.fromARGB(255, 200, 200, 200),
//             ),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: Image.network(
//               user.imageUrl,
//               width: 70,
//               height: 70,
//               fit: BoxFit.cover,
//               errorBuilder: (context, error, stackTrace) {
//                 return const Placeholder(
//                   fallbackHeight: 70,
//                   fallbackWidth: 70,
//                 );
//               },
//             ),
//           ),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Flexible(
//                     child: Column(
//                       children: [
//                         Text(
//                           user.title,
//                           style: const TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 17),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         Row(
//                           children: [
//                             const Icon(
//                               Icons.where_to_vote_rounded,
//                               color: Colors.green,
//                               size: 22,
//                             ),
//                             Flexible(
//                               child: Padding(
//                                 padding: const EdgeInsets.only(left: 5),
//                                 child: Text(
//                                   user.description,
//                                   style: const TextStyle(
//                                       fontSize: 17,
//                                       color:
//                                           Color.fromARGB(255, 158, 155, 145)),
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 8),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class BottomButton extends StatelessWidget {
//   const BottomButton({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 120,
//       child: BottomAppBar(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             Container(
//               width: 150,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 167, 16, 139),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8), // Đặt borderRadius
//                   ), // Đặt màu nền cho nút
//                 ),
//                 child: const Text(
//                   'Ứng Tuyển',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 onPressed: () {
//                   // Xử lý khi nút được nhấn
//                 },
//               ),
//             ),
//             Container(
//               width: 150,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 6, 204, 55),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8), // Đặt borderRadius
//                   ), // Đặt màu nền cho nút
//                 ),
//                 child: const Text('Gọi Ngay',
//                     style: TextStyle(color: Colors.white)),
//                 onPressed: () {
//                   // Xử lý khi nút được nhấn
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
