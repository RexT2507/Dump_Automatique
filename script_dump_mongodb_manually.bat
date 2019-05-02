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

:: On lance la commande mongodump
echo Démarrage du backup de %mongo_dump%....

Call :bare_chargement

echo.

echo Patientez...

echo.

mongodump --db %saisie% --out "C:\Program Files\MongoDB\Server\4.0\bin\dump\%mongo_dump%"

echo.

:: On écrit sur le terminal
echo Le dossier %mongo_dump% a été créé à %TIME% par %USERNAME%

cd "C:\Program Files\MongoDB\Server\4.0\bin\dump\%mongo_dump%"

:: On écrit dans le fichier log
echo Le dossier %mongo_dump% a été créé à %TIME% par %USERNAME% > log_de_création_%mongo_dump%.txt

echo.

cd ..

echo Compression du fichier en cours....

ping 127.0.0.1 -n 3 > nul

Call :bare_chargement

echo.

"c:\Program Files\7-Zip\7z.exe" a -tzip "%mongo_dump%.zip" "%mongo_dump%""

rmdir "%mongo_dump%" /s /q

echo.

echo Compression effectuées avec succés !

echo.

echo Suppression des dump les plus anciens

echo.

set /p rep= Voulez vous effecuer la suppression (O/N)

if /I "%rep%" EQU "O" (

    echo.

    echo Suppression en cours.....

    ping 127.0.0.1 -n 3 > nul

    Call :bare_chargement

    forfiles -p "C:\Program Files\MongoDB\Server\4.0\bin\dump" -s -m *. -d 7 -c "cmd /c del @path"
)

echo.

echo Appuyez sur Echap pour fermer le script

:: Met en pause le programme
pause > nul

:: Fonction de création de barre de chargement
:bare_chargement

    setlocal enableDelayedExpansion
    for /l %%I in (1,1,50) do (

        cls

        set progres=

        set upprogres=

        set downprogres=

        set /a barre=%%I*2

        for /l %%A in (1,1,%%I) do (

            set upprogres=!upprogres!-

            set progres=!progres!#
            
            set downprogres=!downprogres!-
        )

        echo !upprogres!

        echo !progres! !barre!%

        echo !downprogres!

        ping localhost -n 1>nul
    )

EXIT /B 0