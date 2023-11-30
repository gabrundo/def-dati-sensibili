#! /bin/bash

echo -e "--- \ntitle: Formalizzazione di dati sensibili  \nauthor: Gabriele Rundo \ndate: 30 novembre \ngeometry: left=3cm,right=3cm,top=2cm,bottom=2cm, a4paper\n---" > intro.md

pandoc intro.md README.md -o README.pdf
