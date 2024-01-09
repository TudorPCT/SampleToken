# SampleToken

Sursa data in fisierul: SampleToken.sol (adaptare dupa un exemplu din "Blockchain by Example" - B. Badr, R. Horrocks, X. Wu), include doua contracte: un exemplu simplificat de token ERC-20 - SampleToken si un contract folosit pentru vanzarea acestui token - SampleTokenSale. Proprietarul tokenului va instantia mai intai contractul token cu o suma totala disponibila pentru token ce este asociata balantei proprietarului, dupa care va instantia contractul de vanzare, pentru a vinde tokenul respectiv prin intermediul acestuia.
In forma curenta contractul de vanzare nu are acces initial la fonduri. Pentru a vinde tokenul, proprietarul trebuie sa transfere periodic din fondurile proprii de token catre balanta contractului de vanzare folosind metoda transfer. Contractul de vanzare foloseste de asemenea metoda transfer in cadrul vanzarii.

Se cer urmatoarele: 

Completarea si corectarea functionalitatii curente a contractelor. In particular:

Corectarea situatiilor unde pattern-ul Checks-Effects-Interaction nu este respectat in metodele contractelor.
Completarea cu functionalitatile obligatorii lipsa ce corespund unui contract ERC-20, conform specificatiilor standard, pentru contractul SampleToken.
Modificarea implementarii astfel incat contractul de vanzare sa foloseasca metoda transferFrom pentru vanzare, in urma unei aprobari a proprietarului token-ului ce permite contractului de vanzare sa efectueze vanzarea direct din balanta proprietarului.
Asigurarea posibilitatii pentru proprietarul tokenului de a putea modifica pretul de vanzare fixat la instantierea contractului SampleTokenSale.
Relaxarea implementarii astfel incat cumparatorii sa nu fie obligati sa plateasca suma exacta pentru achizitionarea de tokens, ci sa poata plati mai mult si sa le fie returnat restul.

Integrarea utilizarii tokenului in contractul ProductIdentification din prima tema.

Tokenul va fi utilizat in locul monedei de baza Ethereum la plata pentru inregistrarea unui producator.

Integrarea utilizarii tokenului si a contractului ProductIdentification din prima tema cu contractul MyAuction ce este parte a exemplului de DAPP pentru licitatii auto din laboratorul 6, si completarea acestuia dupa cum urmeaza:

Instantierea unui contract MyAuction va verifica daca tipul de masina (brand) figureaza ca produs inregistrat in contractul ProductIdentification, esuand in caz contrar.
Tokenul va fi utilizat in locul monedei de baza Ethereum in situatiile in care sunt necesare transferuri (bid, withdraw, etc.).
Un aplicant la licitatie nu va putea licita decat o singura data (nu isi va putea suprascrie suma licitata).
Se va adauga o finalitate pentru licitatii: proprietarul contractului va putea retrage suma castigatoare a licitatiei, iar sumele celorlalti aplicanti vor fi returnate la distrugerea contractului daca acestia nu le-au retras pana in acel moment.

Bonus: Se acorda pana la maxim 5 puncte bonus pentru imbunatatirea interfetei exemplului de DAPP din laboratorul 6. Aceasta ar trebui sa includa de exemplu suport pentru pornirea si accesarea a mai multe licitatii simultane, o pagina/sectiune dedicata achizitionarii de tokens si de verificare a balantei proprii, si evident acoperirea functionalitatilor pentru toate operatiile dintr-un contract de licitatie in interfata web (inclusiv retragerea sumelor licitate) precum si imbogatirea acesteia cu un design mai atractiv.