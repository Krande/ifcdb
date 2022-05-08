CREATE MIGRATION m152a2dula2kz5y57frmluvita3xwepfazh3tu2jjuf3tkdxfgr7xa
    ONTO initial
{
  CREATE ABSTRACT TYPE default::IfcRoot {
      CREATE REQUIRED PROPERTY GlobalId -> std::str;
      CREATE PROPERTY Name -> std::str;
  };
  CREATE ABSTRACT TYPE default::IfcTessellatedFaceSet EXTENDING default::IfcRoot {
      CREATE PROPERTY Coordinates -> array<tuple<x: std::float64, y: std::float64, z: std::float64>>;
  };
  CREATE TYPE default::IfcTriangulatedFaceSet EXTENDING default::IfcTessellatedFaceSet {
      CREATE PROPERTY PnIndex -> array<std::int64>;
      CREATE PROPERTY CoordIndex -> array<tuple<x: std::float64, y: std::float64, z: std::float64>>;
      CREATE PROPERTY Normals -> array<tuple<x: std::float64, y: std::float64, z: std::float64>>;
      CREATE PROPERTY Closed -> std::bool;
  };
};
