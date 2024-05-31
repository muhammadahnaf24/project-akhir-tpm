import 'package:hive/hive.dart';
import 'package:project_akhir_tpm/utils/enkripsi.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  String username;

  @HiveField(1)
  String password;

  @HiveField(2)
  String nama;

  @HiveField(3)
  String email;

  @HiveField(4)
  String nohp;

  UserModel({
    required this.username,
    required this.password,
    required this.nama,
    required this.email,
    required this.nohp,
  });

  UserModel.forLogin({
    required this.username,
    required this.password,
  })  : nama = '',
        email = '',
        nohp = '';
}
