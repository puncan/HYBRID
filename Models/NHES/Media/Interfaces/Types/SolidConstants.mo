within NHES.Media.Interfaces.Types;
record SolidConstants
  extends Modelica.Icons.Record;
  constant String chem;
  constant Density rho;
  constant ThermalConductivity k;
  constant Integer r;
  constant Integer n;
  constant MolarHeatCapacity R_U;
  constant MolarMass MW;
  constant SpecificHeatCapacity R_m;
  constant MolarEnthalpy h_f_298_15;
  constant Real[4,7] a;
  constant Real[4,2] b;
  constant Real[4,2] T_lims(unit="K");
end SolidConstants;
