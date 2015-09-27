function [y,Fs] = audioread_compat(file_path,samples,dataType)
% Read audio file (backwards-compatible with version < 2014a)
switch nargin
    case 1
        try
            [y,Fs] = audioread(file_path);
        catch message;
            if strcmp(message,'MATLAB:UndefinedFunction') || ...
                    strcmp(message.identifier, 'Octave:undefined-function')
                [y,Fs] = wavread(file_path);
            else
                rethrow(message);
            end
        end
    case 2
        try
            [y,Fs] = audioread(file_path,samples);
        catch message;
            if strcmp(message,'MATLAB:UndefinedFunction')
                [y,Fs] = wavread(file_path,samples);
            elseif strcmp(message.identifier, 'Octave:undefined-function')
                if isnumeric(samples)
                    [y,Fs] = wavread(file_path,samples);
                elseif ischar(samples) && strcmp(samples, 'double')
                    [y,Fs] = wavread(file_path);
                else
                    error(['Octave only supports calling wavread for' ...
                        ' ''double'' datatype.']);
                end
            else
                rethrow(message);
            end
        end
    case 3
        try
            [y,Fs] = audioread(file_path,samples,dataType);
        catch message;
            if strcmp(message,'MATLAB:UndefinedFunction')
                [y,Fs] = wavread(file_path,samples,dataType);
            elseif strcmp(message.identifier, 'Octave:undefined-function')
                if strcmp(dataType, 'double')
                    [y,Fs] = wavread(file_path,samples);
                else
                    error(['Octave only supports calling wavread for' ...
                        ' ''double'' datatype.']);
                end
            else
                rethrow(message);
            end
        end
end
end
