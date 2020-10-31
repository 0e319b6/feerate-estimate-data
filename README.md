Bitcoin estimatesmartfee/mempool recorder
====
- The JSON data file is not complete/well-formed. You need to replace the trailing comma with a closing square bracket.
- The "histogram" field does not contain a valid JSON string. But it's still very easy to parse.
- The "height" field was added after data collection began. Not all objects have this field.
