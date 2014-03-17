% Description : A function to detect face in an image file.

function [ face_image ] = detect_face(image)
    % Example:
%     image = imread('jaffe/YM.NE3.51.tiff');
    default_image_dim = 256;

%     Create a cascade detector object.
    % Uses Viola-Jones algorithm. Default recognizes front-face.
    %      Available parameters.
    %      Frontal Face (CART) [Default]
    %      Frontal Face (LBP)
    %      Upper Body
    %      Eye Pair
    %      Single Eye
    %      Single Eye (CART)
    %      Profile Face
    %      Mouth
    %      Nose
    faceDetector = vision.CascadeObjectDetector();
    bbox = step(faceDetector, image);

    % Tighten the face region.
    x_shift_factor = bbox(3) / 100 * 11;
    bbox(1) = bbox(1) + x_shift_factor;
    bbox(3) = bbox(3) - 2*x_shift_factor

    y_shift_factor = bbox(4) / 100 * 19;
    bbox(2) = bbox(2) + y_shift_factor;
    bbox(4) = bbox(4) - y_shift_factor;

    image = imcrop(image, bbox);
    % Resizing the image to create a unified data model.     
    face_image = imresize(image, [130 120]);

%     face_fig = insertObjectAnnotation(face_image,'rectangle', bbox, 'Face');
%     figure, imshow(face_fig), title('Detected Face');
end

