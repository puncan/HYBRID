within NHES.Chemistry.CalciumOxide_Water__CalciumHydroxide;
function hydrationRate "Schaube et al 2012"
  input Temperature T "Bed temperature";
  input AbsolutePressure p "Vapor pressure";
  input DimensionlessRatio x_d "Conversion";
  output Real dxdt(unit="1/s");
protected
  Temperature T_eq=equilibrium_temperature(p);
  AbsolutePressure p_eq=if (T > 230) then equilibrium_pressure(T) else 1000;
  DimensionlessRatio x_dc=if x_d < 0 then 0.0 else if x_d > 1 then 1.0
       else x_d;
  DimensionlessRatio x_h=1 - x_dc;
  DimensionlessRatio x_in_log=if (x_h >= 1) then 1 - (1e-6) else if (x_h <=
      0) then 1e-6 else 1 - x_h;
  TemperatureDifference dT=(T_eq - T);
  TemperatureDifference dT_lim=50;
  MolarHeatCapacity R_u=Modelica.Constants.R;
  Real A_lo_dT(unit="1/s") = 1.0004e-34;
  TemperatureDifference E_lo_dT=53.332e3;
  Real A_hi_dT(unit="1/s") = 13945;
  Real E_hi_dT(unit="J/mol") = -89.486e3;
  Real p_ratio=if p/p_eq == 1 then 0.8 else p/p_eq;
algorithm
  dxdt := if (dT >= 0 and dT < dT_lim) then -A_lo_dT*Modelica.Math.exp(
    E_lo_dT/T)*((p/(10^5))^6)*(1 - x_h) else if (dT >= dT_lim) then -
    A_hi_dT*Modelica.Math.exp(E_hi_dT/(R_u*T))*((p_ratio - 1)^0.83)*3*(1 -
    x_h)*((-Modelica.Math.log(x_in_log))^0.666) else 0.0;
  annotation (smoothOrder=2);
end hydrationRate;
