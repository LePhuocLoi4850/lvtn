import 'package:flutter/material.dart';

import 'candidate_grid_tile.dart';
import 'candidate_manager.dart';

class CandidateGrid extends StatelessWidget {
  static const routeName = '/candidate';

  const CandidateGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final candidateManager = CandidateManager();
    final candidate = candidateManager.allCandidate;
    return ListView.builder(
      padding: const EdgeInsets.all(5.0),
      itemCount: candidate.length,
      itemExtent: 252,
      itemBuilder: (ctx, i) => Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 200, 200, 200)),
            borderRadius: BorderRadius.circular(8)),
        child: CandidateGirdTile(candidate[i]),
      ),
    );
  }
}
