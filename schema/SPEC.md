# Schema Spec
The schema file is a json hash

``` javascript
{
  "spec_version": 1, // required, is an integer
  "season": "season_name", // required, is a string

  "match_autonomous": { // required, is a hash
    "scored": [ // required, is an array of hashes
      {
        "CATEGORY_OR_TYPE": {
          "SUB_CATEGORY_OR_SUBTYPE": {
            "points": 10, // required, is a integer
            "description": "Completed Thingy", // required, is a string
            "requires": { // optional hash, only allows scoring this thing if requires is meant
              "type": "scored", // required, if requires is specified. is a string
              "subtype": "glyph", //required, if requires is specified. is a string
              "location": "", // required, if requires is specified. is a string
              "count": 3 // required? , if requires is specified. is a integer
            },
            "max_scorable": 4 // optional, max number of times this thing can be scored
          }
        }
      }
    ],
    "missed": [ // required, is an array of hashes
      {
        "NAME": { // required, is a string. can be named whatever you want, preferrably written in snake case
          "points": 0, // required, is an integer
          "description": "Robot Failed to Balance on Stone", // required, is a string
          "precludes": { // optional hash, allows you to specify that if this is 'scored' then disable the ability score the precluded thing
            "type": "scored", // required, if precludes is specified. is a string
            "subtype": "balance", // required, if precludes is specified. is a string
            "location": "", // required, if precludes is specified. is a string
            "count": 1 // required?, if precludes is specified. is a integer
          }
        }
      }
    ]
  },
  "match_teleop": { // required, is a hash
    "scored": [ // required, is an array of hashes

    ],
    "missed": [ // required, is an array of hashes

    ]
  },

  "scouting_autonomous": [ // required, is an array of hashes
    {
      "type": "number", // required, is a string. value can be: number, boolean, or string
      "name": "max_scorable_object", // required, is a string
      "default": 0 // optional, is a string, integer, or array depending on type
    },
    {
      "type": "string",
      "name": "autonomous_notes"
    }
  ],
  "scouting_teleop": [ // required
    {
      "type": "boolean",
      "name": "can_score_object"
    }
  ]
}
```