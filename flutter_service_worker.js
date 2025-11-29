'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "b22b96f42fe92a1f0399142159367810",
"assets/AssetManifest.bin.json": "4ead1637fc5f59cb0aa9ef4a7b75b59d",
"assets/AssetManifest.json": "9d6cae6df83d35ce31a81029f7ca0361",
"assets/assets/androidStudio.png": "0de331c2009642f9b76d0713501f9a45",
"assets/assets/ayani_icon.png": "29834bdf262e3488042ae7245eb30d12",
"assets/assets/ayani_transporter.png": "520cbaedade5ddec64669d95e7dba979",
"assets/assets/ayani_vendor.png": "cc6523fb8d6da6b058c7bb33593e6aea",
"assets/assets/degress_icon.png": "465ef989be76a7f7ce62a78d2a323c18",
"assets/assets/eira_connect.png": "71233aaf790f50ed17ef5a187da89e2b",
"assets/assets/eira_icon.png": "f529109287c3b73672f3e564064219c1",
"assets/assets/figma.png": "8db1733849030f9a47c2db468cf6ce82",
"assets/assets/firebase.png": "a9df470f8d350e34d7423e8cf2f94431",
"assets/assets/flutter.png": "8f433c4a76e0bcb9cc50ba8e8b430471",
"assets/assets/garuda_icon.png": "a4eaed932417d50b5172dcf97048be56",
"assets/assets/git.png": "739dc8d963c164185d7695ef425055ae",
"assets/assets/gitHub.png": "f2a675125b59299b87cadac730b28d97",
"assets/assets/hecho_digital.png": "3cea91ed3a2a22a930e92b28ec90110b",
"assets/assets/hecho_merchant.png": "4b5d1ef0e8edb06082dc3b0cea1acf7a",
"assets/assets/IsarDb.png": "43dcdd33cc29feb5b2b586224604e9f0",
"assets/assets/kjh_logo.png": "077538dd617f34ee7a5ba980c9d402a8",
"assets/assets/kotlin.png": "3f3182e761cf45dcd05a2e745f917ce4",
"assets/assets/linkedIn.png": "e51fd88ace724442bc6d8e2abb00c65c",
"assets/assets/nuchurch_icon.png": "60fac7ee764a1e3907d1a93ed7f90c39",
"assets/assets/postman.png": "cc79b3d18ff92f22bf06699218a9bd8e",
"assets/assets/python.png": "9517d5738d3f0a8ea3c60f09767ae856",
"assets/assets/RestAPI.png": "d89811a66885a967da6f822c49da8871",
"assets/assets/screenshots/ayani1.jpg": "19d77944981c537ec0c9f1e1eddab97f",
"assets/assets/screenshots/ayani2.jpg": "b9c8e273b494c4c9ee07ac2414283c33",
"assets/assets/screenshots/ayani3.jpg": "2bf7d409cf6ba7628ccb7dfb58edb235",
"assets/assets/screenshots/ayani4.jpg": "fa55e18ad06ad9a2eadaaf15db87cf8c",
"assets/assets/screenshots/ayani5.jpg": "d5e23926bc0610d124fe42e1d893de72",
"assets/assets/screenshots/ayani6.jpg": "0ba1820ec30dfd2744806cb2b84e0ae1",
"assets/assets/screenshots/ayani_transporter1.jpeg": "d8882dbc67910786ec60bb5c0a46cc76",
"assets/assets/screenshots/ayani_transporter2.jpeg": "418dbab1bc4e735884b8e09f9c895505",
"assets/assets/screenshots/ayani_transporter3.jpeg": "c0b818bb6217ba4a2633ab73401e1d02",
"assets/assets/screenshots/ayani_transporter4.jpeg": "64e36c97841b5821ce0339b5185d1320",
"assets/assets/screenshots/ayani_transporter5.jpeg": "8ac34482cc3c79c978dd45e5d3edc9dc",
"assets/assets/screenshots/ayani_vendor1.jpg": "6d8a6bd7366ad50064e56a79ce17fe3b",
"assets/assets/screenshots/ayani_vendor2.jpg": "d9cea4784c5a0f22ffa958ddb058b886",
"assets/assets/screenshots/ayani_vendor3.jpg": "976653a78fb3ef84d3bf8865255a7889",
"assets/assets/screenshots/ayani_vendor4.jpg": "a2140b7567dd29caf3a4d18dcc1597d8",
"assets/assets/screenshots/ayani_vendor5.jpg": "a1b5a428f241a7c84aa5abb05ee019e5",
"assets/assets/screenshots/ayani_vendor6.jpg": "4185d0aa5f02e41e86e5a069dd201d2c",
"assets/assets/screenshots/degrees2.jpeg": "b89f66ce4724b927b508918936fd4387",
"assets/assets/screenshots/degrees3.jpeg": "8517d2ab18cb97aef96d639b9a2dde34",
"assets/assets/screenshots/degrees4.jpeg": "842608852839225388c5fe0c1374a232",
"assets/assets/screenshots/degrees5.jpeg": "61a688844fe75ee4bf6544d177a155f1",
"assets/assets/screenshots/degrees6.jpeg": "4b37bbe0d04bf4e884ec60f7c07c4abf",
"assets/assets/screenshots/eira_connect1.jpeg": "534bf04f2633532b5aee1913d0a54387",
"assets/assets/screenshots/eira_connect2.jpeg": "900fbf1d57825315286fdce20c80fe63",
"assets/assets/screenshots/eira_connect3.jpeg": "dfb2d61d147414e1c59bce465a2e8f7e",
"assets/assets/screenshots/eira_connect4.jpeg": "027e17e7b25bda59f5578163f64389f6",
"assets/assets/screenshots/eira_connect5.jpeg": "7ddeed9d1d9ef445e939a0631a922761",
"assets/assets/screenshots/eira_connect6.jpeg": "342101edcf9865a2e25b422035aae9dd",
"assets/assets/screenshots/Eira_monitor1.jpeg": "8353fedb5a559cda4b755e1ca90c7ffc",
"assets/assets/screenshots/Eira_monitor2.jpeg": "570f4356cfd863c7666c8aa909c0d293",
"assets/assets/screenshots/Eira_monitor3.jpeg": "2e1961a4b93fad65be250353e501dee1",
"assets/assets/screenshots/Eira_monitor4.jpeg": "36431f8a320bfeaaf3907db832bb6c39",
"assets/assets/screenshots/Eira_monitor5.jpeg": "558417c87a8dc04cbccaa3439bc25a87",
"assets/assets/screenshots/Eira_monitor6.jpeg": "625e6c0bb84b024f2f4bdfe0665065c0",
"assets/assets/screenshots/Eira_monitor7.jpeg": "75b9b1596f525827f464bd9f5cbae657",
"assets/assets/screenshots/hecho1.jpeg": "c5b75240f81f98c30157aa32c563eba6",
"assets/assets/screenshots/hecho2.jpeg": "e96d92f6527c1582e7c7bfcdd181a586",
"assets/assets/screenshots/hecho3.jpeg": "5262526dd7bdc6152da339d2a830890c",
"assets/assets/screenshots/hecho4.jpeg": "42ab0d02462f166bf7a12eac29666d3a",
"assets/assets/screenshots/hecho5.jpeg": "c36a4fd530d5b31f74973224d1e94f69",
"assets/assets/screenshots/hecho_merchant1.jpeg": "f2cbe475e436a93cb9063d4435b40a51",
"assets/assets/screenshots/hecho_merchant2.jpeg": "aff4a2b56957aa3d7e47113c0016f71c",
"assets/assets/screenshots/hecho_merchant3.jpeg": "fd284cbfd303a0798da2577bcb0f9054",
"assets/assets/screenshots/hecho_merchant4.jpeg": "558383711e5882509a1841ac01b03452",
"assets/assets/screenshots/hecho_merchant5.jpeg": "e8490dc37dc4982d2c45f3f66b5f73cb",
"assets/assets/screenshots/nuchurch1.jpeg": "c99e78f3efd0a00e18dbd7c6c282404f",
"assets/assets/screenshots/nuchurch2.jpeg": "72c784d03996e1da11b4fb1f113a3c31",
"assets/assets/screenshots/nuchurch3.jpeg": "5af3ce0c348962c6018ca3193f94ff45",
"assets/assets/screenshots/nuchurch4.jpeg": "5ebffd3d3455def6dce1b31ff6e2553b",
"assets/assets/screenshots/nuchurch5.jpeg": "3d62d4ab6b2c6d599a4f9081750565d2",
"assets/assets/screenshots/vividlipi1.jpeg": "b4759457cb01ca009e9c73985c8ce620",
"assets/assets/screenshots/vividlipi2.jpeg": "b0efd02d5a5ba999545968a510df02e1",
"assets/assets/screenshots/vividlipi4.jpeg": "965b37fbd9871772b240ab0049f1e4ae",
"assets/assets/screenshots/vividlipi5.jpeg": "b3fad51c5a0cd689986311b75432078c",
"assets/assets/screenshots/vividlipi6.jpeg": "460fe2bed7ad5ae4c56fe1c06a61961f",
"assets/assets/vividlipi.png": "e6bc2ef56adc156a132f21cea7e0088e",
"assets/assets/vscode.png": "c2c0a33ea0ca7075b57fe2449ce52fa5",
"assets/assets/xcode.png": "65ccd79686f0d617c791d808d7882370",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "b95cc977e70f984dd7d78ca15f49b888",
"assets/NOTICES": "163b2d7f8498b40bcafe81f3de729565",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "6cfe36b4647fbfa15683e09e7dd366bc",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "ba4a8ae1a65ff3ad81c6818fd47e348b",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.png": "077538dd617f34ee7a5ba980c9d402a8",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "2c581e46c4c058a105cd42309174725b",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "6d2e6eed0b9660df2ab621495478db91",
"/": "6d2e6eed0b9660df2ab621495478db91",
"main.dart.js": "37bb6c0b00e3a9d45ddb0ffd6322de04",
"manifest.json": "07f66434d604ccac1b4d5244f35598aa",
"version.json": "7367c9ca1c69727a8bb09a7d2d21d48c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
