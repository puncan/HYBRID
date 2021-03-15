within NHES.Fluid.ClosureModels.PressureLoss.Pipes.Detailed.Internal;
function m_flow_of_dp_fric
  "Calculate mass flow rate as a function of pressure drop"
  extends Modelica.Icons.Function;

  //input records
  input
    NHES.Fluid.ClosureModels.PressureLoss.Pipes.Detailed.dp_IN_con
    IN_con "Input record for function dp_overall_MFLOW"
    annotation (Dialog(group="Constant inputs"));
  input
    NHES.Fluid.ClosureModels.PressureLoss.Pipes.Detailed.dp_IN_var
    IN_var "Input record for function dp_overall_MFLOW"
    annotation (Dialog(group="Variable inputs"));

  input SI.Pressure dp_fric
    "Pressure loss due to friction (dp = port_a.p - port_b.p)";
  input SI.ReynoldsNumber Re1 "Boundary between laminar regime and transition";
  input SI.ReynoldsNumber Re2
    "Boundary between transition and turbulent regime";
  input Real Delta "Relative IN_con.roughness";

  //output variables
  output SI.MassFlowRate m_flow;
  output Real dm_flow_ddp_fric "Derivative of mass flow rate with dp_fric";

protected
  function interpolateInRegion2_withDerivative
    "Interpolation in log-log space using a cubic Hermite polynomial, where x=log10(lambda2), y=log10(Re)"

    input Real lambda2 "Known independent variable";
    input SI.ReynoldsNumber Re1
      "Boundary between laminar regime and transition";
    input SI.ReynoldsNumber Re2
      "Boundary between transition and turbulent regime";
    input Real Delta "Relative IN_con.roughness";
    input SI.Pressure dp_fric
      "Pressure loss due to friction (dp = port_a.p - port_b.p)";
    output SI.ReynoldsNumber Re "Unknown return variable";
    output Real dRe_ddp "Derivative of return value";
    // point lg(lambda2(Re1)) with derivative at lg(Re1)
  protected
    Real x1=Modelica.Math.log10(
                  64*Re1);
    Real y1=Modelica.Math.log10(
                  Re1);
    Real y1d=1;

    // Point lg(lambda2(Re2)) with derivative at lg(Re2)
    Real aux2=Delta/3.7 + 5.74/Re2^0.9;
    Real aux3=Modelica.Math.log10(
                    aux2);
    Real L2=0.25*(Re2/aux3)^2;
    Real aux4=2.51/sqrt(L2) + 0.27*Delta;
    Real aux5=-2*sqrt(L2)*Modelica.Math.log10(
                                aux4);
    Real x2=Modelica.Math.log10(
                  L2);
    Real y2=Modelica.Math.log10(
                  aux5);
    Real y2d=0.5 + (2.51/log(10))/(aux5*aux4);

    // Point of interest in transformed space
    Real x=Modelica.Math.log10(
                 lambda2);
    Real y;
    Real dy_dx "Derivative in transformed space";
  algorithm
    // Interpolation
    (y,dy_dx) := Modelica.Fluid.Utilities.cubicHermite_withDerivative(
        x,
        x1,
        x2,
        y1,
        y2,
        y1d,
        y2d);

    // Return value
    Re := 10^y;

    // Derivative of return value
    dRe_ddp := Re/abs(dp_fric)*dy_dx;
    annotation (smoothOrder=1);
  end interpolateInRegion2_withDerivative;

  Real diameter = 0.5*(IN_con.diameter_a+IN_con.diameter_b) "Average diameter";
  Real crossArea = 0.5*(IN_con.crossArea_a+IN_con.crossArea_b)
    "Average cross area";
  SI.DynamicViscosity mu "Upstream viscosity";
  SI.Density rho "Upstream density";
  Real lambda2 "Modified friction coefficient (= lambda*Re^2)";
  SI.ReynoldsNumber Re "Reynolds number";
  Real dRe_ddp "dRe/ddp";
  Real aux1;
  Real aux2;

algorithm
  // Determine upstream density and upstream viscosity
  if dp_fric >= 0 then
    rho := IN_var.rho_a;
    mu  := IN_var.mu_a;
  else
    rho := IN_var.rho_b;
    mu  := IN_var.mu_b;
  end if;

  // Positive mass flow rate
  lambda2 := abs(dp_fric)*2*diameter^3*rho/(IN_con.length*mu*mu)
    "Known as lambda2=f(dp)";

  aux1:=(2*diameter^3*rho)/(IN_con.length*mu^2);

  // Determine Re and dRe/ddp under the assumption of laminar flow
  Re := lambda2/64 "Hagen-Poiseuille";
  dRe_ddp := aux1/64 "Hagen-Poiseuille";

  // Modify Re, if turbulent flow
  if Re > Re1 then
    Re := -2*sqrt(lambda2)*Modelica.Math.log10(2.51/sqrt(lambda2) + 0.27*Delta)
      "Colebrook-White";
    aux2 := sqrt(aux1*abs(dp_fric));
    dRe_ddp := 1/log(10)*(-2*log(2.51/aux2+0.27*Delta)*aux1/(2*aux2)+2*2.51/(2*abs(dp_fric)*(2.51/aux2+0.27*Delta)));
    if Re < Re2 then
      (Re, dRe_ddp) := interpolateInRegion2_withDerivative(lambda2, Re1, Re2, Delta, dp_fric);
    end if;
  end if;

  // Determine mass flow rate
  m_flow := crossArea/diameter*mu*(if dp_fric >= 0 then Re else -Re);
  // Determine derivative of mass flow rate with dp_fric
  dm_flow_ddp_fric := crossArea/diameter*mu*dRe_ddp;
  annotation(smoothOrder=1);
end m_flow_of_dp_fric;
