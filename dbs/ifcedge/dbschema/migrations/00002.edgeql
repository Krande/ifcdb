CREATE MIGRATION m1ut7bm4wfrzjcwkuozu6v2nfm7gmnnju2hz426ddcsqplhtio7f5q
    ONTO m152a2dula2kz5y57frmluvita3xwepfazh3tu2jjuf3tkdxfgr7xa
{
  ALTER TYPE default::IfcRoot {
      ALTER PROPERTY GlobalId {
          CREATE CONSTRAINT std::exclusive;
      };
  };
};
