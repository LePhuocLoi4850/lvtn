import 'package:flutter/material.dart';
import '../../models/career.dart';

class CareerGridTile extends StatelessWidget {
  const CareerGridTile(
    this.career, {
    super.key,
  });
  final Career career;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: GridTile(
        child: GestureDetector(
          onTap: () {},
          child: Card(
            elevation: 0.0,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 190,
                    height: 130,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 175, 175, 175),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        career.image,
                        width: 190,
                        height: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    career.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
