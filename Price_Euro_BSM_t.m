% Price an European Option with BSM.
% Inputs = 10,10,0.2,0.03,1,1000

function[price] = Price_Euro_BSM_t(S,K,vol,r,T,Nmc)

    sum = 0;

    for i = 1:Nmc

        payoff = BSM_Model(S,K,vol,r,T);
        sum = sum + payoff;

    end

    price = exp(-r*T)*sum/Nmc;

end
