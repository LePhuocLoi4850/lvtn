import 'dart:convert';
import '/models/user.dart';
import 'package:http/http.dart' as http;
import '../models/auth_token.dart';
import 'firebase_service.dart';
import 'package:diacritic/diacritic.dart';

class UsersService extends FirebaseService {
  UsersService([AuthToken? authToken]) : super(authToken);

  String removeDiacritic(String input) {
    return removeDiacritics(input).toLowerCase();
  }

  Future<UserData?> fetchUser(String userId) async {
    try {
      final url = Uri.parse('$databaseUrl/users/$userId.json?auth=$token');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final userDataMap = json.decode(response.body) as Map<String, dynamic>;
        final userData = UserData.fromJson({
          'userId': userId,
          ...userDataMap,
        });
        return userData;
      } else {
        throw Exception('Failed to fetch user data');
      }
    } catch (error) {
      print('Error fetching user data: $error');
      return null;
    }
  }

  Future<List<UserData>> searchTitle(String? name) async {
    final List<UserData> users = [];

    try {
      final usersUrl = Uri.parse('$databaseUrl/users.json?auth=$token');

      final reponse = await http.get(usersUrl);
      final usersMap = json.decode(reponse.body) as Map<String, dynamic>;

      if (reponse.statusCode != 200) {
        return users;
      }

      usersMap.forEach((userId, user) {
        String title1 = (user['name'] as String?) ?? "";

        String normalizedTitle = removeDiacritic(title1.toLowerCase());

        String normalizedSearchString = removeDiacritic(name!.toLowerCase());

        if (normalizedTitle.contains(normalizedSearchString)) {
          users.add(UserData.fromJson({
            'userId': userId,
            ...user,
          }));
        }
      });
      return users;
    } catch (error) {
      print(error);
      return users;
    }
  }

  Future<List<UserData>> searchAddress(String? diachi) async {
    final List<UserData> users = [];

    try {
      final usersUrl = Uri.parse('$databaseUrl/users.json?auth=$token');

      final reponse = await http.get(usersUrl);
      final usersMap = json.decode(reponse.body) as Map<String, dynamic>;

      if (reponse.statusCode != 200) {
        return users;
      }

      usersMap.forEach((userId, user) {
        String address = (user['diachi'] as String?) ?? "";

        String normalizedTitle = removeDiacritic(address.toLowerCase());

        String normalizedSearchString = removeDiacritic(diachi!.toLowerCase());

        if (normalizedTitle.contains(normalizedSearchString)) {
          users.add(
            UserData.fromJson({
              'userId': userId,
              ...user,
            }),
          );
        }
      });
      return users;
    } catch (error) {
      print(error);
      return users;
    }
  }

  Future<List<UserData>> searchCareer(String? career) async {
    final List<UserData> users = [];

    try {
      final usersUrl = Uri.parse('$databaseUrl/users.json?auth=$token');

      final reponse = await http.get(usersUrl);
      final usersMap = json.decode(reponse.body) as Map<String, dynamic>;

      if (reponse.statusCode != 200) {
        return users;
      }

      usersMap.forEach((userId, user) {
        String careers = (user['career'] as String?) ?? "";
        String normalizedTitle = removeDiacritic(careers.toLowerCase());
        String normalizedSearchString = removeDiacritic(career!.toLowerCase());

        if (normalizedTitle.contains(normalizedSearchString)) {
          users.add(
            UserData.fromJson({
              'userId': userId,
              ...user,
            }),
          );
        }
      });
      return users;
    } catch (error) {
      print(error);
      return users;
    }
  }

  Future<List<UserData>> fetchUsers() async {
    final List<UserData> users = [];

    try {
      final usersUrl = Uri.parse('$databaseUrl/users.json?auth=$token');

      final reponse = await http.get(usersUrl);
      final usersMap = json.decode(reponse.body) as Map<String, dynamic>;

      if (reponse.statusCode != 200) {
        print(usersMap['error']);
        return users;
      }

      usersMap.forEach((userId, user) {
        users.add(UserData.fromJson({
          'userId': userId,
          ...user,
        }));
      });
      return users;
    } catch (error) {
      print(error);
      return users;
    }
  }

  // Future<List<UserData>> fetchUsers() async {
  //   final List<UserData> users = [];

  //   try {
  //     final usersUrl = Uri.parse('$databaseUrl/users.json?auth=$token');

  //     final reponse = await http.get(usersUrl);
  //     final usersMap = json.decode(reponse.body) as Map<String, dynamic>;

  //     if (reponse.statusCode != 200) {
  //       print(usersMap['error']);
  //       return users;
  //     }

  //     usersMap.forEach((userId, user) {
  //       if (user['level'] == 'user') {
  //         users.add(
  //           UserData.fromJson({
  //             'userId': userId,
  //             ...user,
  //           }),
  //         );
  //       }
  //     });
  //     return users;
  //   } catch (error) {
  //     print(error);
  //     return users;
  //   }
  // }

  Future<List<UserData>> fetchCompany() async {
    final List<UserData> users = [];

    try {
      final usersUrl = Uri.parse('$databaseUrl/users.json?auth=$token');

      final reponse = await http.get(usersUrl);
      final usersMap = json.decode(reponse.body) as Map<String, dynamic>;

      if (reponse.statusCode != 200) {
        print(usersMap['error']);
        return users;
      }

      usersMap.forEach((userId, user) {
        if (user['level'] == 'company') {
          users.add(
            UserData.fromJson({
              'userId': userId,
              ...user,
            }),
          );
        }
      });
      return users;
    } catch (error) {
      print(error);
      return users;
    }
  }

  Future<bool> updateUser(UserData user) async {
    try {
      final url =
          Uri.parse('$databaseUrl/users/${user.userId}.json?auth=$token');
      final reponse = await http.patch(
        url,
        body: json.encode(user.toJson()),
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

  Future<bool> deleteUser(String id) async {
    try {
      final url = Uri.parse('$databaseUrl/users/$id.json?auth=$token');
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
}
