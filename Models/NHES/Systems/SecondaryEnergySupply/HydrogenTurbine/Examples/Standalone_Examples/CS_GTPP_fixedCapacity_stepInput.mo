within NHES.Systems.SecondaryEnergySupply.HydrogenTurbine.Examples.Standalone_Examples;
model CS_GTPP_fixedCapacity_stepInput
  extends
    NHES.Systems.SecondaryEnergySupply.HydrogenTurbine.BaseClasses.Partial_ControlSystem;
  extends Icons.DummyIcon;

  Modelica.Blocks.Math.Feedback feedback_W_gen annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-40,0})));
  Modelica.Blocks.Sources.Ramp loadSignal1(
      duration=0,
      offset=35*1e6,
      startTime=10,
      height=-3.5*1e6*5) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-70,84})));
  Modelica.Blocks.Math.Add sumLoads annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=-90,
          origin={-48,28})));
  Modelica.Blocks.Sources.Ramp loadSignal2(
    duration=0,
    offset=0,
    startTime=40,
    height=3.5*1e6*3.1)        annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,50})));
  Modelica.Blocks.Continuous.PI FBctrl_powerGeneration(
    y_start=1,
    x_start=1/FBctrl_powerGeneration.k,
    T=1.5,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    k=30/(35e6))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(loadSignal1.y, sumLoads.u1) annotation (Line(points={{-59,84},{
          -43.2,84},{-43.2,37.6}}, color={0,0,127}));
  connect(loadSignal2.y, sumLoads.u2) annotation (Line(points={{-59,50},{
          -52.8,50},{-52.8,37.6}}, color={0,0,127}));
  connect(sumLoads.y, feedback_W_gen.u1) annotation (Line(points={{-48,19.2},
          {-48,12},{-60,12},{-60,0},{-48,0}}, color={0,0,127}));
  connect(feedback_W_gen.y, FBctrl_powerGeneration.u)
    annotation (Line(points={{-31,0},{-18,0},{-12,0}}, color={0,0,127}));
  connect(sensorBus.W_gen, feedback_W_gen.u2) annotation (Line(
      points={{-30,-100},{-40,-100},{-40,-100},{-40,-100},{-40,-8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.GTPP.m_flow_fuel_pu, FBctrl_powerGeneration.y)
    annotation (Line(
      points={{30,-100},{30,-100},{30,-60},{30,0},{11,0}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  annotation (defaultComponentName="CS",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CS_GTPP_fixedCapacity_stepInput;
