REM -- JS generation
start /b coffee -b -c numtel_lib.coffee
start /b coffee -b -c numtel_ui.coffee
start /b coffee -b -c numtel_en.coffee
start /b coffee -b -c numtel_fr.coffee
pause

REM -- JS compression
start /b uglifyjs -c -m --comments -o numtel_lib.js numtel_lib.js
start /b uglifyjs -c -m --comments -o numtel_ui.js  numtel_ui.js
start /b uglifyjs -c -m --comments -o numtel_en.js  numtel_en.js
start /b uglifyjs -c -m --comments -o numtel_fr.js  numtel_fr.js
pause

REM -- Single file
copy /b numtel_lib.js+numtel_en.js+numtel_fr.js+numtel_ui.js numtel.js
del numtel_*.js
