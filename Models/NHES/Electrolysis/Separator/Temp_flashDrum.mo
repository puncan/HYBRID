within NHES.Electrolysis.Separator;
model Temp_flashDrum
  extends NHES.Electrolysis.Icons.FlashDrum;
  import      Modelica.Units.SI;

  // ---------- Fluid package -------------------------------------------------
  replaceable package Medium = Electrolysis.Media.Electrolysis.CathodeGas
    constrainedby Modelica.Media.Interfaces.PartialMedium
                                            "Working fluid model"
                          annotation (choicesAllMatching = true,Dialog(group="Working fluid (Medium)"));

  Modelica.Fluid.Interfaces.FluidPort_a feedInlet(redeclare package Medium = Medium) annotation (Placement(
        transformation(extent={{-90,-10},{-70,10}}), iconTransformation(extent={
            {-90,-10},{-70,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b vaporOutlet(redeclare package Medium = Medium) annotation (Placement(
        transformation(extent={{-10,80},{10,100}}), iconTransformation(extent={{
            -10,80},{10,100}})));
  Modelica.Fluid.Interfaces.FluidPort_b liquidOutlet(redeclare package Medium = Medium) annotation (Placement(
        transformation(extent={{-10,-100},{10,-80}}), iconTransformation(extent=
           {{-10,-100},{10,-80}})));
  Modelica.Fluid.Sources.Boundary_pT cathodeGasShellSink(
    nPorts=1,
    redeclare package Medium = Medium,
    p=1960350,
    T=618.331)
              annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={90,0})));
  Modelica.Fluid.Sensors.Temperature temperature(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{12,-10},{32,10}})));
  Modelica.Fluid.Sensors.MassFractions X_H2O(redeclare package Medium =
        Medium, substanceName="H2O")
    annotation (Placement(transformation(extent={{-42,-6},{-22,-26}})));
  Modelica.Fluid.Sensors.MassFractions X_H2(redeclare package Medium =
        Medium, substanceName="H2")
    annotation (Placement(transformation(extent={{-70,16},{-50,36}})));
  Modelica.Fluid.Sources.MassFlowSource_T H2_feed(
    use_m_flow_in=true,
    m_flow=1.35415,
    use_T_in=true,
    redeclare package Medium = Medium,
    nPorts=1,
    use_X_in=false,
    X={1,0},
    T=618.331) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,70})));
  Modelica.Blocks.Math.Product mH2_sep_out annotation (Placement(
        transformation(
        extent={{9,-9},{-9,9}},
        rotation=-90,
        origin={17,41})));
  Modelica.Fluid.Sources.MassFlowSource_T H2O_feed(
    use_m_flow_in=true,
    m_flow=1.35415,
    use_T_in=true,
    redeclare package Medium = Medium,
    use_X_in=false,
    X={0,1},
    nPorts=1,
    T=618.331) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-64})));
  Modelica.Blocks.Math.Product mH2O_sep_out annotation (Placement(
        transformation(
        extent={{-9,-9},{9,9}},
        rotation=-90,
        origin={17,-33})));
equation
  connect(vaporOutlet, vaporOutlet)
    annotation (Line(points={{0,90},{0,90},{0,90}}, color={0,127,255}));
  connect(feedInlet, massFlowRate.port_a)
    annotation (Line(points={{-80,0},{12,0}}, color={0,127,255}));
  connect(massFlowRate.port_b, cathodeGasShellSink.ports[1]) annotation (
      Line(points={{32,0},{80,0},{80,8.88178e-016}}, color={0,127,255}));
  connect(temperature.T, H2_feed.T_in)
    annotation (Line(points={{-3,10},{4,10},{4,58}}, color={0,0,127}));
  connect(feedInlet, temperature.port)
    annotation (Line(points={{-80,0},{-10,0}}, color={0,127,255}));
  connect(X_H2.Xi, mH2_sep_out.u2) annotation (Line(points={{-49,26},{11.6,
          26},{11.6,30.2}}, color={0,0,127}));
  connect(X_H2.port, feedInlet) annotation (Line(points={{-60,16},{-60,0},{
          -80,0}}, color={0,127,255}));
  connect(massFlowRate.m_flow, mH2_sep_out.u1) annotation (Line(points={{22,
          11},{22,30.2},{22.4,30.2}}, color={0,0,127}));
  connect(vaporOutlet, H2_feed.ports[1])
    annotation (Line(points={{0,90},{0,80}}, color={0,127,255}));
  connect(H2_feed.m_flow_in, mH2_sep_out.y) annotation (Line(points={{8,60},
          {8,54},{17,54},{17,50.9}}, color={0,0,127}));
  connect(H2O_feed.ports[1], liquidOutlet) annotation (Line(points={{
          -1.77636e-015,-74},{-1.77636e-015,-76},{0,-76},{0,-90}}, color={0,
          127,255}));
  connect(mH2O_sep_out.u1, massFlowRate.m_flow) annotation (Line(points={{
          22.4,-22.2},{22.4,-16},{40,-16},{40,20},{22,20},{22,11}}, color={
          0,0,127}));
  connect(mH2O_sep_out.y, H2O_feed.m_flow_in) annotation (Line(points={{17,
          -42.9},{17,-46},{17,-48},{16,-48},{8,-48},{8,-54}}, color={0,0,
          127}));
  connect(H2O_feed.T_in, temperature.T)
    annotation (Line(points={{4,-52},{4,10},{-3,10}}, color={0,0,127}));
  connect(X_H2O.port, feedInlet) annotation (Line(points={{-32,-6},{-32,-6},
          {-32,0},{-80,0}}, color={0,127,255}));
  connect(X_H2O.Xi, mH2O_sep_out.u2) annotation (Line(points={{-21,-16},{
          11.6,-16},{11.6,-22.2}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
                Text(
          extent={{-150,20},{150,-20}},
          lineColor={0,0,255},
          textString="%name",
          origin={128,-1},
          rotation=90)}),             Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}})));
end Temp_flashDrum;
