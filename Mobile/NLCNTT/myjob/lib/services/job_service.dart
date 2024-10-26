import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/auth_token.dart';
import '../models/job.dart';

import 'firebase_service.dart';

class JobService extends FirebaseService {
  JobService([AuthToken? authToken]) : super(authToken);

  Future<List<Job>> fetchJob([bool filterByUser = false]) async {
    final List<Job> jobs = [];

    try {
      // ignore: unused_local_variable
      final filters =
          filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
      final jobsUrl = Uri.parse('$databaseUrl/jobs.json?auth=$token&filters');
      final response = await http.get(jobsUrl);
      final jobsMap = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        print(jobsMap['error']);
        return jobs;
      }

      final userFavoriteUrl =
          Uri.parse('$databaseUrl/userFavorites/$userId.json?auth=$token');
      final userFavoritesResponse = await http.get(userFavoriteUrl);
      final userFavoritesMap = json.decode(userFavoritesResponse.body);

      jobsMap.forEach((JobId, Job) {
        final isFavorited = (userFavoritesMap == null)
            ? false
            : (userFavoritesMap[JobId] ?? false);

        jobs.add(
          Job.fromJson({
            'id': JobId,
            ...Job,
          }).copyWith(isFavorite: isFavorited),
        );
      });
      return jobs;
    } catch (error) {
      print(error);
      return jobs;
    }
  }

  Future<Job?> addJob(Job Job) async {
    try {
      final url = Uri.parse('$databaseUrl/jobs.json?auth=$token');
      // ignore: unused_local_variable
      final response = await http.post(
        url,
        body: json.encode(
          Job.toJson()
            ..addAll({
              'creatorId': userId,
            }),
        ),
      );
    } catch (error) {
      print(error);
      return null;
    }
    return null;
  }

  Future<bool> updateJob(Job Job) async {
    try {
      final url = Uri.parse('$databaseUrl/jobs/${Job.id}.json?auth=$token');
      final response = await http.patch(
        url,
        body: json.encode(Job.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
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
      final response = await http.delete(url);

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
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
      final response = await http.put(
        url,
        body: json.encode(
          job.isFavorite,
        ),
      );

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
