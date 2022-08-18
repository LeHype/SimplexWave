function [Value] = Simplex(time,args)
% This function creates and stores a simplex image
% Then it also handles the interpolation between
% 2 steps if "time" is not a descrete integer
arguments    
    time                 (1,1) {mustBeNumeric}
    args.Seed            (1,1) {mustBeNumeric} = 1
    %Seed for the generation of the Simplex
    args.simplexSize     (1,1) {mustBeNumeric} = 80 
    %Defines the size of the simplex input image
    args.warpFactor      (1,1) {mustBeNumeric} = 2
    %Scales the Distribution so the Wave can be more or less smooth
end

persistent Map 

varmap = strcat('v',num2str(args.Seed));
% Try and except is bad practise but I did not find a method for checking
% existence of struct entry. "exists()" does not work
try
    Map.(varmap);
catch
    Map.(varmap) = SimplexNoise(args.simplexSize,'Seed',args.Seed);
end

SimplexMap = Map.(varmap);
time = time*args.warpFactor;  % Warp Factor is applied High warp means faster rng

%% Check if time is an integer and if not interpolate between the next two integers
if floor(time) == time
    Value = HamiltonianPathForSimplex(SimplexMap,time);
else
    ValueUpper = HamiltonianPathForSimplex(SimplexMap,ceil(time));
    ValueLower = HamiltonianPathForSimplex(SimplexMap,floor(time));
    Value = interp1([floor(time) ceil(time)],[ValueLower ValueUpper],time);
end
end

