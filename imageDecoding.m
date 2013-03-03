function ret = imageDecoding(cryptic_image, lookup_table)
    [R, C, K] = size(cryptic_image);
    new_image = zeros([R, C, K]);
    
    for i=1:length(lookup_table)
        new_image(i,:) = cryptic_image(lookup_table(i),:);  
    end
    ret = uint8( new_image );
end
