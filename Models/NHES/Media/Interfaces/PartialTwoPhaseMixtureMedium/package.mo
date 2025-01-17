within NHES.Media.Interfaces;
partial package PartialTwoPhaseMixtureMedium "Base class for two phase medium of multiple substances"
  extends Modelica.Media.Interfaces.PartialMedium(redeclare replaceable record
             FluidConstants =
        Modelica.Media.Interfaces.Types.TwoPhase.FluidConstants, redeclare
    replaceable record   SaturationProperties = Types.SaturationProperties);
  constant Boolean smoothModel=false
    "True if the (derived) model should not generate state events";
  constant Boolean onePhase=false
    "True if the (derived) model should never be called with two-phase inputs";

  constant FluidConstants[nS] fluidConstants "Constant data for the fluid";

  redeclare replaceable record extends ThermodynamicState
    "Thermodynamic state variables"
    AbsolutePressure p "Absolute pressure of medium";
    Temperature T "Temperature of medium";
    MassFraction[nX] X(start=reference_X)
      "Mass fractions (= (component mass)/total mass  m_i/m)";
    FixedPhase phase(min=0, max=2)
      "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use";
  end ThermodynamicState;

  replaceable function gasConstant
    "Return the gas constant of the mixture (also for liquids)"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "Thermodynamic state";
    output Modelica.Units.SI.SpecificHeatCapacity R_s "Mixture gas constant";
  end gasConstant;

  redeclare replaceable partial model extends BaseProperties
    "Base properties (p, d, T, h, u, R, MM, sat) of two phase medium"
    SaturationProperties sat "Saturation properties at the medium pressure";
  end BaseProperties;

  replaceable partial function setDewState
    "Return the thermodynamic state on the dew line"
    extends Modelica.Icons.Function;
    input SaturationProperties sat "Saturation point";
    input FixedPhase phase(
      min=1,
      max=2) = 1 "Phase: default is one phase";
    output ThermodynamicState state "Complete thermodynamic state info";
  end setDewState;

  replaceable partial function setBubbleState
    "Return the thermodynamic state on the bubble line"
    extends Modelica.Icons.Function;
    input SaturationProperties sat "Saturation point";
    input FixedPhase phase(
      min=1,
      max=2) = 1 "Phase: default is one phase";
    output ThermodynamicState state "Complete thermodynamic state info";
  end setBubbleState;

  redeclare replaceable partial function extends setState_dTX
    "Return thermodynamic state as function of d, T and composition X or Xi"
    input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
  end setState_dTX;

  redeclare replaceable partial function extends setState_phX
    "Return thermodynamic state as function of p, h and composition X or Xi"
    input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
  end setState_phX;

  redeclare replaceable partial function extends setState_psX
    "Return thermodynamic state as function of p, s and composition X or Xi"
    input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
  end setState_psX;

  redeclare replaceable partial function extends setState_pTX
    "Return thermodynamic state as function of p, T and composition X or Xi"
    input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
  end setState_pTX;

  replaceable function setSat_TX
    "Return saturation property record from temperature and mass fraction"
    extends Modelica.Icons.Function;
    input Temperature T "Temperature";
    input MassFraction X[:] "Mass fraction";
    output SaturationProperties sat "Saturation property record";
  algorithm
    sat.Tsat := T;
    sat.Xsat := X;
    sat.psat := saturationPressure(T, X);
  end setSat_TX;

  replaceable function setSat_pX
    "Return saturation property record from pressure and mass fraction"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input MassFraction X[:] "Mass fraction";
    output SaturationProperties sat "Saturation property record";
  algorithm
    sat.psat := p;
    sat.Xsat := X;
    sat.Tsat := saturationTemperature(p, X);
  end setSat_pX;

  replaceable partial function bubbleEnthalpy
    "Return bubble point specific enthalpy"
    extends Modelica.Icons.Function;
    input SaturationProperties sat "Saturation property record";
    output SpecificEnthalpy hl "Boiling curve specific enthalpy";
  end bubbleEnthalpy;

  replaceable partial function dewEnthalpy
    "Return dew point specific enthalpy"
    extends Modelica.Icons.Function;
    input SaturationProperties sat "Saturation property record";
    output SpecificEnthalpy hv "Dew curve specific enthalpy";
  end dewEnthalpy;

  replaceable partial function bubbleEntropy
    "Return bubble point specific entropy"
    extends Modelica.Icons.Function;
    input SaturationProperties sat "Saturation property record";
    output SpecificEntropy sl "Boiling curve specific entropy";
  end bubbleEntropy;

  replaceable partial function dewEntropy
    "Return dew point specific entropy"
    extends Modelica.Icons.Function;
    input SaturationProperties sat "Saturation property record";
    output SpecificEntropy sv "Dew curve specific entropy";
  end dewEntropy;

  replaceable partial function bubbleDensity
    "Return bubble point density"
    extends Modelica.Icons.Function;
    input SaturationProperties sat "Saturation property record";
    output Density dl "Boiling curve density";
  end bubbleDensity;

  replaceable partial function dewDensity
    "Return dew point density"
    extends Modelica.Icons.Function;
    input SaturationProperties sat "Saturation property record";
    output Density dv "Dew curve density";
  end dewDensity;

  replaceable partial function saturationPressure
    "Return saturation pressure"
    extends Modelica.Icons.Function;
    input Temperature T "Temperature";
    input MassFraction X[:] "Mass fractions of mixture";
    output AbsolutePressure p "Saturation pressure";
  end saturationPressure;

  replaceable partial function saturationTemperature
    "Return saturation temperature"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input MassFraction[nX] X "Mass fractions of mixture";
    output Temperature T "Saturation temperature";
  end saturationTemperature;

  replaceable partial function saturationMassFraction
    "Return saturation mass fraction"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input Temperature T "Temperature";
    output MassFraction[nX] X "Mass fractions of mixture";
  end saturationMassFraction;

  replaceable function saturationPressure_sat
    "Return saturation pressure"
    extends Modelica.Icons.Function;
    input SaturationProperties sat "Saturation property record";
    output AbsolutePressure p "Saturation pressure";
  algorithm
    p := sat.psat;
  end saturationPressure_sat;

  replaceable function saturationTemperature_sat
    "Return saturation temperature"
    extends Modelica.Icons.Function;
    input SaturationProperties sat "Saturation property record";
    output Temperature T "Saturation temperature";
  algorithm
    T := sat.Tsat;
  end saturationTemperature_sat;

  replaceable function saturationMassFraction_sat
    "Return saturation mass fraction"
    extends Modelica.Icons.Function;
    input SaturationProperties sat "Saturation property record";
    output MassFraction[nX] X "Saturation mass fraction";
  algorithm
    X := sat.Xsat;
  end saturationMassFraction_sat;

  replaceable partial function saturationTemperature_derp
    "Return derivative of saturation temperature w.r.t. pressure"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    output DerTemperatureByPressure dTp
      "Derivative of saturation temperature w.r.t. pressure";
  end saturationTemperature_derp;

  replaceable function saturationTemperature_derp_sat
    "Return derivative of saturation temperature w.r.t. pressure"
    extends Modelica.Icons.Function;
    input SaturationProperties sat "Saturation property record";
    output DerTemperatureByPressure dTp
      "Derivative of saturation temperature w.r.t. pressure";
  algorithm
    dTp := saturationTemperature_derp(sat.psat);
  end saturationTemperature_derp_sat;

  replaceable partial function surfaceTension
    "Return surface tension sigma in the two phase region"
    extends Modelica.Icons.Function;
    input SaturationProperties sat "Saturation property record";
    output SurfaceTension sigma
      "Surface tension sigma in the two phase region";
  end surfaceTension;

  redeclare replaceable function extends molarMass
    "Return the molar mass of the medium"
  algorithm
    MM := fluidConstants[:].molarMass*state.X[:];
  end molarMass;

  replaceable partial function dBubbleDensity_dPressure
    "Return bubble point density derivative"
    extends Modelica.Icons.Function;
    input SaturationProperties sat "Saturation property record";
    output DerDensityByPressure ddldp "Boiling curve density derivative";
  end dBubbleDensity_dPressure;

  replaceable partial function dDewDensity_dPressure
    "Return dew point density derivative"
    extends Modelica.Icons.Function;
    input SaturationProperties sat "Saturation property record";
    output DerDensityByPressure ddvdp "Saturated steam density derivative";
  end dDewDensity_dPressure;

  replaceable partial function dBubbleEnthalpy_dPressure
    "Return bubble point specific enthalpy derivative"
    extends Modelica.Icons.Function;
    input SaturationProperties sat "Saturation property record";
    output DerEnthalpyByPressure dhldp
      "Boiling curve specific enthalpy derivative";
  end dBubbleEnthalpy_dPressure;

  replaceable partial function dDewEnthalpy_dPressure
    "Return dew point specific enthalpy derivative"
    extends Modelica.Icons.Function;

    input SaturationProperties sat "Saturation property record";
    output DerEnthalpyByPressure dhvdp
      "Saturated steam specific enthalpy derivative";
  end dDewEnthalpy_dPressure;

  redeclare replaceable function specificEnthalpy_pTX
    "Return specific enthalpy from pressure, temperature and mass fraction"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input Temperature T "Temperature";
    input MassFraction X[:] "Mass fractions";
    input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output SpecificEnthalpy h "Specific enthalpy at p, T, X";
  algorithm
    h := specificEnthalpy(setState_pTX(
          p,
          T,
          X,
          phase));
  end specificEnthalpy_pTX;

  redeclare replaceable function temperature_phX
    "Return temperature from p, h, and X or Xi"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "Specific enthalpy";
    input MassFraction X[:] "Mass fractions";
    input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Temperature T "Temperature";
  algorithm
    T := temperature(setState_phX(
          p,
          h,
          X,
          phase));
  end temperature_phX;

  redeclare replaceable function density_phX
    "Return density from p, h, and X or Xi"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "Specific enthalpy";
    input MassFraction X[:] "Mass fractions";
    input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Density d "Density";
  algorithm
    d := density(setState_phX(
          p,
          h,
          X,
          phase));
  end density_phX;

  redeclare replaceable function temperature_psX
    "Return temperature from p, s, and X or Xi"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input MassFraction X[:] "Mass fractions";
    input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Temperature T "Temperature";
  algorithm
    T := temperature(setState_psX(
          p,
          s,
          X,
          phase));
  end temperature_psX;

  redeclare replaceable function density_psX
    "Return density from p, s, and X or Xi"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input MassFraction X[:] "Mass fractions";
    input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Density d "Density";
  algorithm
    d := density(setState_psX(
          p,
          s,
          X,
          phase));
  end density_psX;

  redeclare replaceable function specificEnthalpy_psX
    "Return specific enthalpy from p, s, and X or Xi"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input MassFraction X[:] "Mass fractions";
    input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output SpecificEnthalpy h "Specific enthalpy";
  algorithm
    h := specificEnthalpy(setState_psX(
          p,
          s,
          X,
          phase));
  end specificEnthalpy_psX;

  replaceable function pressure_dTX
    "Return pressure from d, T, and X or Xi"
    extends Modelica.Icons.Function;
    input Density d "Density";
    input Temperature T "Temperature";
    input MassFraction X[:] "Mass fractions";
    input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output AbsolutePressure p "Pressure";
  algorithm
    p := pressure(setState_dTX(
          d,
          T,
          X,
          phase));
  end pressure_dTX;

  replaceable function specificEnthalpy_dTX
    "Return specific enthalpy from d and T"
    extends Modelica.Icons.Function;
    input Density d "Density";
    input Temperature T "Temperature";
    input MassFraction X[:] "Mass fractions";
    input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output SpecificEnthalpy h "Specific enthalpy";
  algorithm
    h := specificEnthalpy(setState_dTX(
          d,
          T,
          X,
          phase));
  end specificEnthalpy_dTX;
