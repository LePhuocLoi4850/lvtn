import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/cart_item.dart';
import '../cart/cart_manager.dart';
import '../job/job_detail_screen.dart';

class JobPending extends StatefulWidget {
  static const routeName = '/Pending';
  const JobPending({Key? key}) : super(key: key);

  @override
  _JobPendingState createState() => _JobPendingState();
}

class _JobPendingState extends State<JobPending> {
  @override
  Widget build(BuildContext context) {
    final cartManager = Provider.of<CartManager>(context);
    final List<CartItem> jobs = cartManager.jobs;
    final waitingJobs = jobs.where((job) => job.status == 'waiting').toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Công việc đang chờ duyệt',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: waitingJobs.isEmpty
          ? const Center(
              child: Text('Không có công việc đang chờ duyệt'),
            )
          : ListView.builder(
              itemCount: waitingJobs.length,
              itemBuilder: (context, index) {
                final cartItem = waitingJobs[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      JobDetailScreen.routeName,
                      arguments: cartItem.jobId,
                    );
                  },
                  child: Card(
                    elevation: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 200, 200, 200),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    cartItem.image,
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cartItem.title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.where_to_vote_rounded,
                                          color: Colors.green,
                                          size: 22,
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                              cartItem.user.name,
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  color: Color.fromARGB(
                                                      255, 158, 155, 145)),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.share_location_outlined,
                                    color: Colors.amber,
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 6),
                                      child: Text(
                                        cartItem.diaChi,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.monetization_on,
                                    color: Colors.amber,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 6),
                                    child: Text(
                                      '${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(cartItem.luong)}',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
