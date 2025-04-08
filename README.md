# Estudio de técnicas de optimización en C

## Reemplazo de multiplicaciones y divisiones enteras por operaciones de desplazamiento

Inicialmente, aplicaremos esta técnica, guiándonos por el esquema de código base:

```{c}
int i, j, a, b=0, m3=8, m5=32;
for (j=0; j<ITER; j++)
    for (i=0; i<N; i++) {
        a = i * m3;
        b += a / m5;
    }
}
```

Se optimizará mediante el siguiente:

```{c}
for (j=0; j<ITER; j++) {
    for (i=0; i<N; i++) {
        b += i >> 2;
    }
    a= (N-1) << 3;
}
```

Posteriormente, se añadirá más información.