//   replaceable function specificEnthalpyOfFormation_298_15_phX
//     "Returns specific enthalpy, dependent on phase and composition"
//     extends Modelica.Icons.Function;
//     input AbsolutePressure p "Pressure";
//     input SpecificEnthalpy h "Specific enthalpy";
//     input MassFraction X[:] "Mass fractions";
//     input FixedPhase phase=0
//       "2 for two-phase, 1 for one-phase, 0 if not known";
//     output SpecificEnthalpy h_f;
//   protected 
//     Integer region = 1;
//   algorithm 
//     h_f :=if (X[1] > 0) then -351160*86.845 elseif (region == 1) then -241
//        else -285;
//   end specificEnthalpyOfFormation_298_15_phX;

  replaceable partial function specificEnthalpyOfFormation_std
    "Returns specific enthalpy of formation at 298.15 K"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "Thermodynamic state record";
    output SpecificEnthalpy h_f "Specific enthalpy of formation";
  end specificEnthalpyOfFormation_std;

  replaceable function vapourQuality "Return vapour quality"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "Thermodynamic state record";
    output MassFraction x "Vapour quality";
protected
    constant SpecificEnthalpy eps=1e-8;
  algorithm
    x := min(max((specificEnthalpy(state) - bubbleEnthalpy(setSat_pX(pressure(
       state), massfraction(state))))/(dewEnthalpy(setSat_pX(pressure(state),
      massfraction(state))) - bubbleEnthalpy(setSat_pX(pressure(state),
      massfraction(state))) + eps), 0), 1);
  end vapourQuality;

  replaceable partial function massfraction
    extends Modelica.Icons.Function;
    input ThermodynamicState state;
    output MassFraction[nX] X;
  end massfraction;
end PartialTwoPhaseMixtureMedium;
