import 'dart:convert';
import 'package:app/models/user.dart';
import 'package:http/http.dart' as http;
import '../models/job.dart';
import '../models/auth_token.dart';
import 'firebase_service.dart';
import 'package:diacritic/diacritic.dart';

class JobsService extends FirebaseService {
  JobsService([AuthToken? authToken]) : super(authToken);

  String removeDiacritic(String input) {
    return removeDiacritic(input).toLowerCase();
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

      final userFavoritesUrl =
          Uri.parse('$databaseUrl/userFavorites/$userId.json?auth=$token');
      final userFavoritesReponse = await http.get(userFavoritesUrl);
      final userFavoritesMap = json.decode(userFavoritesReponse.body);

      jobsMap.forEach((jobId, job) {
        final isFavorite = (userFavoritesMap == null)
            ? false
            : (userFavoritesMap[jobId] ?? false);
        jobs.add(
          Job.fromJson({
            'id': jobId,
            ...job,
          }).copyWith(isFavorite: isFavorite),
        );
      });
      return jobs;
    } catch (error) {
      print(error);
      return jobs;
    }
  }

  Future<List<UserData>> fetchUsers() async {
    final List<UserData> users = [];

    try {
      final usersUrl = Uri.parse('$databaseUrl/users.json?auth=$token');

      final response = await http.get(usersUrl);
      final usersMap = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        print(usersMap['error']);
        return users;
      }

      usersMap.forEach((userId, userData) {
        users.add(
          UserData.fromJson({
            'userId': userId,
            ...userData,
          }),
        );
      });
      return users;
    } catch (error) {
      print(error);
      return users;
    }
  }

  Future<List<Job>> fetchJobs1(String? title) async {
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
