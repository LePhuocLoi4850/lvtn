import 'dart:convert';
// import '/models/user.dart';
import 'package:http/http.dart' as http;
import '../models/job.dart';
import '../models/auth_token.dart';
import 'firebase_service.dart';
import 'package:diacritic/diacritic.dart';

class JobsService extends FirebaseService {
  JobsService([AuthToken? authToken]) : super(authToken);

  String removeDiacritic(String input) {
    return removeDiacritics(input).toLowerCase();
  }

  Future<List<Job>> searchTitle(String? title) async {
    final List<Job> jobs = [];

    try {
      final jobsUrl = Uri.parse('$databaseUrl/jobs.json?auth=$token');

      final reponse = await http.get(jobsUrl);
      final jobsMap = json.decode(reponse.body) as Map<String, dynamic>;

      if (reponse.statusCode != 200) {
        return jobs;
      }
      final userFavoritesUrl =
          Uri.parse('$databaseUrl/userFavorites/$userId.json?auth=$token');
      final userFavoritesReponse = await http.get(userFavoritesUrl);
      final userFavoritesMap = json.decode(userFavoritesReponse.body);

      jobsMap.forEach((jobId, job) {
        String title1 = (job['title'] as String?) ?? "";

        String normalizedTitle = removeDiacritic(title1.toLowerCase());

        String normalizedSearchString = removeDiacritic(title!.toLowerCase());

        if (normalizedTitle.contains(normalizedSearchString)) {
          final isFavorite = (userFavoritesMap == null)
              ? false
              : (userFavoritesMap[jobId] ?? false);
          jobs.add(
            Job.fromJson({
              'id': jobId,
              ...job,
            }).copyWith(isFavorite: isFavorite),
          );
        }
      });
      return jobs;
    } catch (error) {
      print(error);
      return jobs;
    }
  }

  Future<List<Job>> searchAddress(String? diachi) async {
    final List<Job> jobs = [];

    try {
      final jobsUrl = Uri.parse('$databaseUrl/jobs.json?auth=$token');

      final reponse = await http.get(jobsUrl);
      final jobsMap = json.decode(reponse.body) as Map<String, dynamic>;

      if (reponse.statusCode != 200) {
        return jobs;
      }
      final userFavoritesUrl =
          Uri.parse('$databaseUrl/userFavorites/$userId.json?auth=$token');
      final userFavoritesReponse = await http.get(userFavoritesUrl);
      final userFavoritesMap = json.decode(userFavoritesReponse.body);

      jobsMap.forEach((jobId, job) {
        String address = (job['diachi'] as String?) ?? "";

        String normalizedTitle = removeDiacritic(address.toLowerCase());

        String normalizedSearchString = removeDiacritic(diachi!.toLowerCase());

        if (normalizedTitle.contains(normalizedSearchString)) {
          final isFavorite = (userFavoritesMap == null)
              ? false
              : (userFavoritesMap[jobId] ?? false);
          jobs.add(
            Job.fromJson({
              'id': jobId,
              ...job,
            }).copyWith(isFavorite: isFavorite),
          );
        }
      });
      print(jobsMap);
      print(jobs);
      return jobs;
    } catch (error) {
      print(error);
      return jobs;
    }
  }

  Future<List<Job>> searchCareer(String? nganhnghe) async {
    final List<Job> jobs = [];

    try {
      final jobsUrl = Uri.parse('$databaseUrl/jobs.json?auth=$token');

      final reponse = await http.get(jobsUrl);
      final jobsMap = json.decode(reponse.body) as Map<String, dynamic>;

      if (reponse.statusCode != 200) {
        return jobs;
      }

      jobsMap.forEach((jobId, job) {
        String careers = (job['nganhnghe'] as String?) ?? "";
        String normalizedTitle = removeDiacritic(careers.toLowerCase());
        String normalizedSearchString =
            removeDiacritic(nganhnghe!.toLowerCase());

        if (normalizedTitle.contains(normalizedSearchString)) {
          jobs.add(
            Job.fromJson({
              'id': jobId,
              ...job,
            }),
          );
        }
      });
      print(jobsMap);

      print(jobs);
      return jobs;
    } catch (error) {
      print(error);
      return jobs;
    }
  }

