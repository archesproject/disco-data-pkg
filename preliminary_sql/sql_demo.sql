INSERT INTO iiif_manifests (id, url)
VALUES
(uuid_generate_v1(), 'http://127.0.0.1/~dwuthrich/manifests/he/29986_004.json');

SET CLIENT_ENCODING TO UTF8;
BEGIN;
INSERT INTO map_layers(maplayerid, name, layerdefinitions, isoverlay, icon, activated, addtomap)
   VALUES (public.uuid_generate_v1mc(), 'Search Results', '[
	{
		"paint": {
			"heatmap-intensity": [
				"interpolate",
				[
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
			"heatmap-weight": [
				"interpolate",
				[
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
			"heatmap-color": [
				"interpolate",
				[
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
				"interpolate",
				[
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
		},
		"type": "heatmap",
		"id": "search-results-heat",
		"source": "search-results-hashes"
	},
	{
		"layout": {
			"icon-image": "marker-15",
			"icon-allow-overlap": true,
			"icon-offset": [
				0,
				-6
			],
			"icon-size": 2
		},
		"source": "search-results-points",
		"filter": [
			"all",
			[
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
		"paint": {},
		"type": "symbol",
		"id": "search-results-points-markers"
	},
	{
		"layout": {
			"icon-image": "marker-15",
			"icon-allow-overlap": true,
			"icon-offset": [
				0,
				-6
			],
			"icon-size": 3
		},
		"source": "search-results-points",
		"filter": [
			"all",
			[
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
		"paint": {},
		"type": "symbol",
		"id": "search-results-points-markers-highlighted"
	},
	{
		"layout": {
			"visibility": "visible"
		},
		"source": "search-results-points",
		"filter": [
			"all",
			[
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
		"paint": {
			"circle-translate": [
				0,
				-25
			],
			"circle-color": "rgba(0,0,0,0)",
			"circle-radius": 16
		},
		"type": "circle",
		"id": "search-results-points-markers-point-highlighted"
	},
	{
		"layout": {
			"visibility": "visible"
		},
		"source": "search-results-points",
		"filter": [
			"all",
			[
				"==",
				"$type",
				"Point"
			]
		],
		"paint": {
			"circle-translate": [
				0,
				-16
			],
			"circle-color": "rgba(0,0,0,0)",
			"circle-radius": 11
		},
		"type": "circle",
		"id": "search-results-points-markers-point"
	}
]', TRUE, 'ion-search', TRUE, TRUE);

INSERT INTO map_layers(maplayerid, name, layerdefinitions, isoverlay, icon, activated, addtomap)
   VALUES (public.uuid_generate_v1mc(), 'Hex', '[
      {
        "layout": {},
        "source": "search-results-hex",
        "filter": [
          "==",
          "id",
          ""
        ],
        "paint": {
          "fill-extrusion-color": "#54278f",
          "fill-extrusion-height": {
            "property": "doc_count",
            "type": "exponential",
            "stops": [
              [
                0,
                0
              ],
              [
                500,
                5000
              ]
            ]
          },
          "fill-extrusion-opacity": 0.85
        },
        "type": "fill-extrusion",
        "id": "search-results-hex-outline-highlighted"
      },
      {
        "layout": {},
        "source": "search-results-hex",
        "filter": [
          "all",
          [
            ">",
            "doc_count",
            0
          ]
        ],
        "paint": {
          "fill-extrusion-color": {
            "property": "doc_count",
            "stops": [
              [
                1,
                "#f2f0f7"
              ],
              [
                5,
                "#cbc9e2"
              ],
              [
                10,
                "#9e9ac8"
              ],
              [
                20,
                "#756bb1"
              ],
              [
                50,
                "#54278f"
              ]
            ]
          },
          "fill-extrusion-height": {
            "property": "doc_count",
            "type": "exponential",
            "stops": [
              [
                0,
                0
              ],
              [
                500,
                10000
              ]
            ]
          },
          "fill-extrusion-opacity": 0.5
        },
        "type": "fill-extrusion",
        "id": "search-results-hex"
      }

   ]', TRUE, 'ion-funnel', TRUE, FALSE);

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
