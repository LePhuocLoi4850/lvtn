import 'package:flutter/material.dart';
import '/models/company.dart';

class CompanyDetailPage extends StatelessWidget {
  final Company company;
  const CompanyDetailPage({
    Key? key,
    required this.company,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giới thiệu công ty'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                company.imageUrl), // Sử dụng ảnh từ URL của công ty
            fit: BoxFit.cover, // Cách hiển thị của hình ảnh
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(0.0),
          child: Container(
              margin: EdgeInsets.only(top: 150),
              child: sheet(company: company)),
        ),
      ),
    );
  }
}

class sheet extends StatelessWidget {
  const sheet({
    super.key,
    required this.company,
  });

  final Company company;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 650,
          child: Card(
            elevation: 0,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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
                            color: const Color.fromARGB(255, 200, 200, 200),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            company.imageUrl,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Placeholder(
                                fallbackHeight: 70,
                                fallbackWidth: 70,
                              ); // hoặc thay thế bằng hình ảnh mặc định khác
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Column(
                                    children: [
                                      Text(
                                        company.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.all(8),
                    height: 1,
                    width: 360,
                    color: const Color.fromARGB(
                        255, 143, 143, 143), // Màu sắc của đường kẻ
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.share_location_outlined,
                          color: Colors.amber,
                        ),
                      ),
                      const Text(
                        'Địa chỉ:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                company.address,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'GIỚI THIỆU',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Text(
                                company.description,
                                style: const TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
