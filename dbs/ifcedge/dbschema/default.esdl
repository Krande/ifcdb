module default {
    abstract type IfcRoot {
      required property GlobalId -> str {
        constraint exclusive; # all GUIDS must be unique
      }
      property Name -> str;
    }

    abstract type IfcTessellatedFaceSet extending IfcRoot {
      property Coordinates -> array<tuple<x: float64, y: float64, z: float64>>;
    }

    type IfcTriangulatedFaceSet extending IfcTessellatedFaceSet {
        property CoordIndex -> array<tuple<x: float64, y: float64, z: float64>>;
        property Normals -> array<tuple<x: float64, y: float64, z: float64>>;
        property Closed -> bool;
        property PnIndex -> array<int64>;
    }
}