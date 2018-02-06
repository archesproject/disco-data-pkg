INSERT INTO iiif_manifests (id, url)
VALUES
(uuid_generate_v1(), 'http://127.0.0.1/~dwuthrich/manifests/he/29986_004.json');


SET CLIENT_ENCODING TO UTF8;
BEGIN;
INSERT INTO map_layers(maplayerid, name, layerdefinitions, isoverlay, icon, activated, addtomap)
   VALUES (public.uuid_generate_v1mc(), 'Search Results', '[
        {
           "id": "search-results-heat",
           "type": "heatmap",
           "source": "search-results-hashes",
           "paint": {
               "heatmap-weight": [
                   "interpolate", [
                       "linear"
                   ],
                   [
                       "get",
                       "doc_count"
                   ],
                   0,
                   0,
                   6,
                   1
               ],
               "heatmap-intensity": [
                   "interpolate", [
                       "linear"
                   ],
                   [
                       "zoom"
                   ],
                   0,
                   1,
                   25,
                   10
               ],
               "heatmap-color": [
                   "interpolate", [
                       "linear"
                   ],
                   [
                       "heatmap-density"
                   ],
                   0,
                   "rgba(33,102,172,0)",
                   0.2,
                   "rgb(103,169,207)",
                   0.4,
                   "rgb(209,229,240)",
                   0.6,
                   "rgb(253,219,199)",
                   0.8,
                   "rgb(239,138,98)",
                   1,
                   "rgb(178,24,43)"
               ],
               "heatmap-radius": [
                   "interpolate", [
                       "linear"
                   ],
                   [
                       "zoom"
                   ],
                   0,
                   2,
                   25,
                   25
               ],
               "heatmap-opacity": 1
           }
       },
       {
           "id": "search-results-points-markers",
           "type": "symbol",
           "source": "search-results-points",
           "filter": [
               "all", [
                   "==",
                   "$type",
                   "Point"
               ],
               [
                   "!=",
                   "highlight",
                   true
               ]
           ],
           "layout": {
               "icon-image": "marker-15",
               "icon-size": 2,
               "icon-offset": [0, -6],
               "icon-allow-overlap": true
           },
           "paint": {}
       },
       {
           "id": "search-results-points-markers-highlighted",
           "type": "symbol",
           "source": "search-results-points",
           "filter": [
               "all", [
                   "==",
                   "$type",
                   "Point"
               ],
               [
                   "==",
                   "highlight",
                   true
               ]
           ],
           "layout": {
               "icon-image": "marker-15",
               "icon-size": 3,
               "icon-offset": [0, -6],
               "icon-allow-overlap": true
           },
           "paint": {}
       }
   ]', TRUE, 'ion-search', TRUE, TRUE);

CREATE TABLE "lincoln_sites" (gid serial,
"id" numeric(10,0),
"site_name" varchar(25));
ALTER TABLE "lincoln_sites" ADD PRIMARY KEY (gid);
SELECT AddGeometryColumn('','lincoln_sites','geom','4326','MULTIPOLYGON',2);
INSERT INTO "lincoln_sites" ("id","site_name",geom) VALUES ('1','one','0106000020E610000001000000010300000001000000070000000CABAD261150E2BF1CFC8F91E9A24A4065351CF2DC4FE2BF1CFC8F91E9A24A40209958F2E54FE2BFFE19D432E9A24A40916698590650E2BF39BE852EE9A24A40916698590650E2BF39BE852EE9A24A4087EFC2F31B50E2BFC9539559E9A24A400CABAD261150E2BF1CFC8F91E9A24A40');
INSERT INTO "lincoln_sites" ("id","site_name",geom) VALUES ('2','two','0106000020E61000000100000001030000000100000006000000B3702B54374FE2BFAB06E925E9A24A40CBDB72EC044FE2BF1B4F4C1DE9A24A40FE0628ED1F4FE2BFBF43BAA4E8A24A40F012B6BA3C4FE2BF3B3618D4E8A24A40F012B6BA3C4FE2BF3B3618D4E8A24A40B3702B54374FE2BFAB06E925E9A24A40');
INSERT INTO "lincoln_sites" ("id","site_name",geom) VALUES ('3','three','0106000020E610000001000000010300000001000000070000001622838CFB4FE2BF97BDA5DEE7A24A4061B87F25E44FE2BF413981C0E7A24A4065351CF2DC4FE2BF98BFFE72E7A24A40916698590650E2BF36AB1366E7A24A4087EFC2F31B50E2BF5E442391E7A24A40CB8B86F31250E2BF413981C0E7A24A401622838CFB4FE2BF97BDA5DEE7A24A40');
COMMIT;
ANALYZE "lincoln_sites";
