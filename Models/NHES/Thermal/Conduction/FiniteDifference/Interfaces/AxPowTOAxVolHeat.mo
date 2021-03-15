within NHES.Thermal.Conduction.FiniteDifference.Interfaces;
model AxPowTOAxVolHeat
  "Converts axial volumetrically divided power to axial volumetric heating"

  import Modelica.Constants.pi;

  parameter SI.Length r_inner "Centerline/Inner radius of cylinder"
  annotation(Dialog(group="Geomety"));
  parameter SI.Length r_outer "Outer radius of cylinder"
  annotation(Dialog(group="Geomety"));
  parameter SI.Length length "length of cylinder"
  annotation(Dialog(group="Geomety"));

  parameter Integer nRadial(min=3) "Nodes in radial direction"
  annotation(Dialog(group="Nodalization"));
  parameter Integer nAxial(min=3) "Nodes in axial direction"
  annotation(Dialog(group="Nodalization"));
  parameter Integer nElem = 1 "# of parallel elements for power scaling";

  Modelica.Blocks.Interfaces.RealInput Power_in[nAxial]
    "Input Axial Power Distribution (volume approach)"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

  Modelica.Blocks.Interfaces.RealOutput q_ppp[nRadial,nAxial](unit="W/m3")
    "Volumetric heat source"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  SI.Volume volTotal = pi*(r_outer^2-r_inner^2)*length;
  SI.Volume volAxial = volTotal/(nAxial);
  Real q_ppp_vol[nAxial](unit="W/m3");

equation
q_ppp_vol = Power_in/(nElem*volAxial);

for i in 1:nRadial loop
  for j in 1:nAxial loop
    q_ppp[i,j] = q_ppp_vol[j];
  end for;
end for;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics={
        Rectangle(
          extent={{-100,34},{100,-34}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-43,-27},{-37,-33}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-103,-27},{-97,-33}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-43,33},{-37,27}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-103,33},{-97,27}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{37,-27},{43,-33}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{97,-27},{103,-33}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{37,33},{43,27}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{97,33},{103,27}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-100,30},{-40,30},{-40,-30},{-100,-30},{-100,30}},
          color={0,0,0},
          pattern=LinePattern.Dot,
          thickness=0.5),
        Text(
          extent={{-98,30},{-42,-24}},
          lineColor={0,0,0},
          pattern=LinePattern.Dot,
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="Power"),
        Text(
          extent={{-18,18},{18,-18}},
          lineColor={0,0,0},
          pattern=LinePattern.Dot,
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="TO"),
        Text(
          extent={{48,16},{92,-12}},
          lineColor={0,0,0},
          pattern=LinePattern.Dot,
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="q_ppp"),
        Line(
          points={{40,30},{100,30},{100,-30},{40,-30},{40,30}},
          color={0,0,0},
          pattern=LinePattern.Dot,
          thickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}})));
end AxPowTOAxVolHeat;
