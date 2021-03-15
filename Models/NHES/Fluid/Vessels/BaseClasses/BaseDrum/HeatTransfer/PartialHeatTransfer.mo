within NHES.Fluid.Vessels.BaseClasses.BaseDrum.HeatTransfer;
partial model PartialHeatTransfer

  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium in the component"
    annotation(Dialog(tab="Internal Interface",enable=false));

  // Inputs provided model
  input Medium.ThermodynamicState state "Vapor thermodynamic state";

  SI.CoefficientOfHeatTransfer alpha "Coefficient of heat transfer";
equation

end PartialHeatTransfer;
