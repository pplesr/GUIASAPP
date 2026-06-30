# Bitácora de Guías — Puesta en marcha (15 minutos)

Tienes 5 archivos en esta carpeta:

- `index.html` — la app
- `manifest.json`, `sw.js`, `icon-192.png`, `icon-512.png` — para que se instale en el celular
- `supabase-setup.sql` — configura tu base de datos y la nube de fotos

Mantén los 5 archivos **juntos en la misma carpeta**.

---

## Paso 1 · Configurar Supabase (una sola vez)

1. Entra a tu proyecto en **supabase.com** → menú izquierdo **SQL Editor** → **New query**.
2. Abre `supabase-setup.sql`, copia **todo** su contenido, pégalo y presiona **Run**.
   Esto crea la tabla `guias`, el bucket privado `respaldos` y las reglas de seguridad.
3. Crea las cuentas de las personas: menú **Authentication** → **Users** → **Add user**.
   - Pon correo y contraseña de cada uno (Rodolfo, Alejandro, PPlesr y los conductores que quieras).
   - **Marca la opción "Auto Confirm User"** para que puedan entrar de inmediato.
   - Repite por cada persona.

> Alternativa: si prefieres que ellos mismos se registren desde la app, ve a
> **Authentication → Providers → Email** y desactiva "Confirm email". Así el botón
> "Crear cuenta" funciona sin pasar por correo.

---

## Paso 2 · Pegar tus claves en la app

1. En Supabase ve a **Project Settings** (engranaje, abajo a la izquierda).
2. Copia dos valores:
   - **Project URL** → en **Settings → API** (algo como `https://xxxxx.supabase.co`).
   - **La clave pública** → en **Settings → API Keys**, copia la **"Publishable key"**
     (empieza con `sb_publishable_`). Si tu proyecto es antiguo y no la muestra, usa la
     **"anon"** de la pestaña *Legacy*. Cualquiera de las dos sirve; es pública y segura.
3. Abre `index.html` con cualquier editor de texto y, al inicio del bloque de código, reemplaza:

   ```
   const SUPABASE_URL = 'PEGA_AQUI_TU_PROJECT_URL';
   const SUPABASE_KEY = 'PEGA_AQUI_TU_PUBLISHABLE_KEY';
   ```

   por tus valores reales. Guarda el archivo.

---

## Paso 3 · Publicar (gratis, sin tiendas de apps)

La forma más simple, sin instalar nada:

1. Entra a **https://app.netlify.com/drop**
2. Arrastra **la carpeta completa** (con los 5 archivos) a la página.
3. Netlify te da una dirección, por ejemplo `https://algo-azar.netlify.app`. Esa es tu app.
   (Puedes cambiarle el nombre en Site settings, y más adelante poner un dominio propio.)

> Importante: `index.html` debe quedar en la raíz del sitio. Si arrastras la carpeta,
> Netlify lo hace solo.

---

## Paso 4 · Instalar en cada celular

Comparte la dirección por WhatsApp a cada conductor y administrador. En el teléfono:

- **Android (Chrome):** abre la dirección → menú ⋮ → **"Agregar a pantalla de inicio"** / "Instalar app".
- **iPhone (Safari):** abre la dirección → botón **Compartir** → **"Agregar a pantalla de inicio"**.

Queda con ícono propio y se abre a pantalla completa, como una app normal.
Cada persona entra con el correo y contraseña que creaste en el Paso 1.

---

## Uso diario

- **Registrar guía:** el conductor digita N° de guía, dónde carga y descarga, elige su nombre
  (se completan solas las patentes) y toma las dos fotos. "Guardar registro" las sube a la nube.
- **Repositorio:** los tres ven todas las guías, buscan, filtran por "Sin asignar / Asignados",
  ven las fotos en grande, asignan el cliente y exportan un CSV.

Todo es compartido y en tiempo casi real: al tocar **↻ Actualizar** (o al abrir el Repositorio)
aparece lo último que subió cualquiera.

---

## Cosas que conviene saber

- **Plan de Supabase:** el gratis sirve para partir, pero **se pausa tras una semana sin uso** y
  trae 1 GB de fotos. Para uso real de la flota conviene el plan **Pro (~USD 25/mes)**: no se
  pausa y sube a 100 GB. Como las fotos se comprimen al guardarse, rinden bastante.
- **Agregar o quitar conductores:** edita la lista `FLOTA` dentro de `index.html` y vuelve a
  publicar (arrastra la carpeta de nuevo a Netlify). Más adelante esto puede pasar a una tabla
  administrable desde la misma app.
- **Seguridad:** solo entra quien tenga cuenta creada por ti. Las fotos están en un bucket
  privado; la app genera enlaces temporales para verlas.

---

## Si algo falla

- "Falta configurar SUPABASE_URL…" → no pegaste las claves del Paso 2.
- "Correo o contraseña incorrectos" → crea/revisa el usuario en Authentication.
- No carga ninguna guía pero no hay error → toca ↻ Actualizar; revisa que corriste el SQL.
- La foto no sube → revisa que el bucket `respaldos` exista (lo crea el SQL del Paso 1).
