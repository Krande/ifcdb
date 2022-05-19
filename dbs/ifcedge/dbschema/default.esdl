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
        required link ContextOfItems -> IfcRepresentationContext;
        property RepresentationIdentifier -> str;
        property RepresentationType -> str;
        required multi link Items -> IfcRepresentationItem;
    }

    type IfcCartesianPointList3D {
        property CoordList -> array<tuple<x: float64, y: float64, z: float64>>;
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

    type IfcTriangulatedFaceSet extending IfcTessellatedFaceSet {
        property CoordIndex -> array<tuple<x: int64, y: int64, z: int64>>;
        property Normals -> array<tuple<x: float64, y: float64, z: float64>>;
        property Closed -> bool;
        property PnIndex -> array<int64>;
    }

    type IfcBuildingElementProxy {
        property GlobalId -> str;
        property Name -> str;
    }
}
