%========================================================================%
%Note:                                                                   %
%This is a subfunction from the Baybayin OCR System (Baybayin_only.m)    % 
%for clustering a grayscaled image into 2 intensities intended for image %
%binarization.                                                           % 
% -----------------------------------------------------------------------%

%u=raw image
%M=number of clusters
function [c,a] = kmeans_mod(u,M)

    itmax = 1000;

    U = sort(double(u(:)));
    L = length(U);
    M = min(M,L);
    dU = U(2:L) - U(1:(L-1));
    [dUs,dUi] = sort(dU,'descend');
    b = sort(dUi(1:(M-1)));
    b = [0,b(:)',L];
    a  = zeros(M,1);
    for m=1:M
        a(m) = mean(U((b(m)+1):b(m+1)));
    end

    chi = zeros(size(u));
    for it=1:itmax
        avail = ones(size(u));
        as = a;
        for m=1:M
            psi = avail;
            for n=1:M
                if (n ~= m)
                    psi = psi.*(abs(u - a(m)) <= abs(u - a(n)));
                end
            end
            dom = find(psi);
            if (~isempty(dom))
                chi(dom) = m;
                avail(dom) = 0;
            end
        end
        for m=1:M
            dom = find(chi == m);
            if (~isempty(dom))
                a(m) = mean(u(dom));
            else
                a(m) = 0;
            end
        end
        if (max(abs(a-as)) == 0)
            break;
        end
    end
    if (it >= itmax)
        warning('Maximum number of iterations reached in kmeans!');
    end
    c = zeros(size(u));
    for m=1:M
        dom = find(chi == m);
        if (~isempty(dom))
            c(dom) = a(m);
        end
    end
