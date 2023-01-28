% Kernel Regression
% https://towardsdatascience.com/kernel-regression-made-easy-to-understand-86caf2d2b844
% Higher bandwidth (hx) smoothens the surface

function[sigma_hat,IVS] = Kernel_Regression(hx)
    
    surface_K = linspace(5.2, 15, 20);
    surface_T = linspace(0.1, 5, 20);
    [IVS,K,T] = BSM_IV_Surface(); % Matrix of IVs

    for j = 1:size(surface_K,2)

        for k = 1:size(surface_T,2)
    
            % Each point passed to kernel produces norm bell curve
            % The columns are the strikes and the rows are the TTM
            for i = 1:size(IVS,2)
        
                % hx is the bandwidth parameter
                kernel_K(i) = 1/(2*pi)^0.5*exp(-(surface_K(j)-K(i))^2/(2*hx));
                kernel_T(i) = 1/(2*pi)^0.5*exp(-(surface_T(k)-T(i))^2/(2*hx));
        
            end
        
            kernel_prod = kernel_K.*kernel_T;
            kernel_weights = kernel_prod/sum(kernel_prod);
            sigma_hat(j,k) = sum(kernel_weights.*diag(IVS)');

        end

    end

    figure;
    surf(surface_K, surface_T, sigma_hat,'FaceColor','g');
    hold on
    surf(K, T, IVS,'FaceColor','r');
    title('Volatility Surface')
    xlabel 'Strike'
    ylabel 'Time'
    zlabel 'Volatility'

end
