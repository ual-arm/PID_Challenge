function varargout = endChallenge(varargin)
% ENDCHALLENGE MATLAB code for endChallenge.fig
%      ENDCHALLENGE, by itself, creates a new ENDCHALLENGE or raises the existing
%      singleton*.
%
%      H = ENDCHALLENGE returns the handle to a new ENDCHALLENGE or the handle to
%      the existing singleton*.
%
%      ENDCHALLENGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENDCHALLENGE.M with the given input arguments.
%
%      ENDCHALLENGE('Property','Value',...) creates a new ENDCHALLENGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before endChallenge_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to endChallenge_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help endChallenge

% Last Modified by GUIDE v2.5 28-Nov-2023 17:04:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @endChallenge_OpeningFcn, ...
                   'gui_OutputFcn',  @endChallenge_OutputFcn, ...
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


% --- Executes just before endChallenge is made visible.
function endChallenge_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to endChallenge (see VARARGIN)

% Define the window size
  set(gcf, 'units','normalized','outerposition',[0.32 0.32 0.34 0.45]);

filename = 'scores_PID.txt';

% Specify the delimiter
delimiter = ';'; % Assuming columns are separated by semicolon

% Specify the options for reading the file
opts = detectImportOptions(filename, 'Delimiter', delimiter);
opts.VariableNamesLine = 1; % Assuming the first row contains header

% Read the file as a table
data_table = readtable(filename, opts);

% Update data information on the screen
set(handles.scoreLevel1,'String', num2str(data_table{end,3})); 
set(handles.scoreLevel2,'String', num2str(data_table{end,4})); 
set(handles.scoreLevel3,'String', num2str(data_table{end,5})); 
set(handles.scoreFinal,'String', num2str(data_table{end,6})); 


% Calculate mean values of each column
mean_values = data_table{:,6}; % Calculate mean values for each column

% Sort the table based on mean values in ascending order
[~, sorted_indices] = sort(mean_values);

[~, Position] = max(sorted_indices);

% Display on the screen the player's position
set(handles.textPosition,'String', num2str(Position)); 


% Sort in acendent order
Scoreboard_table = table(data_table{:,1},data_table{:,6},'VariableNames',{'Player';'Total'});
Scoreboard_table = sortrows(Scoreboard_table,{'Total'},{'ascend'});

%Save as csv

writetable(Scoreboard_table,'Scoreboard.csv','Delimiter',';')


% Choose default command line output for endChallenge
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes endChallenge wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = endChallenge_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close
Main_Menu
