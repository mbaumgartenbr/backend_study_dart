import 'aula_aqueduct.dart';

class AulaAqueductChannel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    /// Options is a parameter from Application Channel
    final config = ReadConfig(options.configurationFilePath);
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
      config.database.username,
      config.database.password,
      config.database.host,
      config.database.port,
      config.database.databaseName,
    );

    context = ManagedContext(dataModel, persistentStore);
  }

  @override
  Controller get entryPoint => Router()
    // INFO: Os [] tornam a variável `:id` opcional
    ..route("/reads/[:id]").link(() => ReadsController(context))
    //
    ..route('/').linkFunction((request) async {
      final root = await File('lib/root.html').readAsString();
      return Response.ok(root)..contentType = ContentType.html;
    });
}

class ReadConfig extends Configuration {
  ReadConfig(String path) : super.fromFile(File(path));

  DatabaseConfiguration database;
}
