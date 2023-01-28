% Binomial Option Pricing Model
% Time starts at 0 with 1 node, 1 with 2 node, 2 with 3 nodes etc.

function[price] = Binomial_Model()

    T = 1; sigma = 0.2; r = 0.1;
    N = 250; delta = T/N;
    u = exp(sigma*delta^0.5); d = 1/u;
    Stock = 10; Strike = 10;
    p = (exp(r*delta)-d)/(u-d);

    for i = 1:T*N+1

        S(i) = max(Stock*u^(T*N-i+1)*d^(i-1)-Strike,0);

    end

    for i = 1:N

        O = 1:T*N+1-i;

        for j = 1:size(O,2)

            P(j) = S(j)*p+S(j+1)*(1-p);

        end

        S = P;
        P = 1:T*N-i;

    end

    price = S*exp(-r*T);

end
