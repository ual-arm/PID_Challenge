function varargout = Level_3_end(varargin)
% LEVEL_3_END MATLAB code for Level_3_end.fig
%      LEVEL_3_END, by itself, creates a new LEVEL_3_END or raises the existing
%      singleton*.
%
%      H = LEVEL_3_END returns the handle to a new LEVEL_3_END or the handle to
%      the existing singleton*.
%
%      LEVEL_3_END('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LEVEL_3_END.M with the given input arguments.
%
%      LEVEL_3_END('Property','Value',...) creates a new LEVEL_3_END or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Level_3_end_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Level_3_end_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Level_3_end

% Last Modified by GUIDE v2.5 03-Nov-2023 22:29:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Level_3_end_OpeningFcn, ...
                   'gui_OutputFcn',  @Level_3_end_OutputFcn, ...
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


% --- Executes just before Level_3_end is made visible.
function Level_3_end_OpeningFcn(hObject, eventdata, handles, Score_Level3)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Level_3_end (see VARARGIN)


% Define the window size
  set(gcf, 'units','normalized','outerposition',[0.33 0.35 0.29 0.30]);

% Read table
filename = 'scores_PID.txt';

% Specify the delimiter
delimiter = ';'; % Assuming columns are separated by semicolon

% Specify the options for reading the file
opts = detectImportOptions(filename, 'Delimiter', delimiter);
opts.VariableNamesLine = 1; % Assuming the first row contains header

% Read the file as a table
data_table = readtable(filename, opts);
 
% Display the best cost
if isempty(Score_Level3)
  set(handles.bestCost,'String', '-')
else
    if str2double(Score_Level3) < data_table{end, 5}
        set(handles.bestCost,'String', Score_Level3)
    else
        set(handles.bestCost,'String', string(data_table{end, 5})) 
    end
end

% Update the specific cell in the table
if Score_Level3 == '-'
    data_table{end, 5} = str2double('100000');
else
    if str2double(Score_Level3) <  data_table{end, 5}
        data_table{end, 5} = str2double(Score_Level3);
   end
end

% Update the specific cell in the table
data_table{end, 6} = round(mean(data_table{end, 3:5}),2);

% Save the updated table to a text file (assuming 'updated_data.txt' as the file name)
writetable(data_table, filename, 'Delimiter', ';');

% Choose default command line output for Level_3_end
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Make the GUI modal
set(handles.figure1,'WindowStyle','modal')



% --- Outputs from this function are returned to the command line.
function varargout = Level_3_end_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in nextlevelButton.
function nextlevelButton_Callback(hObject, eventdata, handles)
% hObject    handle to nextlevelButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close
pause(0.5)
endChallenge
