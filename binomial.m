function b0 = binomial(N)

b0 = zeros(1, N);

for x=0:N-1
    b0(x+1) = nchoosek(N-1, x); %Chequeo de la matriz y los acomoda
end