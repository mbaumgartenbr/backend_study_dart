# Repositório de estudos

## Backend com Dart e Aqueduct

Creditos das aulas: [Fullstack Dart and Flutter Tutorials](https://www.youtube.com/c/CreativeBracket)

---

Para rodar a aplicação, execute: `docker-compose up -d`

Caso ocorra algum erro com o banco de dados: [Aqueduct Documentation](https://aqueduct.io/docs/db/connecting/#creating-a-database)

Hello World: http://localhost/

`GET` Endpoint: http://localhost/reads

`GET`, `PUT`, `DELETE` por **id**: http://localhost/reads/`id`

---
Formato para inserção de dados `POST`:
```json
{
    "title": "Aula Backend",
    "author": "Matheus Baumgarten",
    "year": 2020
}
```