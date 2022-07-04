Search.setIndex({"docnames": ["ci/unittesting", "index", "queries/by_id", "queries/large_queries", "queries/query_building", "queries/spatial_query", "updating/diffing"], "filenames": ["ci/unittesting.md", "index.md", "queries/by_id.md", "queries/large_queries.md", "queries/query_building.md", "queries/spatial_query.md", "updating/diffing.md"], "titles": ["Unittesting EdgeDB schemas", "IFC as a database", "Query by element name(s)/GlobalId(s)", "Large queries", "Query Building", "Spatial Query", "Updating elements"], "terms": {"back": [0, 2, 3, 4, 5, 6], "main": [0, 2, 3, 4, 5, 6], "page": [0, 2, 3, 4, 5, 6], "A": [0, 1, 3], "github": [0, 5], "action": 0, "workflow": 0, "ci": [0, 1], "yml": 0, "ha": [0, 5], "been": 0, "creat": [0, 4, 5], "test": [0, 5], "differ": [0, 1, 4, 6], "ifc": [0, 3, 4, 5, 6], "s": 0, "relev": 0, "insert": [0, 5], "queri": 0, "base": [0, 2], "specif": [0, 2, 5], "file": [0, 5], "current": 0, "fail": 0, "2": 0, "3": 0, "document": [1, 5], "describ": [1, 5], "explor": 1, "build": 1, "variou": 1, "scenario": 1, "ar": [1, 4, 5], "spatial": 1, "larg": [1, 5], "simpl": 1, "globalid": [1, 5], "name": [1, 5], "strategi": 1, "consid": [1, 5], "here": [1, 5], "an": [1, 5], "db": 1, "work": [1, 3], "cover": 1, "thi": [1, 5], "section": 1, "cd": 1, "get": 2, "list": 2, "all": [2, 4], "nest": [2, 4], "relat": [2, 4], "properti": [2, 4, 5], "us": [2, 3, 4, 5], "edgeio": 2, "python": [2, 5], "class": [2, 4], "can": [2, 5], "done": 2, "like": 2, "so": [2, 5, 6], "from": [2, 5], "ifcdb": 2, "import": 2, "databas": [2, 3, 6], "name_of_edgedb_db_inst": 2, "io": 2, "result_nam": 2, "get_by_nam": 2, "name_of_el": 2, "result_id": 2, "get_by_global_id": 2, "globalid_of_el": 2, "typic": [3, 5], "case": 3, "user": [3, 5], "download": 3, "entir": 3, "content": [3, 6], "local": [3, 6], "limit": 3, "offset": 3, "each": [3, 5], "return": 3, "block": 3, "select": 3, "result": [3, 5], "ifcopenshel": 4, "schema": [4, 5], "edgedb": [4, 5], "onc": 4, "introspect": 4, "emploi": 4, "read": [4, 5], "sourc": 4, "construct": [4, 5], "requir": 4, "explicitli": 4, "defin": [4, 5], "hide": 4, "chain": [4, 5], "object": [4, 5], "type": [4, 5], "For": 5, "refer": 5, "esdl": 5, "investig": 5, "model": 5, "contain": 5, "hold": 5, "thousand": 5, "geometri": 5, "element": 5, "underneath": 5, "top": 5, "level": 5, "arrang": 5, "mani": 5, "layer": 5, "branch": 5, "down": 5, "separ": 5, "sublay": 5, "needless": 5, "sai": 5, "have": [5, 6], "abil": 5, "slice": 5, "through": 5, "extract": 5, "onli": 5, "you": [5, 6], "want": 5, "necessari": 5, "order": 5, "prevent": 5, "size": 5, "bottleneck": 5, "The": 5, "below": 5, "In": 5, "aim": 5, "find": 5, "sub": 5, "sublevel_1_a": 5, "new": 5, "purpos": 5, "spatialhierarchy1": 5, "8": 5, "ifcbeam": 5, "6": 5, "ifcbuildingstorei": 5, "ifcsit": 5, "ifcproject": 5, "shown": 5, "figur": 5, "taken": 5, "blender": 5, "addon": 5, "blenderbim": 5, "should": [5, 6], "addit": 5, "4": 5, "bm_1_1": 5, "bm_2_1": 5, "bm_1_2": 5, "bm_2_2": 5, "sublevel": 5, "sublevel_1a_2a": 5, "sublevel_1a_2b": 5, "To": 5, "abl": 5, "merg": 5, "correct": 5, "later": 5, "stage": 5, "parent": 5, "adaproject": 5, "also": 5, "includ": 5, "export": 5, "overal": 5, "first": 5, "where": 5, "respect": 5, "id": 5, "__type__": 5, "upon": 5, "receiv": 5, "client": 5, "side": 5, "within": 5, "specifi": 5, "follow": 5, "perform": 5, "spatial_stru": 5, "ifcrelcontainedinspatialstructur": 5, "relatingstructur": 5, "relatedel": 5, "rel_agg": 5, "ifcrelaggreg": 5, "relatingobject": 5, "relatedobject": 5, "which": 5, "fyi": 5, "json": 5, "shorten": 5, "sake": 5, "readabl": 5, "see": 5, "output": 5, "fb6d6d2a": 5, "f2be": 5, "11ec": 5, "ac74": 5, "23608326f6e7": 5, "f6980fd0": 5, "abe5fe6aa302": 5, "default": 5, "bm1_1": 5, "f96474a6": 5, "e796fcfa53d3": 5, "bm2_1": 5, "f9835114": 5, "d7a2757c5f6b": 5, "f64d4aea": 5, "4bd25461394f": 5, "f2ef5848": 5, "d764e1155ac1": 5, "eebd84e8": 5, "e7851f987412": 5, "With": 5, "children": 5, "relationship": 5, "out": 5, "howev": 5, "quickli": 5, "becom": 5, "veri": 5, "complex": 5, "issu": 5, "when": 5, "come": 5, "link": 5, "abstract": 5, "supertyp": 5, "subtyp": 5, "further": 5, "increas": 5, "string": 5, "lastli": 5, "approach": 5, "duplic": 5, "found": 5, "exampl": 5, "singl": 5, "illustr": 5, "just": 5, "how": 5, "ownerhistori": 5, "owningus": 5, "theperson": 5, "identif": 5, "familynam": 5, "givennam": 5, "middlenam": 5, "prefixtitl": 5, "suffixtitl": 5, "role": 5, "userdefinedrol": 5, "descript": 5, "address": 5, "userdefinedpurpos": 5, "theorgan": 5, "owningappl": 5, "applicationdevelop": 5, "version": 5, "applicationfullnam": 5, "applicationidentifi": 5, "state": 5, "changeact": 5, "lastmodifiedd": 5, "lastmodifyingus": 5, "lastmodifyingappl": 5, "creationd": 5, "objecttyp": 5, "objectplac": 5, "represent": 5, "contextofitem": 5, "contextidentifi": 5, "contexttyp": 5, "representationidentifi": 5, "representationtyp": 5, "item": 5, "longnam": 5, "compositiontyp": 5, "elev": 5, "filter": 5, "fe0e2222": 5, "f601": 5, "9720": 5, "ffa48bb2d7b1": 5, "By": 5, "close": 5, "inspect": 5, "observ": 5, "abov": 5, "certain": 5, "There": 5, "fact": 5, "occur": 5, "ifcrepresent": 5, "multipl": 5, "ifcrepresentationitem": 5, "153": 5, "wherea": 5, "126": 5, "subclass": 5, "possibl": 5, "concept": 5, "polymorph": 5, "subtype_paramet": 5, "oper": 5, "thei": 5, "exist": 5, "total": 5, "number": 5, "100": 5, "sheer": 5, "suddenli": 5, "impract": 5, "make": 5, "difficult": 5, "note": 5, "solut": 5, "simplifi": 5, "might": 5, "solv": 5, "what": [5, 6], "splat": 5, "time": 5, "write": 5, "shape": 5, "yet": 5, "support": 5, "ref": 5, "http": 5, "com": 5, "180": 5, "mean": 5, "know": 5, "rather": 5, "As": 5, "becam": 5, "attempt": 5, "statement": 5, "allevi": 5, "2nd": 5, "focus": 5, "add": 5, "1st": 5, "thu": 5, "reduc": 5, "It": 5, "provid": 5, "ad": 5, "bonu": 5, "some": 5, "process": 5, "remov": 5, "ani": 5, "final": 5, "effici": 5, "ideal": 6, "good": 6, "dif": 6, "mechan": 6, "whatev": 6, "modifi": 6, "your": 6, "send": 6, "check": 6}, "objects": {}, "objtypes": {}, "objnames": {}, "titleterms": {"unittest": 0, "edgedb": [0, 3], "schema": 0, "ifc": 1, "databas": 1, "queri": [1, 2, 3, 4, 5], "updat": [1, 6], "continu": 1, "integr": 1, "element": [2, 6], "name": 2, "s": [2, 5], "globalid": 2, "larg": 3, "pagin": 3, "build": [4, 5], "spatial": 5, "motiv": 5, "goal": 5, "scenario": 5, "strategi": 5, "1": 5, "get": 5, "entir": 5, "hierarchi": 5, "2": 5, "all": 5, "relev": 5, "data": 5, "associ": 5, "return": 5, "list": 5, "class": 5, "altern": 5, "A": 5, "loop": 5, "over": 5, "nest": 5, "select": 5, "b": 5, "relat": 5, "uuid": 5, "befor": 5, "do": 5, "3rd": 5}, "envversion": {"sphinx.domains.c": 2, "sphinx.domains.changeset": 1, "sphinx.domains.citation": 1, "sphinx.domains.cpp": 6, "sphinx.domains.index": 1, "sphinx.domains.javascript": 2, "sphinx.domains.math": 2, "sphinx.domains.python": 3, "sphinx.domains.rst": 2, "sphinx.domains.std": 2, "sphinx": 56}})