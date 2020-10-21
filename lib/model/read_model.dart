import 'package:aula_aqueduct/aula_aqueduct.dart';

class Read extends ManagedObject<_Read> implements _Read {
  @Serialize()
  String get details => '$title by $author';
}

class _Read {
  @primaryKey
  int id;

  @Column(unique: true)
  String title;

  @Column()
  String author;

  @Column()
  int year;
}
