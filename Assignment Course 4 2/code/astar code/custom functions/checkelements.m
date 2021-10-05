function isin = checkelements(element, vector)
%checks if element is present in vector and returns boolean value
%only works for a vector i.e. size = [n,1]
for i = 1:length(vector)
    if element == vector(i,1)
        isin = true;
    else 
        isin = false;
    end 
end 
        