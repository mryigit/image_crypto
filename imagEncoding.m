function [img, LUT] = imagEncoding(I)
    [R, C, K] = size(I);
    lookup_table = randperm(R);
    new_image = zeros([R, C, K]);
    
    for i=1:length(lookup_table)
        new_image( lookup_table(i),: ) = I( i,: );
    end
    img = uint8( new_image );
    LUT = lookup_table;
end
