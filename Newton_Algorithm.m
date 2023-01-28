% Newton Algorithm for Iteration (Implied Volatility).
% https://www.youtube.com/watch?v=-5e2cULI3H8&ab_channel=TheOrganicChemistryTutor
% The algo is given by vol_n+1 = vol_n - (BSF_n - Opt_Price_Mkt) / differentiate(BSF_n)
% The term differentiate(BSF_n) wrt vol is the vega.

% Only works when calling with BSM_IV_Surface
function[IV] = Newton_Algorithm(epsilon,K,T) % 0.01, K as array, T
    
    % During simulation of V_Heston, we dont call Heston inside of Newton.
%     K = linspace(5.5, 15, 20);
    S = 10; vol = 0.2; r = 0.03; Nmc = 1000;

    % Boundaries for call: max(S0 - K*exp(-r*T),0) < V_mkt < S0
    for i = 1:size(K,2)
    
        price(i) = Price_Euro_BSM_t(S,K(i),vol,r,T,Nmc);
        
        % If the call price violates the boundaries, try it away
        while price(i) < max(S-K(i)*exp(-r*T),0) || price(i) > S
            price(i) = Price_Euro_BSM_t(S,K(i),vol,r,T,Nmc);
        end
            
        % https://quant.stackexchange.com/questions/58634/newtons-algorithm-for-implied-volatility
        vol_initial = (2*abs((log(S/K(i))+r*T)/T))^0.5;
        [Price_BS,~,~,vega] = Black_Scholes(S,K(i),vol_initial,r,T,"Call");

        while abs(Price_BS - price(i)) > epsilon

            vol_new = vol_initial - (Price_BS - price(i))/vega;
            vol_initial = vol_new;
            [Price_BS,~,~,vega] = Black_Scholes(S,K(i),vol_initial,r,T,"Call");
    
        end

        IV(i) = vol_initial;

    end

%     figure;
%     plot(K,IV);
%     title('BSM IV Smile')
%     xlabel 'Strike Price K'
%     ylabel 'Implied Volatility'

end
