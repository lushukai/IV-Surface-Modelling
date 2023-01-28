% Black-Scholes Implied Volatility Surface.
% As TTM increases, the IV decreases and smile flattens.

function[IVS,K,T] = BSM_IV_Surface()

    K = linspace(5.5, 15, 20); T = linspace(0.25, 5, 20);
    epsilon = 0.01;
    
    for i = 1:size(T,2)

        IVS(i,1:20) = Newton_Algorithm(epsilon,K,T(i));

    end

%     figure;
%     surf(K, T, IVS);
%     title('Volatility Surface')
%     xlabel 'Strike'
%     ylabel 'Time'
%     zlabel 'Volatility'

end
