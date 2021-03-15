within NHES.Math;
function BesselJ
  extends Modelica.Icons.Function;

  import gamma = NHES.Math.gamma_Lanczos;
  import NHES.Math.factorial;

  input Real k "Bessel order";
  input Real x "Value in Jk(x)";
  input Real tolerance = 1e-6 "tolerance for infinite sum termination";

  output Real Jk "Bessel function Jk(x) (order k) value";

protected
  Real eps = Modelica.Constants.eps*tolerance;
  Real sum_new, sum_old;
  Real nu = if k < 0 then -k else k;
  Integer n "Number of values inluded in infinite sum";
  Real err;

algorithm

  sum_old := 0;
  n :=0;
  err :=100;

  while err >= tolerance and n <=1e3 loop
    sum_new :=sum_old + (-0.25*x^2)^n/(factorial(n)*gamma(nu + n + 1));
    err :=abs(sum_new - sum_old);
    n := n + 1;
    sum_old :=sum_new;
  end while;

  assert(n<=1e3, "Maximum number of iterations reached in BesselJ. Relax tolerance or check input values");

  if k < 0 then
    Jk := (-1)^nu*(0.5*x)^nu*sum_new;
  else
    Jk :=(0.5*x)^nu*sum_new;
  end if;

  annotation (Documentation(info="<html>
<p>An implementation of Kreisselmeier Steinhauser smooth maximum</p>
</html>"));
end BesselJ;
