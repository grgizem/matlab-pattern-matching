% Author : Elena Battini Sonmez
% Institue : Istanbul Bilgi University
% Description : A function to read through jaffe database.
% NOTE: Code refactored by Kemal Akkoyun.

function read_jaffe(db_path)

% The database contains 213 images of 7 facial expressions (6 basic facial
% expressions + 1 neutral) posed by 10 Japanese female subjects

% 1 = FE: fear,
% 2 = HA: happy,
% 3 = DI: disgust,
% 4 = AN: angry,
% 5 = SA: sad.
% 6 = SU: surprise.

% Female subject numbers:
% 1 = KA, 2 = KL, 3 = KM, 4 = KR, 5 = MK, 6 = NA, 7 = NA, 8 = NM, 8 = TM,
% 9 = UY, 10 = YM

% OUTPUT : "general_counter" is a subject_no=10 by emotion_no=7 matrix.
% For every subject-row it counts the number of faces having that emotion
% "Faces" is the corresponding matrix storing faces, when the emotion
% present, "Faces" stores the corresponding emotional face.

% DATABASE DEPENDENT CONSTANTS
subject_no = 10;
emotion_no = 7;
default_image_dim = 256;

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

general_counter = zeros(subject_no, emotion_no);
% matrix_faces = zeros(default_image_dim, default_image_dim);
for index=1:number_of_images
    % Example: YM.FE4.70.tiff
    picture_name = actual_pictures(index).name;
    metadata = strsplit(picture_name, '.');
    subject = metadata(1);
    emotion_with_number = metadata(2);
    index_of_picture = metadata(3);
    extension = metadata(4); 
    if (strcmp(extension, 'tiff') == 1)
        emotion = char(emotion_with_number{1:1});
        emotion = emotion(1:2);
        if(strcmp(emotion,'AN'))
            emotion_code=4;
        elseif(strcmp(emotion,'FE'))
            emotion_code=1;
        elseif(strcmp(emotion,'HA'))
            emotion_code=2;
        elseif(strcmp(emotion,'DI'))
            emotion_code=3;
        elseif(strcmp(emotion,'SA'))
            emotion_code=5;
        elseif(strcmp(emotion,'SU'))
            emotion_code=6;
        elseif(strcmp(emotion,'NE'))
            emotion_code=7;
        end

        if(strcmp(subject,'KA'))
            subject_code=1;
        elseif(strcmp(subject,'KL'))
            subject_code=2;
        elseif(strcmp(subject,'KM'))
            subject_code=3;
        elseif(strcmp(subject,'KR'))
            subject_code=4;
        elseif(strcmp(subject,'MK'))
            subject_code=5;
        elseif(strcmp(subject,'NA'))
            subject_code=6;
        elseif(strcmp(subject,'NM'))
            subject_code=7;
        elseif(strcmp(subject,'TM'))
            subject_code=8;
        elseif(strcmp(subject,'UY'))
            subject_code=9;
        elseif(strcmp(subject,'YM'))
            subject_code=10;
        end
        
        peak_counter = general_counter(subject_code,emotion_code)+1;
        general_counter(subject_code,emotion_code) = general_counter(subject_code,emotion_code)+1;
        
        % Create image path.         
        temp = strcat(db_path, '/');
        image_path = strcat(temp, picture_name);
        % Crop only face.
        image = detect_face(imread(image_path));        
        matrix_faces{subject_code,emotion_code}.entire_picture(:,peak_counter) = image(:);
    end
end
save generalCounter_matrixFaces.mat general_counter matrix_faces;
end
