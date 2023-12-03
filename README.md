# Formalizzazione di dati sensibili in un file JSON
Descrizione formale di dati sensibili in un Label Propety Graph utilizzando il formato file `JSON`.
La motivazione per cui utilizzo un file di questa estensione è che questo tipo di file è molto utilizzato per scambiare informazioni tra computer ed è noto per la facilità di lettura da parte dell'essere umano.

Sopra la sintassi di un file json, definisco in insieme di regole per descrivere i dati sensibili in un istanza di dati.

## Sintassi per esprimere un dato sensibili
Ogni file json rappresenta tutti i dati sensibili per una particolare istanza di dati.
In questi primi esempi suppongo che solo una particolare prorprietà, etichetta o arco possa rappresentare un informazione sensibile in un LPG.

Ogni dato sensibile è aspresso come valore di un nome `sensitive-data`.
In questi primi esempi il valore di `sensitive-data` è un solo oggetto ma in casi più complicati il valore di `sensitive-data` sarà un array di oggetti.

Analizzo ora i vari casi dove ho un solo dato sensibile per ogni istanza dei dati e descrivo i valori per i nomi utilizzati.

### Proprietà
Data l'istanza dei dati rappresentata in figura e il dato sensibile espresso in rosso.

![Proprietà senssibile associata ad un nodo](./img/1.png)

```json
{
    "sensitive-data": {
        "element": "property",
        "description": {
            "linked-to": {
                "label": "User",
                "object": "node"
            },
            "key": "password",
            "value": "12345"
        }
    }
}
```

Il nome `element` ha come possibili valori le stringhe *property*, *label* e *relationship* e descrive a quale elemento di un LPG è considerato un dato sensibile.

Il valore del nome `description` è un oggetto che fornisce una descrizione dell'elemento in modo tale da identificarlo univocamente.
La struttura di tale oggetto cambia a seconda del tipo di elemento ovvero proprietà, etichetta, ecc.

Dal momento che la proprietà può essere associata ad un nodo oppure ad un arco, lo scopo del valore del nome `linked-to` è quello di distinguere i due casi.
L'oggetto di questo nome è formato da altre due coppie nome, valore.
Il valore del nome `object` può essere *node* o *relationship*, mentre il valore del nome `label` specifica l'etichetta dell'elemento a cui la proprietà è associata.

Se la proprietà è associata ad un nodo oppure ad un arco cambia la struttura dell'oggetto relationship.

![Proprietà sensibile associata ad un arco](./img/3.png)

Se la proprietà è associata ad un arco all'interno del valore di `description` sono presenti i nomi `start` e `end` che con i loro oggetti descrivono il nodo di partenza e il nodo di arrivo del arco.

```json
{
    "sensitive-data": {
        "element": "property",
        "description": {
            "linked-to": {
                "label": "FRIEND_OF",
                "object": "relationship",
                "start": {
                    "label": "Person",
                    "object": "node"
                },
                "end": {
                    "label": "Person",
                    "object": "node"
                }
            },
            "list": false,
            "key": "interest",
            "value": "romantic"
        }
    }
}
```

Infine le coppie `key`, `value` rappresentano la chiave e il valore della proprietà sensibile.
Inoltre il valore del nome `list` specifica se il valore della proprità è una lista di valori o meno. 

### Etichette

![Etichetta sensibile associata ad un nodo](./img/7.png)

```json
{
    "sensitive-data": {
        "element": "label",
        "description": {
            "label": "Eterosexual",
            "linked-to": {
                "labels": [
                    "Eterosexual",
                    "Person"
                ],
                "object": "node",
                "multiple-labels": true
            }
        }
    }
}
```

Come già accennato per le proprietà lo scopo di molte coppie nome-valore rimane lo stesso.
Dal momento che il valore di `element` è *label* la struttura del valore del nome `description` cambia.
Il valore `label` rappresenta l'etichetta sensibile associata al nodo o ad un arco.

Dal momento che è possibile avere un etichetta associata ad un nodo oppure ad un arco è necessario distinguere i due casi all'interno dal valore del nome `linked-to`.

Se l'etichetta è associata ad un nodo, come nell'esempio precedente, allora il valore del nome `object` è *node*.
Poiché ad un nodo è possibile avere associato più di un etichetta il valore del nome `multiple-labels` specifica se al nodo, a cui l'etichetta è associato, ha più di un etichetta.
Per identificare correttamente il nodo, a cui l'etichetta è associata, il nome `labels` contiene tutte le etichette del nodo ed è presente solo se è fissato a *true* il valore di `multiple-labels` 

Invece se l'etichetta è associata ad in arco il valore del nome `object` è *relationship*.
In questo caso è necessario specificare nei valori dei nomi `start` e `end` la descrizione dei nodi di partenza e arrivo dell'arco a cui l'etichetta è associata.
Inoltre è possibile omettere il nome `multiple-labels` perché ad un arco può essere associata una sola etichetta.

![Etichetta sensibile associata ad un arco](./img/8.png)

```json
{
    "sensitive-data": {
        "element": "label",
        "description": {
            "label": "HAVE_AFFAIR",
            "object": "relationship",
            "start": {
                "label": "Person",
                "object": "node"
            },
            "end": {
                "label": "Person",
                "object": "node"
            }
        }
    }
}
```

### Archi

![Arco sensibile](./img/9.png)

```json
{
    "sensitive-data": {
        "element": "relationship",
        "description": {
            "label": "WORSHIP",
            "start": {
                "label": "Person",
                "object": "node"
            },
            "end": {
                "label": "Religion",
                "object": "node"
            }
        }
    }
}
```

La sintassi per esprimere un arco sensibile è simile a quella utilizzata per rappresentare un etichetta associata ad un arco con alcune differenze.

Il valore del nome `element` è *relationship*.
In questo caso è l'arco in sé rappresenta un dato sensibile ma per identificarlo è bene specificare l'etichetta associata al arco sensibile utilizzando il valore del nome `label`.

## Sintassi per esprimere una combinazione di dati sensibili
Decido di formalizzare una combinazione di dati sensibili come un array di singoli sensibili utilizzando le regole descritte precedentemente.
Ho scelto questo approccio perché tutti questi dati sensibili sono presenti nella stessa istanza dei dati.

![Combinazione di due proprietà sensibili](./img/12.png)

```json
{
    "sensitive-data": [
        {
            "element": "property",
            "description": {
                "linked-to": {
                    "label": "Person",
                    "object": "node"
                },
                "list": false,
                "key": "code",
                "value": "RNDGRL"
            }
        },
        {
            "element": "property",
            "description": {
                "linked-to": {
                    "label": "Person",
                    "object": "node"
                },
                "list": false,
                "key": "politics",
                "value": "left-party"
            }
        }
    ]
}
```

![Etichetta e arco sensibile in un istanza di dati](./img/14.png)

```json
{
    "sensitive-data": [
        {
            "element": "label",
            "description": {
                "label": "Repuplican",
                "linked-to": {
                    "multiple-labels": true,
                    "object": "node"
                }
            }
        },
        {
            "element": "relationship",
            "description": {
                "start": {
                    "label": [
                        "Person",
                        "Repuplican"
                    ],
                    "object": "node"
                },
                "end": {
                    "label": "Party",
                    "object": "node"
                }
            }
        }
    ]
}
```