% Description : A function to detect face in an image file.

function [ face_image ] = detect_face(image)
    % Example:
%     image = imread('jaffe/YM.NE3.51.tiff');

    % Create a cascade detector object.
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
    faceDetector = vision.CascadeObjectDetector('FrontalFaceLBP');
    bbox = step(faceDetector, image);

    % Tighten the face region.
    x_shift_factor = bbox(3) / 100 * 12;
    bbox(1) = bbox(1) + x_shift_factor;
    bbox(3) = bbox(3) - 2*x_shift_factor

    y_shift_factor = bbox(4) / 100 * 20;
    bbox(2) = bbox(2) + y_shift_factor;
    bbox(4) = bbox(4) - y_shift_factor;

    face_image = imcrop(image, bbox);

%     face_fig = insertObjectAnnotation(image,'rectangle', bbox, 'Face');
%     figure, imshow(face_fig), title('Detected Face');
end

