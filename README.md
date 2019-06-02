<p align="center"><a href="https://scanmeds.arthurdufour.com" target="_blank" rel="noopener noreferrer"><img width="100" src="https://scanmeds.arthurdufour.com/img/logo.4d996dee.png" alt="ScanMeds' Logo"></a></p>

<p align="center">
  <a href="https://www.codacy.com/app/arthur-woosy/ScanMeds?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=Woosy/ScanMeds&amp;utm_campaign=Badge_Grade"><img src="https://api.codacy.com/project/badge/Grade/0930314267f24a319492b79d9d5e3e90"/></a>
  <a href="https://dependabot.com/"><img src="https://api.dependabot.com/badges/status?host=github&amp;repo=Woosy/ScanMeds" alt="Dependabot Status"></a>
  <br>
</p>

<h2 align="center">ScanMeds</h2>

---

## Introduction

ScanMeds est une plateforme visant à faciliter la gestion de la santé pour les particuliers et les professionnels.

Ce projet a été réalisé dans le cadre de la préparation de mon BTS SIO. Il est ainsi totalement fictif, et ne présente que peu de fonctionnalités.
Dans le cadre de ce projet, nous avons développé une API et un proxy avec Node.js, un site avec Vue.js, une application mobile avec Flutter, et nous avous utilisé MongoDB comme SGBD (NoSQL).


## Ecosystème

ScanMeds a été développé avec les frameworks et outils suivants :

| Librairie        | Version | Description                                                                                                                     |
| ---------------- | ------- | ------------------------------------------------------------------------------------------------------------------------------- |
| [Node.js]        | 10.15.3 | Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine.                                                        |
| [Vue.js]         | 2.6.10  | Vue.js is a progressive, incrementally-adoptable JavaScript framework for building UI on the web.                               |
| [Flutter]        | 1.5.4   | Flutter allows you to build beautiful native apps on iOS and Android from a single codebase.                                    |
| [MongoDB]        | 3.6.12  | MongoDB is a document database with the scalability and flexibility that you want with the querying and indexing that you need. |
| [Docker]         | 18.09.6 | Docker is a tool designed to make it easier to create, deploy, and run applications by using containers.                        |
| [docker-compose] | 1.24.0  | Compose is a tool for defining and running multi-container Docker applications.                                                 |

## Installation & utilisation

* Pour installer le site web, commencez par installer Docker Community Edition ainsi que docker-compose, puis clonez le repository. Une fois fais, lancez la commande `docker-compose up -d` pour lancer les serveurs de développement en local, ou bien `docker-compose -f docker-compose.prod.yml up` pour lancer le build de production.
* Pour installer l'application mobile (pour Android), téléchargez le fichier [scanmeds.apk](http://portfolio.arthurdufour.com/ScanMeds.apk) sur votre SmartPhone, puis executez le. 

## License

Ce projet est entièrement libre, et n'est distribué sous aucune license.

[Node.js]: https://github.com/nodejs/node
[Vue.js]: https://github.com/vuejs/vue
[Flutter]: https://github.com/flutter/flutter
[MongoDB]: https://github.com/mongodb/mongo
[Docker]: https://github.com/docker/docker-ce
[docker-compose]: https://github.com/docker/compose
