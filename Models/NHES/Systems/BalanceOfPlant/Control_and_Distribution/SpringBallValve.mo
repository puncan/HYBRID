within NHES.Systems.BalanceOfPlant.Control_and_Distribution;
model SpringBallValve
  "Valve that allows minimum flow until a pressure value is met, and then becomes completely open."
  extends TRANSFORM.Fluid.Valves.BaseClasses.PartialTwoPortTransport;
  parameter Modelica.Units.SI.AbsolutePressure p_spring
    "Nominal pressure drop at full opening"
    annotation (Dialog(group="Nominal operating point"));
  input Real K( unit="1/(m.kg)") "This value is equal to K_nominal/(2*A^2) for flow area A and lookup value K_nominal in standard engineering tables."
    annotation (Dialog(group="Inputs"));
  Modelica.Units.SI.AbsolutePressure p_in;
  parameter Real opening_init = 1;
  Real opening(start = opening_init);
  parameter Real tau(unit = "1/s") = 0.1;
  parameter Real open_min = 0;
equation
  p_in = port_a.p;
  if p_in>p_spring then
    der(opening) = (1-opening)/tau;
  else
    der(opening) = (open_min-opening)/tau;
    end if;
  port_a.p-port_b.p = port_a.m_flow*sqrt(port_a.m_flow*port_a.m_flow + 0.001*0.001)*K/((opening+0.001));
  // Isenthalpic state transformation (no storage and no loss of energy)
  port_a.h_outflow = inStream(port_b.h_outflow);
  port_b.h_outflow = inStream(port_a.h_outflow);
annotation (
  Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{0,50},{0,0}}),
        Rectangle(
          extent={{-20,60},{20,50}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,50},{100,-50},{100,50},{0,0},{-100,-50},{-100,50}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points=DynamicSelect({{-100,0},{100,-0},{100,0},{0,0},{-100,-0},{-100,
              0}}, {{-100,50*opening_actual},{-100,50*opening_actual},{100,-50*opening_actual},{
              100,50*opening_actual},{0,0},{-100,-50*opening_actual},{-100,50*opening_actual}}),
          fillColor={0,255,0},
          lineColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(points={{-100,50},{100,-50},{100,50},{0,0},{-100,-50},{-100,
              50}}, lineColor={0,0,0})}),
  Documentation(info="<html>
<p>This very simple model provides a pressure drop which is proportional to the flowrate and to the <span style=\"font-family: Courier New;\">opening</span> input, without computing any fluid property. It can be used for testing purposes, when a simple model of a variable pressure loss is needed. A linear hyperbolic tangent function uses the opening input and converts it to opening_actual, which is now used in the calculations. </p>
<p>A medium model must be nevertheless be specified, so that the fluid ports can be connected to other components using the same medium model.</p>
<p>The model is adiabatic (no heat losses to the ambient) and neglects changes in kinetic energy from the inlet to the outlet.</p>
</html>",
    revisions="<html>
<ul>
<li><i>4 May 2020</i>
    by <a href=\"mailto:daniel.mikkelson@inl.gov\">Daniel Mikkelson</a>:<br>
       Adapted from the TRANSFORM library.</li>
</ul>
</html>"));
end SpringBallValve;
