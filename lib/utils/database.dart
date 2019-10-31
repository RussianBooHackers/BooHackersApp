import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import 'config.dart';

/// Database
/// Used to storage data on device.
/// TODO: Расписать, как работать с базой данных
/// {@category Utils}
class DataBase {
  static Database db;
  open() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    var codec = getEncryptSembastCodec(
        password: 'm1y2S3u4p5e6r7G8o9o0d1P2a3s4s5w6o7r8d');
    String dbPath =
        context.join(documentsDirectory.path, Config.dbName + ".db");
    db = await databaseFactoryIo.openDatabase(dbPath, codec: codec);
  }

  static Future loadFromDB() async {
    var store = StoreRef<String, dynamic>.main();
  }

  static Future saveToDB() async {
    var store = StoreRef<String, dynamic>.main();
  }
}

class _EncryptEncoder extends Converter<Map<String, dynamic>, String> {
  final Salsa20 salsa20;

  _EncryptEncoder(this.salsa20);

  @override
  String convert(Map<String, dynamic> input) {
    String encoded = Encrypter(salsa20)
        .encrypt(json.encode(input), iv: IV.fromLength(8))
        .base64;
    return encoded;
  }
}

class _EncryptDecoder extends Converter<String, Map<String, dynamic>> {
  final Salsa20 salsa20;

  _EncryptDecoder(this.salsa20);

  @override
  Map<String, dynamic> convert(String input) {
    var decoded =
        json.decode(Encrypter(salsa20).decrypt64(input, iv: IV.fromLength(8)));
    if (decoded is Map) {
      return decoded.cast<String, dynamic>();
    }
    throw FormatException('invalid input $input');
  }
}

class _EncryptCodec extends Codec<Map<String, dynamic>, String> {
  _EncryptEncoder _encoder;
  _EncryptDecoder _decoder;

  _EncryptCodec(List<int> passwordBytes) {
    var salsa20 = Salsa20(Key(Uint8List.fromList(passwordBytes)));
    _encoder = _EncryptEncoder(salsa20);
    _decoder = _EncryptDecoder(salsa20);
  }

  @override
  Converter<String, Map<String, dynamic>> get decoder => _decoder;

  @override
  Converter<Map<String, dynamic>, String> get encoder => _encoder;
}

const _encryptCodecSignature = 'encrypt';

SembastCodec getEncryptSembastCodec({@required String password}) =>
    SembastCodec(
        signature: _encryptCodecSignature,
        codec: _EncryptCodec(sha256.convert(utf8.encode(password)).bytes));
