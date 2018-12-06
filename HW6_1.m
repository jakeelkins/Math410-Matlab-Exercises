% HW 6 Problem 1
clear all
clc

C=[-10, 0, 10, 20, 30];

for i=1:5
    F(i)=1.8*C(i)+32;
end

T = array2table([C', F'], 'VariableNames', {'C', 'F'})