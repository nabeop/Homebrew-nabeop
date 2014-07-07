function mplot(v1, v2, v3)
%perform plotting。データをプロットします。
%usage:
%
% mplot(x, 'overwrite') --- plot x. previous plot from the same variable will be overwritten.
% mplot(x) --- same as above.
% mplot(x, 'new') --- plot x as a new series.
%
% mplot(x, y, 'overwrite') --- plot the pair of x and y. previous plot from the same pair of variables will be overwritten.
% mplot(x, y) --- same as above.
% mplot(x, y, 'new') --- plot the pair of x and y as a new series.
%
%使い方
%
% mplot(x, 'overwrite') --- xをプロット。同じ変数が以前にプロットされていれば上書き。
% mplot(x) --- 同上。
% mplot(x, 'new') --- xを新しい系列としてプロット。
%
% mplot(x, y, 'overwrite') --- xとyのペアをプロット。同じ変数ペアが以前にプロットされていれば上書き。
% mplot(x, y) --- 同上
% mplot(x, y, 'new') --- xとyのペアを新しい系列としてプロット。



LIMIT = 200000;%You can change this as you like.
if(length(v1) > LIMIT)
    warning('Data length exceeds limit. Only the first %d data will be plotted. (You can change the limit. See mplot.m)', LIMIT);
end

m = mjo.core.MjoManager.getSharedInstance();

switch (nargin)
    case 1
        b = false;
        y = v1(1:min(end, LIMIT));
        
        %TODO:LIMITを超えたらここで警告を出す。
        
       
        
        if(isreal(y))
            m.plot(inputname(1), y, b);
            return;
        else
            m.plot(inputname(1), real(y), imag(y), b);
            return;
        end
        
    case 2
        if(ischar(v2))%2nd arg is option
            y = v1(1:min(end, LIMIT));
            if strcmp(v2, 'new')
                b = true;
            elseif strcmp(v2, 'overwrite')
                b = false;
            else
                error('option should be new or overwrite.');
                return;
            end
            
            if(isreal(y))
                m.plot(inputname(1), y, b);
                return;
            else
                m.plot(inputname(1), real(y), imag(y), b);
                return;
            end
            
            
        else%2nd arg is data
            x = v1(1:min(end, LIMIT));
            y = v2(1:min(end, LIMIT));
            b = false;
            if length(x) ~= length(y)
                error('The length of x and y must be the same.');
                return;
            end
            m.plot(inputname(1), inputname(2), x, y, b);
            return;
            
        end
        
        
    case 3
        x = v1(1:min(end, LIMIT));
        y = v2(1:min(end, LIMIT));
        
        if strcmp(v3, 'new')
            b = true;
        elseif strcmp(v3, 'overwrite')
            b = false;
        else
            error('option should be new or overwrite.');
            return;
        end
        
        if length(x) ~= length(y)
            error('The length of x and y must be the same.');
            return;
        end
        
        m.plot(inputname(1), inputname(2), x, y, b);
        return;
        
    otherwise
        error('the number of input args is wrong.');
        return;
end


end
