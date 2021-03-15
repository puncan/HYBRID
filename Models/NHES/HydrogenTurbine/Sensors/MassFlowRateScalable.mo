within NHES.HydrogenTurbine.Sensors;
model MassFlowRateScalable "Scalable ideal sensor for mass flow rate"
  extends Modelica.Fluid.Sensors.BaseClasses.PartialFlowSensor;
  extends Modelica.Icons.RoundSensor;
  parameter Real capacityScaler = 1 "Scaler that sizes the capacity of the overall system";
  Modelica.Blocks.Interfaces.RealOutput m_flow(quantity="MassFlowRate",
                                               final unit="kg/s")
    "Mass flow rate from port_a to port_b" annotation (Placement(
        transformation(
        origin={0,110},
        extent={{10,-10},{-10,10}},
        rotation=270)));

equation
  m_flow = capacityScaler*port_a.m_flow;
annotation (
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Line(points={{70,0},{100,0}}, color={0,128,255}),
        Text(
          extent={{162,120},{2,90}},
          lineColor={0,0,0},
          textString="m_flow"),
        Line(points={{0,100},{0,70}}, color={0,0,127}),
        Line(points={{-100,0},{-70,0}}, color={0,128,255})}),
  Documentation(info="<html>
<p>
This component monitors the scaled mass flow rate flowing from port_a to port_b.
The sensor is ideal, i.e., it does not influence the fluid.
</p>
</html>"));
end MassFlowRateScalable;
