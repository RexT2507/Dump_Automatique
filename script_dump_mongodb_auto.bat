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

:: On lance la commande mongodump
echo Démarrage du backup de %mongo_dump%....

Call :bare_chargement

echo.

echo Patientez...

echo.

mongodump --db %saisie% --out "C:\Program Files\MongoDB\Server\4.0\bin\dump\%mongo_dump%"

echo.

:: on écrit sur le terminal
echo Le dossier %mongo_dump% à été crée à %TIME% par %USERNAME%

cd "C:\Program Files\MongoDB\Server\4.0\bin\dump\%mongo_dump%"

:: on écrit dans le fichier log
echo Le dossier %mongo_dump% à été crée à %TIME% par %USERNAME% > log_de_creation_%mongo_dump%.txt

echo.

cd ..

echo Compression du fichier en cours....

ping 127.0.0.1 -n 3 > nul

Call :bare_chargement

echo.

"C:\Program Files\7-Zip\7z.exe" a -tzip "%mongo_dump%.zip" "%mongo_dump%""

rmdir "%mongo_dump%" /s /q

echo.

echo Compression effectuées avec succes !

echo.

echo Suppression des dump les plus anciens

echo.

set rep=O

if /I "%rep%" EQU "O" (

    echo.

    echo Suppression en cours.....

    ping 127.0.0.1 -n 3 > nul

    Call :bare_chargement

    forfiles -p "C:\Program Files\MongoDB\Server\4.0\bin\dump" -s -m *. -d 7 -c "cmd /c del @path"
)

echo.