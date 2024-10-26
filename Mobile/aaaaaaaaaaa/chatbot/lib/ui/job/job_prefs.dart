import 'package:shared_preferences/shared_preferences.dart';

class JobPreferences {
  static const String _appliedJobsKey = 'applied_jobs';

  static Future<void> saveJobApplied(String jobId, bool isApplied) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> appliedJobs = await getAppliedJobs();
    if (isApplied) {
      if (!appliedJobs.contains(jobId)) {
        appliedJobs.add(jobId);
      }
    } else {
      appliedJobs.remove(jobId);
    }
    await prefs.setStringList(_appliedJobsKey, appliedJobs);
  }

  static Future<List<String>> getAppliedJobs() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_appliedJobsKey) ?? [];
  }
}
