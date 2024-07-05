function varargout = Register(varargin)
% REGISTER MATLAB code for Register.fig
%      REGISTER, by itself, creates a new REGISTER or raises the existing
%      singleton*.
%
%      H = REGISTER returns the handle to a new REGISTER or the handle to
%      the existing singleton*.
%
%      REGISTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REGISTER.M with the given input arguments.
%
%      REGISTER('Property','Value',...) creates a new REGISTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Register_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Register_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Register

% Last Modified by GUIDE v2.5 28-Nov-2023 12:33:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Register_OpeningFcn, ...
                   'gui_OutputFcn',  @Register_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Register is made visible.
function Register_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Register (see VARARGIN)


% Define the window size
  set(gcf, 'units','normalized','outerposition',[0.36 0.25 0.32 0.42]);

% Choose default command line output for Register
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Register wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Register_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function NameEdit_Callback(hObject, eventdata, handles)
% hObject    handle to NameEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NameEdit as text
%        str2double(get(hObject,'String')) returns contents of NameEdit as a double


% --- Executes during object creation, after setting all properties.
function NameEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NameEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EmailEdit_Callback(hObject, eventdata, handles)
% hObject    handle to EmailEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EmailEdit as text
%        str2double(get(hObject,'String')) returns contents of EmailEdit as a double


% --- Executes during object creation, after setting all properties.
function EmailEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EmailEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get the name and e-mail
newName = handles.NameEdit.String;
newEmail = handles.EmailEdit.String;

filename = 'scores_PID.txt';

% Check if the file exists
if exist(filename, 'file') == 0
    % If the file doesn't exist, create a new one and add the new information
    fileID = fopen(filename, 'w');
    if fileID == -1
        error('Could not create file');
    end
    % create Header
    fprintf(fileID, 'Name;Email;Score1;Score2;Score3;Total;Tries\n');
    % Write the data to the file
    fprintf(fileID, '%s;%s;%d;%d;%d;%d\n', newName, newEmail, 1e5, 1e5, 1e5, 1e5);
    fclose(fileID);
else
 
    % Specify the delimiter
    delimiter = ';'; % Assuming columns are separated by semicolon

    % Specify the options for reading the file
    opts = detectImportOptions(filename, 'Delimiter', delimiter);
    opts.VariableNamesLine = 1; % Assuming the first row contains header
    
    % Read the file as a table
    data_table = readtable(filename, opts);
    
    % Check if the name exists in the 'Name' column of the table
    nameExists = any(strcmp(data_table.Name, newName));
    nameIndex = find(strcmp(data_table.Name, newName));
    
    % Check if the name exists in the 'Name' column of the table
    emailExists = any(strcmp(data_table.Email, newEmail));
    emailIndex = find(strcmp(data_table.Email, newEmail));
    
    numberTries_name = data_table.Tries(nameIndex);
    numberTries_email = data_table.Tries(emailIndex);
    
    % If there is no match of name - number of tries is 0
    if isempty(numberTries_name)
        numberTries_name = 0;
    end
    
    % If there is no match of email - number of tries is 0
    if isempty(numberTries_email)
        numberTries_email = 0;
    end
    
    if (max(numberTries_name) >1 || max(numberTries_email)>1) % The player have played twice - should not allow
       CreateStruct.Interpreter = 'tex';
       CreateStruct.WindowStyle = 'modal';
       msgbox('\fontsize{15} The player has already tried.',CreateStruct);
       return
    elseif (numberTries_name == 1) % The player have played once 
        data_table(nameIndex:end,:) = flip(data_table(nameIndex:end,:),1);
        data_table.Tries(end) = data_table.Tries(end) + 1;
        
        % Save the updated table to a text file (assuming 'updated_data.txt' as the file name)
        writetable(data_table, filename, 'Delimiter', ';');
        
    elseif (numberTries_email==1)    
        data_table(emailIndex:end,:) = flip(data_table(emailIndex:end,:),1);
        data_table.Tries(end) = data_table.Tries(end) + 1;
    
        % Save the updated table to a text file (assuming 'updated_data.txt' as the file name)
        writetable(data_table, filename, 'Delimiter', ';');
    
    else
        % If the name and email are not found, open the file in append mode and add the new information
        fileID = fopen(filename, 'a');
        if fileID == -1
            error('Could not open file for writing');
        end
        fprintf(fileID, '%s;%s;%d;%d;%d;%d;%d\n', newName, newEmail, 1e5, 1e5, 1e5, 1e5, 1);
        fclose(fileID);
    end
end

close all
Level_1


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close all
Instructions
