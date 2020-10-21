import 'package:aula_aqueduct/aula_aqueduct.dart';
import 'package:aqueduct_test/aqueduct_test.dart';

export 'package:aula_aqueduct/aula_aqueduct.dart';
export 'package:aqueduct_test/aqueduct_test.dart';
export 'package:test/test.dart';
export 'package:aqueduct/aqueduct.dart';

class Harness extends TestHarness<AulaAqueductChannel>
    with TestHarnessORMMixin {
  @override
  Future onSetUp() async {
    await resetData(); // resets DB before each test begin
  }

  @override
  Future onTearDown() async {}

  @override
  ManagedContext get context => channel.context;
}
