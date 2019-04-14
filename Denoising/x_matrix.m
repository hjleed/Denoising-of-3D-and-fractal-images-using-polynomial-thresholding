function y=x_matrix(x,N)

y=[];

for ii=1:N
    y=[y x.^(2*ii-1)];

end