function mfigure( index )
%activate a graph window. The index must be between 0 and 24.
%グラフウィンドウを起動。 indexは0~24まで
%ex:
% mfigure;
% mfigure(3);


m = mjo.core.MjoManager.getSharedInstance();

if(nargin == 0)
    m.launchFrame();
else
    m.launchFrame(index);
end

end
