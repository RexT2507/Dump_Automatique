:: Cache toutes les lignes de commande qui sont effectuées lors de l'exécution du programme
@echo off

:: Permet l'encodage en UTF8 ATTENTION NE MARCHE QUE SUR WINDOWS 10
chcp 65001

:: Donne un nom au programme
title Script de sauvegarde MongoDB

:: Change la taille de la console
mode con cols=100 lines=20

:: Change la couleur de la console ainsi que du texte
:: YX --> Y = fond ; X = texte
color 1F

@echo Lancement du script....

echo.

:: On saisie le nom de la database qu'on veut dump
set /p saisie= Saisissez le nom de votre database Mongo

echo.

:: On nomme le dossier de dump
set mongo_dump=%saisie%_%DATE%

:: On remplace les / de DATE par des _
set mongo_dump=%mongo_dump:/=_%



