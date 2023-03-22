@echo off
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

:: Demande à l'utilisateur de saisir le nom de la base de données à sauvegarder
set /p db_name=Entrez le nom de la base de données à sauvegarder : 

echo.

:: On nomme le dossier de dump
set "date_time=%DATE:~6,4%-%date:~3,2%-%date:~0,2%_%TIME:~0,-3%"
set "dump_folder=%db_name%_%date_time%"
set "dump_folder=%dump_folder:/=_%"
set "dump_folder=%dump_folder::=_%"

:: On lance la commande mongodump
echo Démarrage du backup de %dump_folder%....

Call :bare_chargement

echo.

echo Patientez...

echo.

:: PENSEZ A MODIFIER LE CHEMIN VERS LE BIN DE VOTRE DOSSIER MONGO
mongodump --db "%db_name%" --out "C:\Program Files\MongoDB\Server\4.0\bin\dump\%dump_folder%"

if not errorlevel 0 (
    echo Erreur lors de la sauvegarde de la base de données %db_name%.
    echo Vérifiez que la base de données existe et que vous avez les permissions nécessaires pour effectuer la sauvegarde.
    goto :error
)

echo.

:: On écrit sur le terminal
echo Le dossier %dump_folder% a été créé à %TIME% par %USERNAME%

:: PENSEZ A MODIFIER LE CHEMIN VERS LE BIN DE VOTRE DOSSIER MONGO
cd "C:\Program Files\MongoDB\Server\4.0\bin\dump\%dump_folder%"

:: On écrit dans le fichier log
echo Le dossier %dump_folder% a été créé à %TIME% par %USERNAME% > log_de_création_%dump_folder%.txt

echo.

cd ..

echo Compression du fichier en cours....

ping 127.0.0.1 -n 3 > n