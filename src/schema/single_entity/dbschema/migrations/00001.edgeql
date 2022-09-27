CREATE MIGRATION m1jpq5maguwykullbrzpevmh575o5xaqhd3s7dsrcsftzj36fg62za
    ONTO initial
{
  CREATE TYPE default::IfcAbsorbedDoseMeasure {
      CREATE REQUIRED PROPERTY IfcAbsorbedDoseMeasure -> std::float64;
  };
};
