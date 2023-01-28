% Create a BSM alternative for call option payoffs.

function[payoff] = BSM_Model(S,K,vol,r,T) % 10,10,0.2,0.03,1

    S(1) = S; N = 100; delta_t = T/N;
    time_vector = linspace(0, T, N);

    for i = 2:N

        N1 = randn;
        S(i) = S(i-1) * exp((r-vol^2/2)*delta_t + vol*N1*delta_t^0.5);

    end
    
    % The array S is the spot price evolution
    payoff = max(S(N) - K, 0);

%     figure;
%     plot(time_vector, S, 'r');
%     title('Stock Price')
%     xlabel 'Time'
%     ylabel 'Stock Price'

end
