% Black-Scholes Pricing Model European Options.

function[price,d1,d2,vega] = Black_Scholes(S,K,vol,r,T,CP)
    
    d1 = (log(S/K)+(r+vol^2/2)*T)/(vol*T^0.5);
    d2 = d1 - vol*T^0.5;
    
    if CP == "P" || CP == "Put"
        Nd1 = cdf(makedist('Normal'),-d1);
        Nd2 = cdf(makedist('Normal'),-d2);
        price = K*exp(-r*T)*Nd2 - S*Nd1;
    else
        Nd1 = cdf(makedist('Normal'),d1);
        Nd2 = cdf(makedist('Normal'),d2);
        price = S*Nd1 - K*exp(-r*T)*Nd2;
    end

    vega = S*(T/(2*pi))^0.5*exp(-d1^2/2);

end
