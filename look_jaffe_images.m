% Author : Kemal Akkoyun
% Institue : Istanbul Bilgi University
% Id : 11076004
% Description : A function to look through jaffe database.

function look_jaffe_images(db_path)

% The database contains 213 images of 7 facial expressions.
% [6 basic facial  expressions + 1 neutral] posed by 10 Japanese female
% models.

% Directory that contains pictures.
directory_of_pictures = dir(db_path);

% Filter relevant images.
actual_pictures = [];
for i=1:length(directory_of_pictures)
    % Example: YM.FE4.70.tiff
    if(length(strsplit(directory_of_pictures(i).name, '.')) > 2)
        actual_pictures = [actual_pictures directory_of_pictures(i)];
    end
end

% Number af actual images.
number_of_images = length(actual_pictures);

for i=1:number_of_images
    % Example: YM.FE4.70.tiff
    picture_name = actual_pictures(i).name;
    metadata = strsplit(picture_name, '.');
    initials = metadata(1);
    emotion = metadata(2);
    index_of_picture = metadata(3);
    extension = metadata(4);
    if (strcmp(extension, 'tiff') == 1)
        temp = strcat(db_path, '/');
        image_path = strcat(temp, picture_name);
        image = imread(image_path);
        % If you just want to extract face.
        % image = detect_face(image);
        imshow(image)
        pause(1)
    end
end
end
