<h1 align="center"> Team: Name 404 </h1>

## Table of Contents 📁

1. [Team Details](https://github.com/Manipal-Hackathon-2022/Team-Name-404/blob/main/README.md#team-details)
2. [Description of project](https://github.com/Manipal-Hackathon-2022/Team-Name-404/blob/main/README.md#description-of-project)
3. [What we have built](https://github.com/Manipal-Hackathon-2022/Team-Name-404/blob/main/README.md#what-we-have-built)
4. [Directory Structure](https://github.com/Manipal-Hackathon-2022/Team-Name-404/blob/main/README.md#directory-structure)
5. [Network Diagram](https://github.com/Manipal-Hackathon-2022/Team-Name-404/blob/main/README.md#network-diagram)

<br/>

## Team Details 👥
- Name: Name 404
- Members
    - Parth Mittal (Leader)
    - Pranav Agarwal
    - Mehul Todi
    - Abhiraj Mengade
    - Shashank SM

<br/>

## Description of Project 📝

#### Problem Statement: LFS02 - Social Cohesion

<br/>

## Idea 💡

#### Huntly

A cross-platform mobile application that brings people closer to the physical environment and forms meaningful connections by organising real-world Treasure Hunts for free and winning rewards. The app uses machine learning to match users and form teams of like-minded people. Users can choose from a wide variety of pre-set, themed clues or even create their own. Clues can be unlocked through QR code scanning or the answers are verified through location tracking. Users are encouraged to click pictures with their teammates and can view their pictures as memory threads.

<br/>

## Tech Stack 🧰

<li>Frameworks</li>

- Flutter
- Django Rest Framework
- Flask

<li>Packages</li>

 - Geolocator
 - QR Code Scanner
 - Swagger

<li>Libraries/Tools</li>

- Google OAuth
- nltk
- sklearn
- Figma
- Git/GitHub

<br/>

## What we have built 👨🏻‍💻

- <b> Software Type </b>: Mobile Application
- <b> Software Platform </b>: Android/iOS Devices

- [Abstract](https://docs.google.com/document/d/1zTqYEtmoJE4iVky5QQzvrvdY5igg5HyBXGmgFEalkw0/edit?usp=sharing)
- [Wireframes](https://www.figma.com/file/34xqq0Ii1HqNhvHG96Xbdw/Huntly?node-id=0%3A1)
- [Prototype](https://www.figma.com/proto/34xqq0Ii1HqNhvHG96Xbdw/Huntly?node-id=9%3A1387&scaling=scale-down&page-id=0%3A1&starting-point-node-id=9%3A1387)
- [Round 1 Presentation](https://www.canva.com/design/DAFNQ-Sl_Tk/5dQygaIQbtfVF_hr6U3QvQ/view)
- [Schema](https://docs.google.com/spreadsheets/d/1BzMs2MS1AXaRoZVw4cRbG1WbLlOfXzyGl_XpG2UcQr0/edit?usp=sharing)

- <b> Features Planned: </b>
    - Authenticaion
    - User Profile Builder
    - Search For Hunts
    - Organise a Hunt
        - Custom
        - Preset
    - Clue Verification
        - Location Based Tracking
        - QR Code Scanning
    - Gameplay
        - K-Means Clustering Model
        - Leaderboard

    - Rewards
    - Memory Threads

## Directory Structure 🗃️

```
Team-Name-404/
├─ app/                           # Frontend
│  ├─ mobile/
│  │  ├─ huntly/
│  │  │  ├─ android/
│  │  │  ├─ lib/
│  │  │  │  ├─ features/          # App widgets
│  │  │  │  │  ├─ authentication/
│  │  │  │  │  ├─ hunts/
│  │  │  │  │  ├─ memories/
│  │  │  │  │  ├─ rewards/
│  │  │  │  ├─ main.dart
│  │  │  ├─ test/
├─ backend/                       # API
│  ├─ huntly_backend/             # Django Rest Framework apps
│  │  ├─ huntly_backend/
│  │  ├─ memories/ 
│  │  ├─ rewards/
│  │  ├─ treasure_hunts/
│  │  ├─ users/
|  ├─ env                         # Environment variables
├─ services/                      # Machine Learning service
│  ├─ ml_api/
├─ .gitignore
├─ LICENSE
├─ README.md

```

## Network Diagram

![Huntly Network Diagram without Redis with grid](https://user-images.githubusercontent.com/76661350/195946928-111cc54f-637b-465c-ac9a-4983b10548a3.png)

