---
title: "📑 Dossier De Projet - 1/4 - Développer des composants d'interface"
pubDatetime: 2024-11-12
draft: false
tags: ["Symfony", "apiplatform", "docker"]
slug: "dossier-de-projet"
description: "Mon dossier de projet professionnel : 1/4 Développer des composants d'interface "
featured: false
---

Dans ce post, je vous présente mon dossier de projet professionnel.

## Contexte

Comme je l'évoquais dans le billet précédent, j'ai obtenu mon Titre Professionnel de Développeur Concepteur d'application (Bachelor, niveau 6, bac +3). À l'occasion de ce titre, j'ai présenté mon dossier de projet devant le jury. C'est un bel élément pour faire une démonstration de mes compétences, j'en profite donc pour vous faire aussi cette démonstration. Le document en question est disponible ici : [dossier de projet professionnel](http://dev.seb7.fr/dossier_de_projet.pdf).

Pour réaliser ce projet, j'ai traité l'ensemble des compétences du référentiel de certification [référentiel officiel](https://www.francecompetences.fr/recherche/rncp/6255/).  
Pour ne pas vous livrer un pavé à lire, je vais découper cette présentation en plusieurs posts.  
Ce billet couvre le bloc _Développer des composants d'interface_, décliné en trois parties.

## Développer des composants d'interface

### Maquetter une application

C'est une compétence que j'ai rarement eu l'occasion de développer au cours de ma carrière, j’ai appris énormément dans ce domaine à l'occasion du développement de mon projet professionnel. J'ai utilisé Figma, un outil de référence en matière de prototypage, wire framing, et maquettage. J'ai concrétisé spécifications du cahier des charges, d'abord avec les wireframes. J’ai adopté une approche de design thinking qui m’a permis d'identifier les lacunes du cahier des charges initial et de concevoir des maquettes complètes et ergonomiques.

Grâce à ma formation en ergonomie cognitive, j’ai conservé une sensibilité particulière à l’UX, que j’intègre dans toutes mes analyses et réalisations. Cette expérience m’a également offert un recul critique sur les présentations de design auxquelles j'ai assisté par le passé en entreprise. Je me souviens de cas où les interactions (navigation, changements d'état) n'étaient pas présentées, sans que je remarque cette lacune. Ce manquement a posé des problèmes en phase d'intégration, car il restait trop d'incertitude pour l'intégrateur.

Finalement, au-delà de m'être initié à la création, d'avoir utilisé une approche itérative fructueuse, je sais que je saurai aujourd'hui mieux repérer les manquements et anticiper les enjeux d’intégration dès la phase de conception.

### Développer une interface utilisateur

