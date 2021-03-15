within NHES.Systems.EnergyStorage.BaseClasses;
partial model Partial_SubSystem

  extends NHES.Systems.BaseClasses.Partial_SubSystem;

  annotation (
    defaultComponentName="ES",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
                  Text(
          extent={{-94,-76},{94,-84}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Energy Storage")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,140}})));
end Partial_SubSystem;
