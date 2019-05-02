:: Cache toutes les lignes de commande qui sont effectuées lors de l'exécution du programme
@echo off

:: Permet l'encodage en UTF8 ATTENTION NE MARCHE QUE SUR WINDOWS 10
chcp 65001

:: Donne un nom au programme
title Script de sauvegarde MongoDB

:: Change la couleur de la console ainsi que du texte
:: YX --> Y = fond ; X = texte
color 1F