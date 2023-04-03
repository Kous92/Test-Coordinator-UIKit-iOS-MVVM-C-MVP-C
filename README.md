# iOS (Swift 5): Exemple du pattern Coordinator avec UIKit (MVVM et MVP)

Le Coordinator est un design pattern qui a fait beaucoup parler de lui dans le développement **iOS**, il est également assez populaire dans les projets en entreprise. Particularité, il s'utilise avec **UIKit** et principalement avec l'architecture **MVVM**, d'où l'acronyme **MVVM-C**. Ou bien encore avec **MVP**, donnant ainsi l'acronyme **MVP+C**.

Un peu d'histoire
En 2015, d'un constat de nombreuses responsabilités qu'un `ViewController` peut avoir entre la logique métier, la logique visuelle et la logique de navigation, **Soroush KHANLOU** conçoit un design pattern qu'est le `Coordinator` afin de séparer la logique de navigation du `ViewController`.

## Introduction
Avant d'aborder en profondeur le pattern `Coordinator`, il est important d'en connaître sa définition et de savoir l'expliquer de manière simple et concrète, le jour de l'entretien technique (souvent exigeant).

Rappelons d'abord qu'est-ce qu'un design pattern ?

Un design pattern est une solution éprouvée et réutilisable à un problème commun de conception de logiciel. Il s'agit d'un modèle général de conception de code qui peut être adapté et réutilisé dans différents projets pour résoudre des problèmes similaires.

Les design patterns sont souvent utilisés pour résoudre des problèmes de conception courants dans la programmation orientée objet, tels que la création d'objets, la gestion des relations entre les objets, la structuration du code, la gestion des erreurs, ...

Ils permettent de produire un code plus clair, plus maintenable et plus réutilisable, tout en réduisant les erreurs et en améliorant l'efficacité du développement de logiciels.

Exemple: Singleton, Factory, injection de dépendances, délégation, observateur, Decorator, Coordinator, ...

### Qu'est-ce qu'un Coordinator ?

Le Coordinator est un pattern qui organise la logique de flux de navigation entre les différents écrans (ViewController) et qui isole la logique de navigation de l'interface utilisateur.

### Quel est en est l'intérêt ?

Comme on le constate, si on se base sur la logique de l'architecture **MVC (Model View Controller)** d'Apple, c'est dans le `ViewController` qu'on y met toute la logique: création de la vue, navigation vers d'autres écrans et gestion de la logique métier pour actualiser la vue. Mais le problème est que le `ViewController` devient massif à force d'une complexité grandissante si l'écran concerné a de plus en plus de fonctionnalités et donc la possibilité de naviguer vers plusieurs écrans. La lisibilité et la maintenabilité en devient donc plus difficile. De même pour la testabilité vu qu'il y aura trop de couplage avec les différentes logiques que le `ViewController` va directement dépendre, il sera donc très difficile voire impossible de tester la logique avec des tests unitaire.

Des architectures comme **MVVM (Model View ViewModel)** ou **MVP (Model View Presenter)** vont déjà résoudre une grande partie du problème en y isolant la logique métier, mais s'il faut respecter les principes du SOLID et particulièrement le premier étant le principe de responsabilité unique, ça restera insuffisant. 

Le `Coordinator` est donc l'une des possibles options pour gérer le flux de navigation et donc d'isoler la logique de navigation entre les vues. Il y en a d'autres comme le routeur (`Router`), et l'architecture **VIPER** en est un exemple qui implémente cette façon de naviguer.

## Implémentation

Ce pattern présente pas mal de confusions au niveau de son implémentation. En effet, en recherchant sur Google et YouTube, il y a différentes implémentations de celui-ci, certaines sont simples, d'autres complexes à comprendre et à implémenter. Selon moi, ce design pattern donne beaucoup de fil à retordre pour l'apprendre, le comprendre et l'implémenter, étant donc l'un des patterns les plus complexes.

Il y a de bonnes chances que l'implémentation qu'on apprend soit différente de celle appliquée sur un projet dans une entreprise, auquel cas on pourrait être déboussolé au début.