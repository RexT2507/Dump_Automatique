:: cache toutes les lignes de commande qui sont effectuées lors de l'exécution du programme
@echo off

:: donne un nom à son programme
title Script de sauvegarde MongoDB

:: Cache toutes les lignes de commande qui sont effectuées lors de l'exécution du programme
mode con cols=100 lines=20

:: Permet l'encodage en UTF8 ATTENTION NE MARCHE QUE SUR WINDOWS 10
chcp 65001

:: change la couleur de la console ainsi que du texte
:: YX --> Y = fond X = texte
color 1F

@echo Lancement du script....

echo. 

:: PENSEZ A REMPLACER LA CONSTANTE PAR LE NOM DE VOTRE DATABASE
set saisie=votre_nom_de_database

echo.

set DATE=%DATE:~6,4%_%date:~3,2%_%date:~0,2%
set TIME=%TIME:~0,-3%

:: On nomme le dossier de dump
set mongo_dump=%saisie%_%DATE%_%TIME%

:: On remplace les / de DATE par des _
set mongo_dump=%mongo_dump:/=_%
:: On remplace les : de DATE par des _
set mongo_dump=%mongo_dump::=_%