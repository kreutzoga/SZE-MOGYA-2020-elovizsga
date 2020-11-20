# Input data
param nRows;
param cashierCount;
param cashierLength;
set ProductGroups;

param space{ProductGroups};
set Rows:=1..nRows;

# Variables
var BuildingLength >=0;
var lengthOfRows {Rows} >= 0;
var useProduct{Rows, ProductGroups} binary;
var useCashier{Rows} binary;

# Constraints

#Minden kassz�t fel kell haszn�lni
s.t. MustUseAllCashiers:
	sum{r in Rows} useCashier[r] = cashierCount;

#Egy sorban kell elhelyezni az adott term�kcsoporotot
s.t. ProductOnlyOnOneRow{p in ProductGroups}:
	sum{r in Rows} useProduct[r,p] = 1;

#Nem lehet a term�kcsoportokat sz�tszedni
s.t. SetLengthOfRows{r in Rows}:
	sum{p in ProductGroups} useProduct[r,p]*space[p]+useCashier[r]*cashierLength=lengthOfRows[r];

#Leghosszabb sor hossza a BuildingLength
s.t. SetBuildingLength{r in Rows}:
	BuildingLength >= lengthOfRows[r];

# Objective function
minimize LengthOfBuilding: BuildingLength;

solve;

# Displays
printf "%f\n", BuildingLength;

end;