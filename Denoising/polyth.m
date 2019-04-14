function [dnsig,polymat]=polyth(x,thresh,poly);

N=length(x);
x=x(:); %convert noisy signal and polynomial into column form
poly=poly(:); 

%dnsig --denoised signal
%x=noisy signal
%poly=polynomial(a)

%finding what is above and below the threshold to generate f matrices and
%calc pseudoinverse of appropriate size


xat = x .* (abs(x)>thresh);  % pass higher scale coeffs if cA % above threshold( visibility issue with approx)
xbt = x .* (abs(x)<=thresh); % if below threshold(2.9)

ncoeff=length(poly)-2;  % as given in paper, max power of x=2N-3 in the formulation (odd powers)

% forming polynomial matrices according as above and below threshold
xbtp = x_matrix(xbt,ncoeff); % nxN [x1 x2 x3;x1^3 x2^3...]V2
xatp = repmat(-thresh,size(xat)) .* (abs(x)>thresh) .* sign(x); %V1

polymat=[xbtp xat xatp];
dnsig=polymat*poly;
