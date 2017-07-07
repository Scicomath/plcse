function [expDiff, theoDiff, alpha,mse]=gammaDiffFun(expOS,expSS,theo,flag)
expOS = expOS(:,2);
expSS = expSS(:,2);
expDiff = expOS - expSS;
n = length(expDiff);
theoDiff = theo(1:n,1) - theo(1:n,2);

objfun = @(x)fun(x,expDiff, theoDiff);
[alpha,mse] = fminsearch(objfun, 1);

fprintf('mse = %g\n',mse);
if flag == 1
    plot(1:n,expDiff,'*', 1:n,alpha*theoDiff)
    legend({'exp','theory'})
end

end

function y = fun(alpha, expDiff, theoDiff)
y = sum((expDiff - alpha*theoDiff).^2);
end