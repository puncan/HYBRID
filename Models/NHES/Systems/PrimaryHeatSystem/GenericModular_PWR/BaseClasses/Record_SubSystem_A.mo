within NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.BaseClasses;
partial record Record_SubSystem_A

  extends Record_SubSystem;

   replaceable package Medium = Modelica.Media.Water.StandardWater
     constrainedby Modelica.Media.Interfaces.PartialMedium
     "Medium at fluid ports" annotation (choicesAllMatching=true);

   /* Nominal Conditions */
   parameter TRANSFORM.Examples.Utilities.Record_fluidPorts port_a_nominal(
       redeclare package Medium = Medium, T=Medium.temperature(
         Medium.setState_ph(port_a_nominal.p, port_a_nominal.h))) "port_a"
     annotation (Dialog(tab="Nominal Conditions"));
   parameter TRANSFORM.Examples.Utilities.Record_fluidPorts port_b_nominal(
     redeclare package Medium = Medium,
     T=Medium.temperature(Medium.setState_ph(port_b_nominal.p,
         port_b_nominal.h)),
     m_flow=-port_a_nominal.m_flow) "port_b"
     annotation (Dialog(tab="Nominal Conditions"));

   /* Initialization */
   parameter TRANSFORM.Examples.Utilities.Record_fluidPorts port_a_start(
     redeclare package Medium = Medium,
     p=port_a_nominal.p,
     T=Medium.temperature(Medium.setState_ph(port_a_start.p, port_a_start.h)),
     h= port_a_nominal.h,
     m_flow=port_a_nominal.m_flow) "port_a"
     annotation (Dialog(tab="Initialization"));

   parameter TRANSFORM.Examples.Utilities.Record_fluidPorts port_b_start(
     redeclare package Medium = Medium,
     p=port_b_nominal.p,
     T=Medium.temperature(Medium.setState_ph(port_b_start.p, port_b_start.h)),
     h= port_b_nominal.h,
     m_flow=-port_a_start.m_flow) "port_b"
     annotation (Dialog(tab="Initialization"));

   /* Assumptions */
   parameter Boolean allowFlowReversal=true
     "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
     annotation (Dialog(tab="Assumptions"), Evaluate=true);

  annotation (defaultComponentName="data",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Record_SubSystem_A;
