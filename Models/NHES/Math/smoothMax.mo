within NHES.Math;
function smoothMax
  extends Modelica.Icons.Function;
  import Modelica.Math;

  input Real x1 "First argument of smooth max operator";
  input Real x2 "Second argument of smooth max operator";
  input Real dx
  "Approximate difference between x1 and x2, below which regularization starts";
  output Real y "Result of smooth max operator";
algorithm
  y := max(x1, x2) + Math.log((exp((4/dx)*(x1 - max(x1, x2)))) + (exp((4/
    dx)*(x2 - max(x1, x2)))))/(4/dx);
  annotation (smoothOrder=2, Documentation(info="<html>
<p>An implementation of Kreisselmeier Steinhauser smooth maximum</p>
</html>"));
end smoothMax;
