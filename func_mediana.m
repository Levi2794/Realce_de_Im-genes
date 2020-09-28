function PS = func_mediana(vecindad)

vecindad = double(vecindad);

[m n] = size(vecindad);

vector = vecindad(:)';

vector = sort(vector);

L = length(vector);

cent = round(L/2);

PS = vector(1, cent);

