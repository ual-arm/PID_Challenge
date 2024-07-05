function varargout = Main_Menu(varargin)
% MAIN_MENU MATLAB code for Main_Menu.fig
%      MAIN_MENU, by itself, creates a new MAIN_MENU or raises the existing
%      singleton*.
%
%      H = MAIN_MENU returns the handle to a new MAIN_MENU or the handle to
%      the existing singleton*
%
%      MAIN_MENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_MENU.M with the given input arguments.
%
%      MAIN_MENU('Property','Value',...) creates a new MAIN_MENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Main_Menu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Main_Menu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Main_Menu

% Last Modified by GUIDE v2.5 14-Oct-2023 00:19:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main_Menu_OpeningFcn, ...
                   'gui_OutputFcn',  @Main_Menu_OutputFcn, ...
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


% --- Executes just before Main_Menu is made visible.
function Main_Menu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Main_Menu (see VARARGIN)

bdclose

% Define the window size
  set(gcf, 'units','normalized','outerposition',[0.05 0.05 0.95 0.95]);

% Initialize handles and user-defined application data
handles.isRunning = true;

% Choose default command line output for Main_Menu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Insert LOGO Images
img_ifac = imread('./Figures/LOGO_IFAC.jpg');
img_arm  = imread('./Figures/LOGO_ARM.jpg');
img_ual  = imread('./Figures/LOGO_UAL.png');
img_pid  = imread('./Figures/LOGO_PID.png');
img_matlab  = imread('./Figures/LOGO_Mathworks.jpg');

% Display the image in the Axes component
imshow(img_ifac, 'Parent', handles.ifac);  % handles.axes1 is the name of the Axes component
% Display the image in the Axes component
imshow(img_arm, 'Parent', handles.arm);  % handles.axes1 is the name of the Axes component
% Display the image in the Axes component
imshow(img_ual, 'Parent', handles.ual);  % handles.axes1 is the name of the Axes component
% Display the image in the Axes component
imshow(img_pid, 'Parent', handles.pid);  % handles.axes1 is the name of the Axes component
% Display the image in the Axes component
imshow(img_matlab, 'Parent', handles.mathworks);  % handles.axes1 is the name of the Axes component


% UIWAIT makes Main_Menu wait for user response (see UIRESUME)
% uiwait(handles.Main_menu);


% --- Outputs from this function are returned to the command line.
function varargout = Main_Menu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Set up a user-defined variable to store the button press information
setappdata(gcf, 'ButtonPressed', '');

guidata(hObject, handles);

% Get default command line output from handles structure
varargout{1} = handles.output;

% Creat a plot a second order system
s=tf('s');
G = 1^2/(s^2 + 2*0.1*1*s + 1);
t = 1:0.1:50;
u = ones(1,size(t,2));

warning('off')
plot(handles.response_graph,0,0,'LineWidth',4)
ylim(handles.response_graph,[0 2])
xlim(handles.response_graph,[0 t(end)])
set(handles.response_graph,'FontSize', 0.001)

while handles.isRunning 
    for i=2:size(t,2)

       % Check if a button was pressed
        buttonPressed = getappdata(gcf, 'ButtonPressed');
      
       % If button was pressed , break the loop and open the new window
       if ~isempty(buttonPressed)     
        
            handles.isRunning = false;
            close Main_Menu
            Instructions
            
            
            return
       end
        try
            y = lsim(G,u(1:i),t(1:i));
            plot(handles.response_graph,t(1:i),y(1:i),'LineWidth',4);
            ylim(handles.response_graph,[0 2])
            xlim(handles.response_graph,[0 t(end)])
            pause(0.005)
            grid off;
            box off;
            set(handles.response_graph, 'XTick', [], 'YTick', []);
            set(handles.response_graph, 'XTickLabel', [], 'YTickLabel', [], 'FontSize', 0.001);
        catch
            close
            return
        end
    end
end


% --- Executes on button press in Start_button.
function Start_button_Callback(hObject, eventdata, handles)
% hObject    handle to Start_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

setappdata(gcf, 'ButtonPressed', get(hObject, 'Tag'));
