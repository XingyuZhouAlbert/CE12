for i = 1 : 1000;
    if (rem(i,4) == 0 & rem(i,9) == 0)
        disp ('DEADBEEF');
    elseif (rem(i,9) == 0)
        disp ('BEEF');
    elseif (rem(i,4) == 0)
        disp ('DEAD');
    else disp (i)
    end
end

   





    