  Future<List<Job>> fetchJobs() async {
    final List<Job> jobs = [];

    try {
      final jobsUrl = Uri.parse('$databaseUrl/jobs.json?auth=$token');

      final reponse = await http.get(jobsUrl);
      final jobsMap = json.decode(reponse.body) as Map<String, dynamic>;

      if (reponse.statusCode != 200) {
        print(jobsMap['error']);
        return jobs;
      }
      jobsMap.forEach((jobId, job) {
        jobs.add(Job.fromJson({
          'id': jobId,
          ...job,
        }));
      });
      return jobs;
    } catch (error) {
      print(error);
      return jobs;
    }
  }

  Future<List<Job>> fetchUserJobs(String userId) async {
    final List<Job> userJobs = [];

    try {
      final jobsUrl = Uri.parse('$databaseUrl/jobs.json?auth=$token');

      final response = await http.get(jobsUrl);
      final jobsMap = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        print(jobsMap['error']);
        return userJobs;
      }

      jobsMap.forEach((jobId, jobData) {
        final job = Job.fromJson({
          'id': jobId,
          ...jobData,
        });
        if (job.creatorId == userId) {
          userJobs.add(job);
        }
      });

      return userJobs;
    } catch (error) {
      print(error);
      return userJobs;
    }
  }

  // Future<List<Job>> fetchJobs() async {
  //   final List<Job> jobs = [];

  //   try {
  //     final jobsUrl = Uri.parse('$databaseUrl/jobs.json?auth=$token');

  //     final response = await http.get(jobsUrl);
  //     final jobsMap = json.decode(response.body) as Map<String, dynamic>;

  //     if (response.statusCode != 200) {
  //       print(jobsMap['error']);
  //       return jobs;
  //     }

  //     final userFavoritesUrl =
  //         Uri.parse('$databaseUrl/userFavorites/$userId.json?auth=$token');
  //     final userFavoritesResponse = await http.get(userFavoritesUrl);
  //     final userFavoritesMap = json.decode(userFavoritesResponse.body);

  //     jobsMap.forEach((jobId, job) {
  //       if (job['userId'] == userId) {
  //         final isFavorite = (userFavoritesMap == null)
  //             ? false
  //             : (userFavoritesMap[jobId] ?? false);
  //         jobs.add(
  //           Job.fromJson({
  //             'id': jobId,
  //             ...job,
  //           }).copyWith(isFavorite: isFavorite),
  //         );
  //       }
  //     });
  //     return jobs;
  //   } catch (error) {
  //     print(error);
  //     return jobs;
  //   }
  // }

  Future<Job?> addJob(Job job) async {
    try {
      final url = Uri.parse('$databaseUrl/jobs.json?auth=$token');
      final response = await http.post(
        url,
        body: json.encode(
          job.toJson()
            ..addAll({
              'creatorId': userId,
            }),
        ),
      );
      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      return job.copyWith(
        id: json.decode(response.body)['name'],
      );
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<bool> updateJob(Job job) async {
    try {
      final url = Uri.parse('$databaseUrl/jobs/${job.id}.json?auth=$token');
      final reponse = await http.patch(
        url,
        body: json.encode(job.toJson()),
      );

      if (reponse.statusCode != 200) {
        throw Exception(json.decode(reponse.body)['error']);
      }
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> deleteJob(String id) async {
    try {
      final url = Uri.parse('$databaseUrl/jobs/$id.json?auth=$token');
      final reponse = await http.delete(url);

      if (reponse.statusCode != 200) {
        throw Exception(json.decode(reponse.body)['error']);
      }
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> saveFavoriteStatus(Job job) async {
    try {
      final url = Uri.parse(
          '$databaseUrl/userFavorites/$userId/${job.id}.json?auth=$token');
      final reponse = await http.put(
        url,
        body: json.encode(
          job.isFavorite,
        ),
      );
      if (reponse.statusCode != 200) {
        throw Exception(json.decode(reponse.body)['error']);
      }

      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