Le projet est un système applicatif avec une api d'un côté et des clients de l'autre. Pour développer le client web, comme pour le reste du projet, j'ai défini un cadre technique général qui spécifie que les technologies utilisées doivent être largement éprouvées et couramment utilisées. Me spécialisant en Symfony, j'ai basé le client sur Symfony, Twig et le composant [Asset Mapper](https://symfony.com/doc/current/frontend/asset_mapper.html) qui permet d'intégrer du JavaScript (et du css) de façon moderne. Concrètement ce dernier composant permet de versionner les assets (js, css, images), de les mettre à jour en production avec une gestion des caches (et des problèmes liés), d'auditer la sécurité des packages JavaScript et de faire des requêtes http optimisées (preload, import de modules). C'est de cette manière que j'ai intégré [Bootstrap](https://getbootstrap.com/) dans le projet.
Je n'ai pas poussé plus loin l'utilisation de technologies front-end, car c'était largement suffisant pour l'application, au besoin, je me tournerai vers l'intégration des technologies plus évoluées en me référant au [projet UX de Symfony](https://ux.symfony.com/). D'un autre côté, j'ai commencé à me former à [ReactJs](https://react.dev/) pour l'avenir.

### Développer des composants d'accès aux données

Pour l'accès et l'affichage des données, il y a deux choses notables dans le projet : l'utilisation de DTO et des contrôleurs minimalistes.

L'utilisation de [DTO (Data Transfert Object)](https://code-garage.fr/blog/a-quoi-servent-les-data-transfer-objects-dto/) qui permet un emploi simple et sécurisé des données dans Twig, l'hydratation de l'objet est réalisée par le [Serializer Symfony]() (c'est pourquoi le DTO n'est pas en `readonly`). On a alors des objets clairs :

```php
<?php

declare(strict_types=1);

namespace App\Entity;

use DateTime;

class MedicalOpinion
{
    public function __construct(
        public ?int $id = null,
        public string $title = '',
        public string $description = '',
        public ?Doctor $doctor = null,
        public ?Patient $patient = null,
        public ?DateTime $dateTime = null,
    ) {
    }
}

```

Coté contrôleur, la logique est minimale, j'ai codé un service (isolé, testable, conforme aux bonnes pratiques) qui se charge de récupérer et envoyer les données à l'API. On a un code limpide :

```php
<?php

declare(strict_types=1);

namespace App\Controller;

use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class SecretaryHomeController extends AbstractController
{
    #[Route('/secretary/', name: 'app_secretary_home')]
    public function index(): Response
    {
        return $this->render('secretary/home.html.twig', [
            'entries' => $this->apiService->getEntriesToday(),
            'exits' => $this->apiService->getExitsToday(),
        ]);
    }

    #[Route('/secretary/checkin/{hospitalStayId}', name: 'app_hospital_stay_checkin')]
    public function checkinEntry(int $hospitalStayId): RedirectResponse
    {
        $this->apiService->checkinEntry($hospitalStayId);
        $this->addFlash('success', 'Entrée enregistrée.');

        return $this->redirectToRoute('app_secretary_home');
    }

    #[Route('/secretary/checkout/{hospitalStayId}', name: 'app_hospital_stay_checkout')]
    public function checkoutEntry(int $hospitalStayId): RedirectResponse
    {
        $this->apiService->checkoutEntry($hospitalStayId);
        $this->addFlash('success', 'Sortie enregistrée.');

        return $this->redirectToRoute('app_secretary_home');
    }
}

```

On a ici le contrôleur pour la page d'accueil d'un utilisateur avec le role de secrétaire et on a en quelques lignes les 3 actions, lister les entrées et sorties, faire une entrée de patient, faire une sortie de patient.
Notez qu'il n'y a pas de gestion des exceptions à ce niveau, c'est gérer à un niveau plus basique de Symfony via les `HttpException` et l'affichage est propre pour les utilisateurs  
Notez aussi que le service est injecté dans l'`Abstract Controller`

```php
<?php

declare(strict_types=1);

namespace App\Controller;

use App\Service\SoigneMoiApiService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController as NativeAbstractControllerAlias;

class AbstractController extends NativeAbstractControllerAlias
{
    public function __construct(
        protected readonly SoigneMoiApiService $apiService)
    {
    }
}

```

### Développer des pages web en lien avec une base de données

Pour cette compétence, se matérialise par le développement d'un service dédié à l'envoi et à la récupération des données que j'ai entièrement implémentées et testées qui joue ce rôle. Je ne rentre pas plus dans les détails, si vous êtes intéressé, [le code se trouve sur GitHub](https://github.com/SebSept/soignemoi-webcli/blob/main/src/Service/SoigneMoiApiService.php) et [les tests également](https://github.com/SebSept/soignemoi-webcli/tree/main/tests/Service).

Je dois tout de même évoquer le côté sécurité. Celle-ci repose, elle repose sur plusieurs choses.
Principes et bonnes pratiques + twig + composant asset mapper + sécurité + docker

À la surface, je me repose sur Twig, la sérialisation Symfony, le typage fort, phpstan au niveau maximal, la fonctionnalité d'audit du composant Asset Mapper et le composant Security de Symfony dont je n'ai pas parlé

Finalement pour ce développement front-end, j'ai fait le code le plus propre possible.  
Avec une séparation claire des rôles, du code simple à réutiliser tant au niveau des templates qu'au niveau des contrôleurs ;  
Avec le développement d'un client testable qui offre des méthodes explicites et une gestion d'erreur expressive.

Dans les prochains billets, je vous présente les deux autres blocs de compétences.
