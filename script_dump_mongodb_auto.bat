@echo off

title Script de sauvegarde MongoDB

chcp 65001

color 1F

set /p saisie=Entrez le nom de la base de données :

set "DATE=%DATE:~6,4%%date:~3,2%%date:~0,2%"
set "TIME=%TIME:~0,-3%"

set "mongo_dump=%saisie%%DATE%%TIME%"
set "mongo_dump=%mongo_dump:/=%"
set "mongo_dump=%mongo_dump::=%"

echo Lancement du script....

echo.

echo Démarrage du backup de %mongo_dump%....

setlocal enableDelayedExpansion
for /l %%I in (1,1,50) do (
cls
set "progres=!progres!#"
echo !progres!
timeout /t 1 /nobreak >nul
)

echo.

echo Patientez...

echo.

mongodump --db %saisie% --out "C:\Program Files\MongoDB\Server\4.0\bin\dump%mongo_dump%"

echo.

echo Le dossier %mongo_dump% a été créé à %TIME% par %USERNAME%

echo.

echo Compression du fichier en cours....

timeout /t 3 /nobreak >nul

"C:\Program Files\7-Zip\7z.exe" a -tzip "%mongo_dump%.zip" "C:\Program Files\MongoDB\Server\4.0\bin\dump%mongo_dump%"

rmdir "C:\Program Files\MongoDB\Server\4.0\bin\dump%mongo_dump%" /s /q

echo.

echo Compression effectuée avec succès !

echo.

echo Suppression des dumps les plus anciens

echo.

set /p rep=Supprimer les dumps qui datent de plus de 7 jours ? (O/N) :

if /I "%rep%" EQU "O" (
echo.
echo Suppression en cours.....
timeout /t 3 /nobreak >nul
del "C:\Program Files\MongoDB\Server\4.0\bin\dump*.zip" /q
forfiles /p "C:\Program Files\MongoDB\Server\4.0\bin\dump" /s /m *.txt /d -7 /c "cmd /c del @path"
)

echo.

pause

EXIT /B 0