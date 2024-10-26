import 'package:flutter/material.dart';

import 'company_grid_tile.dart';
import 'company_manager.dart';

class CompanyGrid extends StatelessWidget {
  const CompanyGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final companyManager = CompanyManager();
    final company = companyManager.allCompany;
    return ListView.builder(
      padding: const EdgeInsets.all(5.0),
      itemCount: company.length,
      itemExtent: 130,
      itemBuilder: (ctx, i) => Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 200, 200, 200)),
            borderRadius: BorderRadius.circular(8)),
        child: CompanyGirdTile(company[i]),
      ),
    );
  }
}
