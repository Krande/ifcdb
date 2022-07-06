Search.setIndex({"docnames": ["ci/unittesting", "index", "inserts/insert_strategies", "queries/by_id", "queries/efficient_query", "queries/large_queries", "queries/nested_object_links", "queries/query_building", "queries/spatial_query", "schema/modifications", "schema/schema_to_esdl", "updating/diffing", "validation/cube-advanced-brep", "validation/validation_intro"], "filenames": ["ci/unittesting.md", "index.md", "inserts/insert_strategies.md", "queries/by_id.md", "queries/efficient_query.md", "queries/large_queries.md", "queries/nested_object_links.md", "queries/query_building.md", "queries/spatial_query.md", "schema/modifications.md", "schema/schema_to_esdl.md", "updating/diffing.md", "validation/cube-advanced-brep.md", "validation/validation_intro.md"], "titles": ["Unittesting EdgeDB schemas", "IFC as a database", "IFC Insert Strategies", "Query by element name(s)/GlobalId(s)", "Efficient Query Strategies", "Large queries", "Nested Object links", "Query Building", "Slicing in the Spatial Hierarchy", "Necessary modifications to the IFC schema", "Converting IFC schema to EdgeDB schema (ESDL)", "Updating elements", "Round-tripping <code class=\"docutils literal notranslate\"><span class=\"pre\">cube-advanced-brep.ifc</span></code>", "Validation Strategy"], "terms": {"back": [0, 3, 5, 7, 8, 11, 12, 13], "main": [0, 3, 5, 6, 7, 8, 11, 12, 13], "page": [0, 3, 5, 7, 8, 11, 12, 13], "A": [0, 5, 6, 13], "github": [0, 1, 8], "action": 0, "workflow": 0, "ci": 0, "yml": 0, "ha": [0, 6, 8, 12], "been": [0, 12, 13], "creat": [0, 6, 7, 8, 10], "test": [0, 2, 6, 8, 12, 13], "differ": [0, 2, 6, 7, 11, 13], "ifc": [0, 3, 5, 7, 8, 11, 13], "s": [0, 1, 6], "relev": [0, 1, 10], "insert": [0, 8, 12], "queri": 0, "base": [0, 1, 3, 6, 10], "specif": [0, 1, 3, 8, 9], "file": [0, 2, 3, 6, 8, 10, 12, 13], "At": [0, 6], "time": [0, 6, 8], "write": [0, 1, 6, 8], "fail": 0, "2": [0, 1, 2, 12], "3": [0, 1, 2, 12], "fingerprint": [0, 13], "assert": [0, 3, 9, 13], "The": [0, 1, 2, 8, 10, 12], "cube": [0, 1], "advanc": [0, 1], "brep": [0, 1], "onli": [0, 6, 8, 9, 10], "current": [0, 2, 13], "pass": 0, "here": [0, 6, 8, 9], "complet": [0, 1, 10], "pytest": 0, "setup": 0, "roundtrip": [0, 12], "import": [0, 3, 6, 10, 13], "pathlib": [0, 10], "shutil": 0, "from": [0, 2, 3, 6, 8, 10], "ifcdb": [0, 3, 6, 10], "edgeio": [0, 3, 6, 10], "edge_model": 0, "query_util": 0, "validate_ifc_object": [0, 13], "mark": 0, "parametr": 0, "ifc_file_nam": 0, "tessel": [0, 10], "item": [0, 2, 6, 8, 10, 13], "spatialhierarchy1": [0, 8], "mybeam": [0, 2, 3, 6], "mybeamwithhol": 0, "def": [0, 3, 6, 13], "test_roundtrip_ifc_files_valid": 0, "ifc_files_dir": 0, "db_name": [0, 3, 6], "replac": [0, 3, 6, 9], "_": [0, 3, 6], "ifc_fil": [0, 3, 6], "db_schema_dir": [0, 3, 6, 10], "path": [0, 6, 10], "temp": [0, 3, 6], "resolv": [0, 6], "absolut": 0, "dbschema": [0, 3, 6, 10], "exist": [0, 2, 8, 9], "rmtree": 0, "databas": [0, 3, 5, 6, 10, 11], "io": [0, 3, 6, 10], "set": [0, 10, 13], "up": [0, 10], "create_schema": [0, 3, 6, 10], "from_ifc_fil": [0, 3, 6, 10], "setup_databas": [0, 3, 6, 10], "delete_existing_migr": [0, 3, 6, 10], "true": [0, 3, 6, 10, 13], "element": [0, 2, 6, 8, 9, 10, 12, 13], "insert_ifc": [0, 3, 6], "valid": 0, "data": [0, 1, 2, 6], "us": [0, 1, 2, 3, 5, 6, 7, 8, 9, 13], "ifcopenshel": [0, 7, 10, 13], "ifc_io": 0, "ifc_obj": 0, "to_ifcopenshell_object": 0, "variou": [1, 6, 13], "experi": [1, 6], "store": [1, 9], "an": [1, 6, 8, 9, 10], "edgedb": [1, 2, 6, 7, 8, 9, 12], "see": [1, 6, 8], "repo": 1, "sourc": [1, 6, 7], "code": [1, 6], "doc": [1, 6], "all": [1, 2, 3, 6, 7, 9, 10], "relat": [1, 2, 3, 6, 7, 10], "i": [1, 9, 13], "am": 1, "thi": [1, 2, 6, 8, 9, 12], "document": [1, 8], "primarili": 1, "organ": 1, "my": 1, "thought": 1, "consequ": [1, 6, 9], "randomli": 1, "most": 1, "part": 1, "appear": 1, "chaotic": 1, "inconsist": 1, "convert": 1, "esdl": [1, 6, 8, 9], "partial": 1, "entir": [1, 5, 6], "entiti": [1, 9], "necessari": [1, 6, 8], "modif": 1, "type": [1, 2, 6, 7, 8, 12, 13], "strategi": 1, "sequenc": 1, "bulk": 1, "parallel": 1, "build": [1, 6], "name": [1, 2, 6, 8, 13], "globalid": [1, 6, 8], "nest": [1, 3, 7], "object": [1, 7, 8, 9, 13], "link": [1, 8, 12], "1": [1, 2, 12, 13], "basic": 1, "select": [1, 2, 5, 12], "get": [1, 3], "properti": [1, 2, 3, 7, 8, 9, 12, 13], "shape": [1, 8], "reduc": [1, 8], "gener": [1, 10, 12], "complex": [1, 8], "slice": 1, "spatial": 1, "hierarchi": 1, "motiv": 1, "goal": 1, "scenario": [1, 6], "associ": [1, 6, 9], "return": [1, 5, 6, 13], "list": [1, 2, 3, 12], "class": [1, 3, 6, 7, 9, 10, 12, 13], "larg": [1, 8], "pagin": 1, "round": [1, 13], "trip": [1, 13], "unittest": [1, 13], "follow": [2, 6, 8, 10, 12], "ar": [2, 6, 7, 8, 9], "plan": 2, "everi": [2, 6], "singl": [2, 6, 8], "thread": 2, "mean": [2, 6, 8, 9], "least": 2, "perform": [2, 8], "ideal": [2, 11], "debug": 2, "statement": [2, 6, 8, 9, 12], "individu": 2, "below": [2, 6, 8], "snippet": 2, "printout": 2, "dure": [2, 10], "84": 2, "ifcperson": [2, 6], "adaus": [2, 6], "identif": [2, 6, 8], "ifcorgan": [2, 6], "assembl": [2, 6], "For": [2, 6, 8, 9], "design": [2, 6], "analysi": [2, 6], "31": 2, "ifcpersonandorgan": [2, 6], "WITH": [2, 12], "ifc_1": 2, "filter": [2, 8], "id": [2, 6, 8], "uuid": 2, "68b74946": 2, "fd00": 2, "11ec": [2, 6, 8], "a5": 2, "b371333a38a3": 2, "ifc_2": 2, "68c1068e": 2, "1b36f1090f9c": 2, "theperson": [2, 6, 8], "theorgan": [2, 6, 8], "Not": 2, "yet": [2, 8], "start": 2, "sequenti": 2, "process": [2, 8], "group": 2, "similar": 2, "togeth": 2, "loop": 2, "dictionari": 2, "other": [2, 6], "unrel": 2, "instanc": [2, 6, 10], "earli": 2, "show": 2, "offer": 2, "substanti": 2, "increas": [2, 8], "possibl": [3, 6, 8, 9, 10], "can": [3, 6, 8], "done": [3, 13], "like": [3, 6], "so": [3, 8, 9, 11, 12, 13], "util": [3, 6], "top_dir": [3, 6], "ifc_path": [3, 6, 10], "f": [3, 6, 12, 13], "ifc_schema": [3, 6, 10], "ifc4x1": [3, 6, 10], "database_exist": 3, "fals": [3, 6, 12, 13], "result_by_nam": 3, "get_by_nam": 3, "top_level_onli": 3, "result_by_id": 3, "get_by_global_id": 3, "3pxsnq_3qhxbd2w2f4zouq": [3, 6], "__name__": [3, 6], "__main__": [3, 6], "By": [3, 8], "limit": [3, 5, 9], "typic": [5, 8], "case": 5, "user": [5, 8], "download": 5, "content": [5, 11, 13], "work": [5, 6, 9], "local": [5, 11], "offset": 5, "each": [5, 8], "block": 5, "result": [5, 6, 8, 12, 13], "manual": 6, "investig": [6, 8], "found": [6, 8, 13], "schema": [6, 7, 8], "exercis": 6, "function": [6, 9], "step": 6, "stone": 6, "toward": 6, "automat": [6, 12], "intent": 6, "builder": 6, "fact": [6, 8], "ani": [6, 8, 9], "root": 6, "ifcbeam": [6, 8], "further": [6, 8], "more": 6, "inform": 6, "about": 6, "first": [6, 8], "upload": 6, "full": 6, "emploi": [6, 7], "both": 6, "subsequ": 6, "json": [6, 8], "refresh_db": 6, "qref": 6, "q1": 6, "q2": 6, "q3": 6, "q1_re": 6, "load": 6, "client": [6, 8], "query_json": 6, "open": 6, "r": 6, "read": [6, 7, 8], "_output": 6, "w": 6, "encod": 6, "utf": 6, "8": [6, 8], "dump": 6, "indent": 6, "4": [6, 8, 12], "top": [6, 8], "level": [6, 8], "written": 6, "point": [6, 9, 12], "nativ": [6, 9], "str": [6, 9, 12, 13], "float64": [6, 9, 12], "int64": [6, 12], "etc": [6, 9], "descript": [6, 8], "objecttyp": [6, 8], "tag": 6, "predefinedtyp": 6, "ownerhistori": [6, 8], "objectplac": [6, 8], "represent": [6, 8], "These": [6, 9], "attribut": 6, "itself": 6, "_e_typ": 6, "__type__": [6, 8], "which": [6, 8, 9, 10], "output": [6, 8], "ipe400": 6, "beam": 6, "null": 6, "ebe57210": 6, "fced": 6, "97f5": 6, "57e3b32f3dcd": 6, "eee839b6": 6, "73fd14217afc": 6, "ee4d8ae2": 6, "7f55f62e5c6b": 6, "default": [6, 8], "lastmodifiedd": [6, 8], "creationd": [6, 8], "owningus": [6, 8], "owningappl": [6, 8], "state": [6, 8], "changeact": [6, 8], "lastmodifyingus": [6, 8], "lastmodifyingappl": [6, 8], "abstract": [6, 8, 12], "superclass": 6, "ifcobjectplac": 6, "therefor": 6, "we": 6, "need": [6, 10], "consid": [6, 8], "subtyp": [6, 8, 9], "kei": [6, 13], "size": [6, 8], "sinc": 6, "know": [6, 8], "ifclocalplac": 6, "skip": 6, "ifclinearplac": 6, "ifcgridplac": 6, "placementrelto": 6, "relativeplac": 6, "ifcproductrepresent": 6, "howev": [6, 8], "ifcmaterialdefinitionrepresent": 6, "uniqu": 6, "its": 6, "parent": [6, 8], "particular": 6, "omit": 6, "1656570506": 6, "e9fde1da": 6, "6f9f1b461637": 6, "ea228a44": 6, "d744ce069446": 6, "readwrit": 6, "ifcownerhistori": 6, "ee386f0": 6, "b3f35fe72359": 6, "eee83704": 6, "dfb5f1ae7674": 6, "ed8f000": 6, "57758b6c7591": 6, "eda27b02": 6, "13a248609d5b": 6, "ifcproductdefinitionshap": 6, "In": [6, 8, 9], "you": [6, 8, 10, 11], "notic": 6, "lot": 6, "wai": 6, "let": 6, "anoth": 6, "ask": 6, "without": 6, "upfront": 6, "what": [6, 8, 11, 13], "exactli": 6, "As": [6, 8], "explicitli": [6, 7], "defin": [6, 7, 8, 10], "final": [6, 8], "piec": 6, "attempt": [6, 8], "origin": [6, 12], "term": 6, "number": [6, 8], "occurr": 6, "should": [6, 8, 11], "kept": 6, "low": 6, "familynam": [6, 8], "givennam": [6, 8], "middlenam": [6, 8], "prefixtitl": [6, 8], "suffixtitl": [6, 8], "role": [6, 8], "ifcactorrol": 6, "userdefinedrol": [6, 8], "address": [6, 8], "ifcaddress": 6, "purpos": [6, 8], "userdefinedpurpos": [6, 8], "ifcappl": 6, "applicationdevelop": [6, 8], "version": [6, 8, 10], "applicationfullnam": [6, 8], "applicationidentifi": [6, 8], "same": 6, "given": 6, "would": 6, "have": [6, 8, 11, 13], "collect": 6, "separ": [6, 8], "ifcaxis2plac": 6, "one": 6, "mani": [6, 8], "It": [6, 8], "known": 6, "how": [6, 8, 10], "ifcaxis2placement3d": 6, "locat": 6, "ifcpoint": 6, "ifccartesianpoint": [6, 12], "coordin": [6, 12], "refdirect": 6, "ifcdirect": 6, "directionratio": 6, "axi": 6, "ifcrepresent": [6, 8], "ifcshaperepresent": 6, "representationidentifi": [6, 8], "representationtyp": [6, 8], "contextofitem": [6, 8], "ifcrepresentationcontext": 6, "contextidentifi": [6, 8], "contexttyp": [6, 8], "ifcgeometricrepresentationcontext": 6, "coordinatespacedimens": 6, "precis": 6, "worldcoordinatesystem": 6, "truenorth": 6, "ifcrepresentationitem": [6, 8], "repres": [6, 10], "100": [6, 8], "includ": [6, 8], "ifcextrudedareasolid": 6, "sweptarea": 6, "ifcprofiledef": 6, "ifcishapeprofiledef": 6, "profiletyp": 6, "profilenam": 6, "posit": 6, "ifcaxis2placement2d": 6, "overallwidth": 6, "overalldepth": 6, "webthick": 6, "flangethick": 6, "filletradiu": 6, "flangeedgeradiu": 6, "flangeslop": 6, "extrudeddirect": 6, "depth": 6, "ifcpolylin": 6, "ada": 6, "xxx": 6, "bodi": 6, "sweptsolid": 6, "model": [6, 8], "1e": 6, "05": 6, "0": [6, 9, 12, 13], "area": 6, "18": 6, "0086": 6, "0135": 6, "5": [6, 12], "curve3d": 6, "observ": [6, 8], "some": [6, 8], "propos": 6, "improv": 6, "effici": [6, 8], "ergonom": 6, "appli": 6, "exclud": 6, "instead": 6, "custom": 6, "export": [6, 8], "move": 6, "out": [6, 8], "own": 6, "order": [6, 8, 9], "world": 6, "potenti": 6, "refer": [6, 8], "option": [6, 9], "do": [6, 9, 10], "initi": 6, "non": 6, "being": 6, "multipl": [6, 8], "duplic": [6, 8], "thing": 6, "especi": 6, "contain": [6, 8], "onc": 7, "introspect": 7, "construct": [7, 8, 10], "requir": [7, 9, 12], "hide": 7, "chain": [7, 8], "hold": 8, "thousand": 8, "geometri": 8, "underneath": 8, "arrang": 8, "layer": 8, "branch": 8, "down": 8, "sublay": 8, "needless": 8, "sai": 8, "abil": 8, "through": [8, 12], "extract": 8, "want": [8, 10], "prevent": 8, "bottleneck": 8, "aim": 8, "find": 8, "sub": 8, "sublevel_1_a": 8, "new": 8, "6": 8, "ifcbuildingstorei": 8, "ifcsit": 8, "ifcproject": 8, "shown": [8, 9], "figur": 8, "taken": 8, "blender": 8, "addon": 8, "blenderbim": 8, "addit": 8, "bm_1_1": 8, "bm_2_1": 8, "bm_1_2": 8, "bm_2_2": 8, "sublevel": 8, "sublevel_1a_2a": 8, "sublevel_1a_2b": 8, "To": [8, 10, 12], "abl": 8, "merg": 8, "correct": 8, "later": 8, "stage": 8, "adaproject": 8, "also": 8, "overal": 8, "where": [8, 9], "respect": [8, 9], "upon": 8, "receiv": 8, "python": [8, 10], "side": 8, "within": 8, "specifi": [8, 10], "describ": [8, 10], "spatial_stru": 8, "ifcrelcontainedinspatialstructur": 8, "relatingstructur": 8, "relatedel": 8, "rel_agg": 8, "ifcrelaggreg": 8, "relatingobject": 8, "relatedobject": 8, "fyi": 8, "shorten": 8, "sake": 8, "readabl": 8, "fb6d6d2a": 8, "f2be": 8, "ac74": 8, "23608326f6e7": 8, "f6980fd0": 8, "abe5fe6aa302": 8, "bm1_1": 8, "f96474a6": 8, "e796fcfa53d3": 8, "bm2_1": 8, "f9835114": 8, "d7a2757c5f6b": 8, "f64d4aea": 8, "4bd25461394f": 8, "f2ef5848": 8, "d764e1155ac1": 8, "eebd84e8": 8, "e7851f987412": 8, "With": 8, "children": 8, "relationship": [8, 9], "quickli": 8, "becom": 8, "veri": 8, "issu": [8, 12], "when": 8, "come": 8, "supertyp": 8, "string": [8, 9], "lastli": 8, "approach": 8, "exampl": 8, "illustr": 8, "just": 8, "longnam": 8, "compositiontyp": 8, "elev": 8, "fe0e2222": 8, "f601": 8, "9720": 8, "ffa48bb2d7b1": 8, "close": 8, "inspect": 8, "abov": 8, "certain": [8, 9], "There": 8, "occur": 8, "153": 8, "wherea": 8, "126": 8, "subclass": 8, "concept": 8, "polymorph": 8, "subtype_paramet": 8, "oper": 8, "thei": 8, "total": 8, "sheer": 8, "suddenli": 8, "impract": 8, "make": 8, "difficult": 8, "note": 8, "solut": 8, "simplifi": 8, "might": 8, "solv": 8, "splat": 8, "support": 8, "ref": 8, "http": 8, "com": 8, "180": 8, "rather": [8, 9], "becam": 8, "allevi": 8, "2nd": 8, "focus": 8, "add": 8, "1st": 8, "thu": 8, "provid": 8, "ad": [8, 13], "bonu": 8, "remov": 8, "few": 9, "were": 9, "made": 9, "wrap": 9, "e": 9, "float": 9, "integ": 9, "ifclabel": 9, "never": 9, "instanti": 9, "take": 9, "arbitrarili": 9, "chosen": 9, "ifcquantityarea": [9, 10], "built": [9, 10], "ifcareameasur": 9, "OF": 9, "ifcphysicalsimplequant": 9, "areavalu": 9, "formula": 9, "wr21": 9, "NOT": 9, "self": 9, "unit": 9, "OR": 9, "unittyp": 9, "ifcunitenum": 9, "areaunit": 9, "wr22": 9, "end_ent": 9, "practic": 9, "real": 9, "end_typ": 9, "255": 9, "declar": 9, "extend": [9, 12], "constraint": [9, 12], "them": 9, "directli": 9, "must": 9, "enforc": 9, "express": 9, "max_len_valu": 9, "section": 10, "choos": 10, "your": [10, 11], "develop": 10, "db": 10, "testdb": 10, "specific_ent": 10, "good": 11, "dif": 11, "mechan": 11, "whatev": 11, "modifi": [11, 12], "send": 11, "check": 11, "wa": [12, 13], "successfulli": 12, "left": 12, "right": 12, "ifcbsplinesurfacewithknot": 12, "36": 12, "48": 12, "49": 12, "50": 12, "51": 12, "52": 12, "53": 12, "54": 12, "55": 12, "unspecifi": 12, "1224": 12, "74487139159": 12, "One": 12, "adapt": 12, "controlpointslist": 12, "ifc_48": 12, "ifc_49": 12, "ifccartesianpointlist_1": 12, "ifccartesianpointiclist": 12, "ifc_50": 12, "561004233964073": 12, "27232909936926": 12, "333333333333333": 12, "ifc_51": 12, "ifccartesianpointlist_2": 12, "ifc_52": 12, "622008467928146": 12, "0446581987385206": 12, "666666666666667": 12, "ifc_53": 12, "ifccartesianpointlist_3": 12, "ifc_54": 12, "683012701892219": 12, "183012701892219": 12, "ifc_55": 12, "ifccartesianpointlist_4": 12, "udegre": 12, "vdegre": 12, "surfaceform": 12, "uclos": 12, "vclose": 12, "selfintersect": 12, "umultipl": 12, "vmultipl": 12, "uknot": 12, "vknot": 12, "knotspec": 12, "And": 12, "definit": 12, "auto": 12, "produc": 12, "multi": 12, "ifcbsplinesurfac": 12, "ifcboundedsurfac": 12, "one_of": 12, "conical_surf": 12, "cylindrical_surf": 12, "generalised_con": 12, "plane_surf": 12, "quadric_surf": 12, "ruled_surf": 12, "spherical_surf": 12, "surf_of_linear_extrus": 12, "surf_of_revolut": 12, "toroidal_surf": 12, "bool": 12, "tupl": [12, 13], "piecewise_bezier_knot": 12, "quasi_uniform_knot": 12, "uniform_knot": 12, "ensur": 13, "compar": 13, "sent": 13, "techniqu": 13, "far": 13, "two": 13, "procedur": 13, "log": 13, "compare_ifcopenshell_objects_element_by_el": 13, "f1": 13, "f2": 13, "sort": 13, "symmetric_differ": 13, "lambda": 13, "x": 13, "len": 13, "re": 13, "valu": 13, "match": 13, "while": 13, "k": 13, "match_ev": 13, "enumer": 13, "continu": 13, "append": 13, "break": 13, "b": 13, "m_a": 13, "m_b": 13, "ifc_class": 13, "other_v": 13, "isinst": 13, "frozenset": 13, "error": 13, "diff": 13, "get_info_prop": 13, "dict": 13, "include_identifi": 13, "recurs": 13, "return_typ": 13, "inst": 13, "get_info": 13}, "objects": {}, "objtypes": {}, "objnames": {}, "titleterms": {"unittest": 0, "edgedb": [0, 5, 10], "schema": [0, 1, 9, 10], "ifc": [1, 2, 6, 9, 10, 12], "databas": 1, "convers": 1, "insert": [1, 2], "element": [1, 3, 11], "queri": [1, 3, 4, 5, 6, 7, 8], "updat": [1, 11], "valid": [1, 13], "ci": 1, "cd": 1, "strategi": [2, 4, 6, 8, 13], "sequenc": 2, "bulk": 2, "parallel": 2, "name": 3, "s": [3, 8], "globalid": 3, "effici": 4, "larg": 5, "pagin": 5, "nest": [6, 8], "object": 6, "link": 6, "1": [6, 8], "basic": 6, "select": [6, 8], "2": [6, 8], "get": [6, 8], "properti": 6, "3": 6, "The": 6, "complet": 6, "shape": 6, "reduc": 6, "gener": 6, "complex": 6, "specif": [6, 10], "modif": [6, 9], "build": [7, 8], "slice": 8, "spatial": 8, "hierarchi": 8, "motiv": 8, "goal": 8, "scenario": 8, "entir": [8, 10], "all": 8, "relev": 8, "data": 8, "associ": 8, "return": 8, "list": 8, "class": 8, "altern": 8, "A": 8, "loop": 8, "over": 8, "b": 8, "relat": 8, "uuid": 8, "befor": 8, "do": 8, "3rd": 8, "necessari": 9, "base": 9, "type": 9, "convert": 10, "esdl": 10, "us": 10, "partial": 10, "entiti": 10, "round": 12, "trip": 12, "cube": 12, "advanc": 12, "brep": 12}, "envversion": {"sphinx.domains.c": 2, "sphinx.domains.changeset": 1, "sphinx.domains.citation": 1, "sphinx.domains.cpp": 6, "sphinx.domains.index": 1, "sphinx.domains.javascript": 2, "sphinx.domains.math": 2, "sphinx.domains.python": 3, "sphinx.domains.rst": 2, "sphinx.domains.std": 2, "sphinx": 56}})