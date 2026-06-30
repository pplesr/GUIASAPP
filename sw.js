// Service worker mínimo: hace la app instalable y cachea solo la "carcasa".
// NO intercepta llamadas a Supabase ni a la nube de fotos (siempre van a la red).
const CACHE = 'bitacora-v1';
const SHELL = ['./', './index.html', './manifest.json', './icon-192.png', './icon-512.png'];

self.addEventListener('install', (e) => {
  e.waitUntil(caches.open(CACHE).then((c) => c.addAll(SHELL)));
  self.skipWaiting();
});

self.addEventListener('activate', (e) => {
  e.waitUntil(
    caches.keys().then((keys) => Promise.all(keys.filter((k) => k !== CACHE).map((k) => caches.delete(k))))
  );
  self.clients.claim();
});

self.addEventListener('fetch', (e) => {
  const url = new URL(e.request.url);
  // Solo respondemos desde caché para archivos propios (misma URL). Todo lo demás
  // (Supabase, esm.sh, fotos) pasa directo a la red sin tocarse.
  if (url.origin === location.origin && e.request.method === 'GET') {
    e.respondWith(caches.match(e.request).then((r) => r || fetch(e.request)));
  }
});
