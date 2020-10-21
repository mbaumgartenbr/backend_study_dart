import 'package:aula_aqueduct/model/read_model.dart';

import 'harness/app.dart';

void main() {
  final harness = Harness()..install();

  setUp(() async {
    final readQuery = Query<Read>(harness.application.channel.context)
      ..values.author = "Matheus Baumgarten"
      ..values.title = "Automated Tests"
      ..values.year = 2021;
    await readQuery.insert();
  });

  test("GET /reads returns a 200 OK", () async {
    final response = await harness.agent.get('/reads');
    expectResponse(
      response,
      200,
      body: everyElement(
        // Partial used to math SOME fields
        partial({
          "id": greaterThan(0),
          "title": isString,
          "author": isString,
          "year": isInteger,
          //"details": isString, // No need because of PARTIAL
        }),
      ),
    );
  });

  test("GET /reads/:id returns a single read", () async {
    final response = await harness.agent.get('/reads/1');
    expectResponse(
      response,
      200,
      body: {
        "id": 1,
        "title": "Automated Tests",
        "author": "Matheus Baumgarten",
        "year": 2021,
        "details": "Automated Tests by Matheus Baumgarten",
      },
    );
  });

  test("GET /reads/2 returns a 404 response", () async {
    final response = await harness.agent.get('/reads/2');
    expectResponse(response, 404, body: "Item not found. id: 2");
  });

  test("POST /reads creates a new read", () async {
    final response = await harness.agent.post("/reads", body: {
      "title": "Code Complete v2",
      "author": "Matheus Baumgarten",
      "year": 2020,
    });
    expectResponse(response, 200, body: {
      "id": 2,
      "title": "Code Complete v2",
      "author": "Matheus Baumgarten",
      "year": 2020,
      "details": "Code Complete v2 by Matheus Baumgarten"
    });
  });

  test("PUT /reads/:id updates a read", () async {
    final response = await harness.agent.put('/reads/1', body: {
      "title": "Automated Tests v2",
      "author": "Matheus Baumgarten",
      "year": 2020,
    });
    expectResponse(response, 200, body: {
      "id": 1,
      "title": "Automated Tests v2",
      "author": "Matheus Baumgarten",
      "year": 2020,
      "details": "Automated Tests v2 by Matheus Baumgarten",
    });
  });

  test("PUT /reads/2 returns a 404 response", () async {
    final response = await harness.agent.put('/reads/2', body: {
      "title": "Automated Tests v2",
      "author": "Matheus Baumgarten",
      "year": 2020,
    });
    expectResponse(response, 404, body: "Item not found. id: 2");
  });

  test("DELETE /reads/:id deletes a read", () async {
    final response = await harness.agent.delete('/reads/1');
    expectResponse(response, 200, body: "Deleted 1 items.");
  });

  test("DELETE /reads/2 returns a 404 response", () async {
    final response = await harness.agent.delete('/reads/2');
    expectResponse(response, 404, body: "Item not found. id: 2");
  });
}
