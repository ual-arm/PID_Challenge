function varargout = Instructions(varargin)
% INSTRUCTIONS MATLAB code for Instructions.fig
%      INSTRUCTIONS, by itself, creates a new INSTRUCTIONS or raises the existing
%      singleton*.
%
%      H = INSTRUCTIONS returns the handle to a new INSTRUCTIONS or the handle to
%      the existing singleton*.
%
%      INSTRUCTIONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INSTRUCTIONS.M with the given input arguments.
%
%      INSTRUCTIONS('Property','Value',...) creates a new INSTRUCTIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Instructions_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Instructions_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Instructions

% Last Modified by GUIDE v2.5 15-Oct-2023 22:10:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Instructions_OpeningFcn, ...
                   'gui_OutputFcn',  @Instructions_OutputFcn, ...
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


% --- Executes just before Instructions is made visible.
function Instructions_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Instructions (see VARARGIN)


currentPosition = get(hObject, 'Position');

newPosition = [40, 60, 200, 60];

% Define the window size
  set(gcf, 'units','normalized','outerposition',[0.05 0.05 0.95 0.95]);


% Choose default command line output for Instructions
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Insert LOGO Images
img_ifac = imread('./Figures/LOGO_IFAC.jpg');
img_pid  = imread('./Figures/LOGO_PID.png');
img_pideq = imread('./Figures/pideq_par.png');
img_buttons = imread('./Figures/buttons_prev.png');
img_J = imread('./Figures/J_prev.png');
img_matlab  = imread('./Figures/LOGO_Mathworks.jpg');
img_ual  = imread('./Figures/LOGO_UAL.png');

% Display the image in the Axes component
imshow(img_ifac, 'Parent', handles.ifacIm);  % handles.axes1 is the name of the Axes component
% Display the image in the Axes component
imshow(img_pid, 'Parent', handles.pidIm);  % handles.axes1 is the name of the Axes component
% Display the image in the Axes component
imshow(img_pideq, 'Parent', handles.pideqIm);  % handles.axes1 is the name of the Axes component
% Display the image in the Axes component
imshow(img_buttons, 'Parent', handles.button_prev);  % handles.axes1 is the name of the Axes component
% Display the image in the Axes component
imshow(img_J, 'Parent', handles.J_prev);  % handles.axes1 is the name of the Axes component
% Display the image in the Axes component
imshow(img_matlab, 'Parent', handles.mathworks);  % handles.axes1 is the name of the Axes component
% Display the image in the Axes component
imshow(img_ual, 'Parent', handles.ualimg);  % handles.axes1 is the name of the Axes component



% UIWAIT makes Instructions wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Instructions_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in yesButton.
function yesButton_Callback(hObject, eventdata, handles)
% hObject    handle to yesButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close all
Register


% --- Executes on button press in noButton.
function noButton_Callback(hObject, eventdata, handles)
% hObject    handle to noButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close all
Main_Menu
