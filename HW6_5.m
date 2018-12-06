% HW6 Problem 5
clear all
clc

prompt='Input value for n: '; n=input(prompt);
prompt='Input value for lower bound a: '; a=input(prompt);
prompt='Input value for upper bound b: '; b=input(prompt);

S=(b-a)*(fan(a)+fan(b))/2;
Sv=[];Errv=[];

for j=1:n
    S1=0.0;
    K=2^(j-1);
    h=(b-a)/(2^j);
for i=1:K
    x=a+(2*i-1)*h;
    S1=S1+fan(x);
end
S=(S/2)+S1*h;
Err=S-2.0;
Sv=[Sv;S];Errv=[Errv;Err];
end

format long
[Sv Errv]
    
