module default {

    abstract type IfcRoot {
      required property GlobalId -> str {
        constraint exclusive; # all GUIDS must be unique
      }
      property Name -> str;
    }

    type IfcRepresentationContext {
        property ContextIdentifier -> str;
        property ContextType -> str;
    }

    abstract type IfcRepresentation {
        required property ContextOfItems -> IfcRepresentationContext;
        property RepresentationIdentifier -> str;
        property RepresentationType -> str;
        required property Items -> array<IfcRepresentationItem>;
    }

    abstract type IfcRepresentationItem {

    }

    abstract type IfcGeometricRepresentationItem extending IfcRepresentationItem {

    }

    abstract type IfcTessellatedItem extending IfcGeometricRepresentationItem {

    }

    abstract type IfcTessellatedFaceSet extending IfcTessellatedItem {
      link Coordinates -> IfcCartesianPointList3D;
    }

    type IfcCartesianPointList3D {
        property CoordList -> array<tuple<x: float64, y: float64, z: float64>>;
    }

    type IfcTriangulatedFaceSet extending IfcTessellatedFaceSet {
        property CoordIndex -> array<tuple<x: float64, y: float64, z: float64>>;
        property Normals -> array<tuple<x: float64, y: float64, z: float64>>;
        property Closed -> bool;
        property PnIndex -> array<int64>;
    }
}
