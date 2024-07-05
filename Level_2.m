function varargout = Level_2(varargin)
% LEVEL_2 MATLAB code for Level_2.fig
%      LEVEL_2, by itself, creates a new LEVEL_2 or raises the existing
%      singleton*.
%
%      H = LEVEL_2 returns the handle to a new LEVEL_2 or the handle to
%      the existing singleton*.
%
%      LEVEL_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LEVEL_2.M with the given input arguments.
%
%      LEVEL_2('Property','Value',...) creates a new LEVEL_2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Level_2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Level_2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Level_2

% Last Modified by GUIDE v2.5 01-Dec-2023 19:09:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Level_2_OpeningFcn, ...
                   'gui_OutputFcn',  @Level_2_OutputFcn, ...
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


% --- Executes just before Level_2 is made visible.
function Level_2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Level_2 (see VARARGIN)

% Define the window size
  set(gcf, 'units','normalized','outerposition',[0.05 0.05 0.95 0.95]);

% Define flag to close the GUI
handles.flag = 0;

% Choose default command line output for Level_2
handles.output = hObject;

% Update the text field with the initial value
handles.KpSlider = -0.50; % Initial value
handles.TiSlider = 1/0.14;  % Initial value for the integral gain
handles.TdSlider = 1.0; % Initial value for the derivative gain
handles.cost = '-'; % Initial value for the derivative gain
handles.best = '-';


% Update the text field with the initial value
set(handles.costValue, 'String', handles.cost);
set(handles.bestCost, 'String', handles.best);
set(handles.KpValue_edit, 'String', num2str(handles.KpSlider));
set(handles.TiValue_edit, 'String', num2str(handles.TiSlider));
set(handles.TdValue_edit, 'String', num2str(handles.TdSlider));


% Starting counter
set(handles.countdownText, 'String', '45');

% Update limit values of the PID parameters
handles.Kpmax = handles.KpSlider + 0.4; handles.Kpmin =  handles.KpSlider - 1.5;
handles.Timax = handles.TiSlider + 1.5; handles.Timin =  handles.TiSlider - 1.5;
handles.Tdmax = handles.TdSlider + 1.5; handles.Tdmin =  handles.TdSlider - 1.5;

% Update Slider bar position from the initial value
set(handles.sliderKp, 'Value', (handles.KpSlider - handles.Kpmin)/(handles.Kpmax - handles.Kpmin));
set(handles.sliderTi, 'Value', (handles.TiSlider - handles.Timin)/(handles.Timax - handles.Timin));
set(handles.sliderTd, 'Value', (handles.TdSlider - handles.Tdmin)/(handles.Tdmax - handles.Tdmin));

% Display the maximum and minimum values
set(handles.Kpmin_text, 'String', round(handles.Kpmin,2));
set(handles.Kpmax_text, 'String', round(handles.Kpmax,2));
set(handles.Timin_text, 'String', round(handles.Timin,2));
set(handles.Timax_text, 'String', round(handles.Timax,2));
set(handles.Tdmin_text, 'String', round(handles.Tdmin,2));
set(handles.Tdmax_text, 'String', round(handles.Tdmax,2));

% Plot initial figures
hold(handles.outputAxes, 'off' )

    set(handles.outputAxes,'FontSize', 24, 'LineWidth', 2)
    grid(handles.outputAxes,'on')
    box(handles.outputAxes,'on')
    xlim(handles.outputAxes,[0  200])
    ylabel(handles.outputAxes, 'y [-]');
    
    grid(handles.inputAxes,'on')
    box(handles.inputAxes,'on')
    set(handles.inputAxes,'FontSize',24, 'LineWidth', 2)
    xlim([0  200])
    xlabel(handles.inputAxes, 'Time [-]');
    ylabel(handles.inputAxes, 'u [-]');
   

% Insert LOGO Images
img_pideq = imread('./Figures/pideq.png');
img_arm  = imread('./Figures/LOGO_ARM.jpg');
img_ual  = imread('./Figures/LOGO_UAL.png');
img_matlab  = imread('./Figures/LOGO_Mathworks.jpg');

% Display the image in the Axes component
imshow(img_pideq, 'Parent', handles.pideq);  % handles.axes1 is the name of the Axes component
imshow(img_ual, 'Parent', handles.logoUAL);  % handles.axes1 is the name of the Axes component
imshow(img_arm, 'Parent', handles.logoARM);  % handles.axes1 is the name of the Axes component
imshow(img_matlab, 'Parent', handles.mathworks);  % handles.axes1 is the name of the Axes component

% Delete and stop existing timers
try
stop(timerfindall)
catch
end
try
delete(timerfindall)
catch
end


% Create and configure a timer object
handles.timer = timer('StartDelay', 1,...
        'ExecutionMode', 'fixedRate', ...
        'Period', 1, ...  % Update the time display every 1 second
        'TimerFcn', {@updateTimerDisplay, hObject}, ...
        'StopFcn', {@closeEndTimer, hObject}); 
    

handles.counter = 0;   
    
% Save the updated handles structure
guidata(hObject, handles);


% UIWAIT makes Level_2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Level_2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Get default command line output from handles structure
varargout{1} = handles.output;

warning('off')

% Open the Simulink model and obtain its handle
load_system('Level_2_sys');

% Set the PID block parameters
pidBlockName = 'PID_Controller'; % Replace with the actual block name
Kp = handles.KpSlider; % Example value for the proportional gain
Ti = handles.TiSlider; % Example value for the integral gain
Td = handles.TdSlider; % Example value for the derivative gain

set_param([gcs '/' pidBlockName], 'P', num2str(Kp));
set_param([gcs '/' pidBlockName], 'I', num2str(1/Ti));
set_param([gcs '/' pidBlockName], 'D', num2str(Td));

t_final = 200;

sim('Level_2_sys.slx',t_final)

hold(handles.outputAxes, 'off' )

for k=1:40:size(ref.time,1)
% Plot outputs
    plot(handles.outputAxes,ref.time(1:k),ref.signals.values(1:k),'r--','LineWidth',4)
    hold(handles.outputAxes, 'on' )
    plot(handles.outputAxes,y.time(1:k),y.signals.values(1:k),'k','LineWidth',4)
    set(handles.outputAxes,'FontSize', 24, 'LineWidth', 2)
    grid(handles.outputAxes,'on')
    box(handles.outputAxes,'on')
    xlim(handles.outputAxes,[0  ref.time(end)])
    ylabel(handles.outputAxes, 'y [-]');

% Plot inputs
    plot(handles.inputAxes,u.time(1:k),u.signals.values(1:k),'k','LineWidth',4)
    grid(handles.inputAxes,'on')
    box(handles.inputAxes,'on')
    set(handles.inputAxes,'FontSize',24, 'LineWidth', 2)
    xlim(handles.inputAxes,[0  u.time(end)])
    ylim(handles.inputAxes,[-5  5])
    xlabel(handles.inputAxes, 'Time [-]');
    ylabel(handles.inputAxes, 'u [-]');
    
    pause(0.010)
end

hold(handles.outputAxes, 'off' )

% Start the timer
start(handles.timer)

handles.counter = tic; 

% Save the updated handles structure
guidata(hObject, handles);


% --- Executes on slider movement.
function sliderKp_Callback(hObject, eventdata, handles)
% hObject    handle to sliderKp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

persistent check % Shared with all calls of pushbutton1_Callback.
 % Count number of clicks. If there are no recent clicks, execute the single
 % click action. If there is a recent click, ignore new clicks.

 % Count number of clicks. If there are no recent clicks, execute the single
 % click action. If there is a recent click, ignore new clicks.
 if isempty(check)
     check = 1;
 else
     % Ends Callback execution if pushbutton is clicked again before 
     % Callback has completed.
     return
 end

% Read the position of the Slider
handles.KpSlider = get(hObject,'Value');

% Convert the position of the slider in Kp value
KpVal = round(handles.KpSlider*(handles.Kpmax-handles.Kpmin) + handles.Kpmin,4);

% Update limit values of the PID parameters
if KpVal == 0
    handles.Kpmax = KpVal+2; handles.Kpmin =  KpVal-2;
else
    handles.Kpmax = KpVal*1.5; handles.Kpmin =  KpVal*0.5;
end

if KpVal<0
    [handles.Kpmin, handles.Kpmax] = swap(handles.Kpmax,handles.Kpmin);
end
    
% Update Slider bar position from the actual value
set(handles.sliderKp, 'Value', 0.5);

% Update the text value of Kp
set(handles.KpValue_edit, 'String', num2str(KpVal));

% Display the maximum and minimum values
set(handles.Kpmin_text, 'String', round(handles.Kpmin,2));
set(handles.Kpmax_text, 'String', round(handles.Kpmax,2));

% Update handles structure
guidata(hObject, handles);

Simulation(hObject, eventdata, handles)

% Resets the 'check' variable for additional use of the Callback function
 check = [];


% --- Executes during object creation, after setting all properties.
function sliderKp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderKp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderTi_Callback(hObject, eventdata, handles)
% hObject    handle to sliderTi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


persistent check % Shared with all calls of pushbutton1_Callback.
 % Count number of clicks. If there are no recent clicks, execute the single
 % click action. If there is a recent click, ignore new clicks.

 % Count number of clicks. If there are no recent clicks, execute the single
 % click action. If there is a recent click, ignore new clicks.
 if isempty(check)
     check = 1;
 else
     % Ends Callback execution if pushbutton is clicked again before 
     % Callback has completed.
     return
 end

% Read the position of the Slider
handles.TiSlider = get(hObject,'Value');

% Convert the position of the slider in Kp value
TiVal = round(handles.TiSlider*(handles.Timax-handles.Timin) + handles.Timin,4);

if TiVal <= 0.01
    TiVal = 0.000001;
    % Update limit values of the PID parameters
    handles.Timax = TiVal+1; handles.Timin =  TiVal/2;
else
    % Update limit values of the PID parameters
    handles.Timax = TiVal*1.5; handles.Timin =  TiVal*0.5;
end

if handles.Timin <= 0
    handles.Timin = 0.00001;
end


% Update Slider bar position from the actual value
set(handles.sliderTi, 'Value', 0.5);


% Update the text value of Kp
set(handles.TiValue_edit, 'String', num2str(TiVal));

% Display the maximum and minimum values
set(handles.Timin_text, 'String', round(handles.Timin,2));
set(handles.Timax_text, 'String', round(handles.Timax,2));

% Update handles structure
guidata(hObject, handles);

Simulation(hObject, eventdata, handles)

% Resets the 'check' variable for additional use of the Callback function
 check = [];

% --- Executes during object creation, after setting all properties.
function sliderTi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderTi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderTd_Callback(hObject, eventdata, handles)
% hObject    handle to sliderTd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

persistent check

% Count number of clicks. If there are no recent clicks, execute the single
 % click action. If there is a recent click, ignore new clicks.
 if isempty(check)
     check = 1;
 else
     % Ends Callback execution if pushbutton is clicked again before 
     % Callback has completed.
     return
 end


% Read the position of the Slider
handles.TdSlider = get(hObject,'Value');

% Convert the position of the slider in Kp value
TdVal = round(handles.TdSlider*(handles.Tdmax-handles.Tdmin) + handles.Tdmin,4);

% Update limit values of the PID parameters
if TdVal == 0
    handles.Tdmax = TdVal+2; handles.Tdmin =  TdVal-2;
else
    handles.Tdmax = TdVal*1.5; handles.Tdmin =  TdVal*0.5;
end

if TdVal<0
    [handles.Tdmin, handles.Tdmax] = swap(handles.Tdmax,handles.Tdmin);
end

% Update Slider bar position from the actual value
set(handles.sliderTd, 'Value', 0.5);

% Update the text value of Td
set(handles.TdValue_edit, 'String', num2str(TdVal));

% Display maximum and minimum values
set(handles.Tdmin_text, 'String', round(handles.Tdmin,2));
set(handles.Tdmax_text, 'String', round(handles.Tdmax,2));

% Update handles structure
guidata(hObject, handles);

Simulation(hObject, eventdata, handles)

% Resets the 'check' variable for additional use of the Callback function
 check = [];

% --- Executes during object creation, after setting all properties.
function sliderTd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderTd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in TestButton.
function Simulation(hObject, eventdata, handles)
% hObject    handle to TestButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

persistent check % Shared with all calls of pushbutton1_Callback.
 % Count number of clicks. If there are no recent clicks, execute the single
 % click action. If there is a recent click, ignore new clicks.

 % Count number of clicks. If there are no recent clicks, execute the single
 % click action. If there is a recent click, ignore new clicks.
 if isempty(check)
     check = 1;
 else
     % Ends Callback execution if pushbutton is clicked again before 
     % Callback has completed.
     return
 end


warning('off')


% Open the Simulink model and obtain its handle
load_system('Level_2_sys');

% Set the PID block parameters
pidBlockName = 'PID_Controller'; % Replace with the actual block name

Kp = str2double(handles.KpValue_edit.String); % Example value for the proportional gain
Ti = str2double(handles.TiValue_edit.String); % Example value for the integral gain
Td = str2double(handles.TdValue_edit.String); % Example value for the derivative gain

set_param([gcs '/' pidBlockName], 'P', num2str(Kp));
set_param([gcs '/' pidBlockName], 'I', num2str(1/Ti));
set_param([gcs '/' pidBlockName], 'D', num2str(Td));


t_final = 200;

try
    sim('Level_2_sys.slx',t_final)
catch
%     CreateStruct.WindowStyle = 'modal'; 
%     CreateStruct.Interpreter = 'tex';
%     erBox = msgbox('\fontsize{20} Closed-loop Unsolvable. Try again.','Error','error',CreateStruct);
%     uiwait(erBox)
end

if ~isvalid(handles.outputAxes) 
    return
end


try 
    for k=1:50:size(ref.time,1)
    % Plot outputs
        plot(handles.outputAxes,ref.time(1:k),ref.signals.values(1:k),'r--','LineWidth',4)
        hold(handles.outputAxes, 'on' )
        plot(handles.outputAxes,y.time(1:k),y.signals.values(1:k),'k','LineWidth',4)
        set(handles.outputAxes,'FontSize', 24, 'LineWidth', 2)
        grid(handles.outputAxes,'on')
        box(handles.outputAxes,'on')
        xlim(handles.outputAxes,[0  ref.time(end)])
        ylim(handles.outputAxes,[-0.5  2.5])
        ylabel(handles.outputAxes, 'y [-]');

    % Plot inputs
        plot(handles.inputAxes,u.time(1:k),u.signals.values(1:k),'k','LineWidth',4)
        grid(handles.inputAxes,'on')
        box(handles.inputAxes,'on')
        set(handles.inputAxes,'FontSize',24, 'LineWidth', 2)
        xlim(handles.inputAxes,[0  u.time(end)])
        ylim(handles.inputAxes,[-5  5])
        xlabel(handles.inputAxes, 'Time [-]');
        ylabel(handles.inputAxes, 'u [-]');

        pause(0.010)
    end
catch
     
    return
end

IAE = sum(abs(y.signals.values - ref.signals.values));
SCI = sum(abs(diff(u.signals.values)));

% Define the current cost value
J = round(IAE + SCI,2);
set(handles.costValue,'String', num2str(J,'%5.2f'))

% Define the best cost value

if handles.bestCost.String == '-'
    set(handles.bestCost,'String', num2str(J,'%5.2f'))
end
if J < str2double(handles.bestCost.String)
    set(handles.bestCost,'String', num2str(J,'%5.2f'))
    handles.best = J;
end

hold(handles.outputAxes, 'off' )

check = [];

% --- Executes on button press in TestButton.
function TestButton_Callback(hObject, eventdata, handles)
% hObject    handle to TestButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

persistent check % Shared with all calls of pushbutton1_Callback.
 % Count number of clicks. If there are no recent clicks, execute the single
 % click action. If there is a recent click, ignore new clicks.

 % Count number of clicks. If there are no recent clicks, execute the single
 % click action. If there is a recent click, ignore new clicks.
 if isempty(check)
     check = 1;
 else
     % Ends Callback execution if pushbutton is clicked again before 
     % Callback has completed.
     return
 end


warning('off')


% Open the Simulink model and obtain its handle
load_system('Level_2_sys');

% Set the PID block parameters
pidBlockName = 'PID_Controller'; % Replace with the actual block name

% Update the text field with the initial value
handles.KpSlider = -0.50; % Initial value
handles.TiSlider = 1/0.14;  % Initial value for the integral gain
handles.TdSlider = 1.0; % Initial value for the derivative gain

set_param([gcs '/' pidBlockName], 'P', num2str(handles.KpSlider));
set_param([gcs '/' pidBlockName], 'I', num2str(1/handles.TiSlider));
set_param([gcs '/' pidBlockName], 'D', num2str(handles.TdSlider));


t_final = 200;

try
    sim('Level_2_sys.slx',t_final)
catch
%     CreateStruct.WindowStyle = 'modal'; 
%     CreateStruct.Interpreter = 'tex';
%     erBox = msgbox('\fontsize{20} Closed-loop Unsolvable. Try again.','Error','error',CreateStruct);
%     uiwait(erBox)
end

if ~isvalid(handles.outputAxes) 
    return
end

try 
    for k=1:50:size(ref.time,1)
    % Plot outputs
        plot(handles.outputAxes,ref.time(1:k),ref.signals.values(1:k),'r--','LineWidth',4)
        hold(handles.outputAxes, 'on' )
        plot(handles.outputAxes,y.time(1:k),y.signals.values(1:k),'k','LineWidth',4)
        set(handles.outputAxes,'FontSize', 24, 'LineWidth', 2)
        grid(handles.outputAxes,'on')
        box(handles.outputAxes,'on')
        xlim(handles.outputAxes,[0  ref.time(end)])
        ylim(handles.outputAxes,[-0.5  2.5])
        ylabel(handles.outputAxes, 'y [-]');

    % Plot inputs
        plot(handles.inputAxes,u.time(1:k),u.signals.values(1:k),'k','LineWidth',4)
        grid(handles.inputAxes,'on')
        box(handles.inputAxes,'on')
        set(handles.inputAxes,'FontSize',24, 'LineWidth', 2)
        xlim(handles.inputAxes,[0  u.time(end)])
        ylim(handles.inputAxes,[-5  5])
        xlabel(handles.inputAxes, 'Time [-]');
        ylabel(handles.inputAxes, 'u [-]');

        pause(0.010)
    end
catch
     
    return
end

handles.cost = '-'; % Initial value for the derivative gain

% Update the text field with the initial value
set(handles.costValue, 'String', handles.cost);
set(handles.KpValue_edit, 'String', num2str(handles.KpSlider));
set(handles.TiValue_edit, 'String', num2str(handles.TiSlider));
set(handles.TdValue_edit, 'String', num2str(handles.TdSlider));


% Update limit values of the PID parameters
handles.Kpmax = handles.KpSlider + 0.4; handles.Kpmin =  handles.KpSlider - 1.5;
handles.Timax = handles.TiSlider + 1.5; handles.Timin =  handles.TiSlider - 1.5;
handles.Tdmax = handles.TdSlider + 1.5; handles.Tdmin =  handles.TdSlider - 1.5;

% Update Slider bar position from the initial value
set(handles.sliderKp, 'Value', (handles.KpSlider - handles.Kpmin)/(handles.Kpmax - handles.Kpmin));
set(handles.sliderTi, 'Value', (handles.TiSlider - handles.Timin)/(handles.Timax - handles.Timin));
set(handles.sliderTd, 'Value', (handles.TdSlider - handles.Tdmin)/(handles.Tdmax - handles.Tdmin));

% Display the maximum and minimum values
set(handles.Kpmin_text, 'String', round(handles.Kpmin,2));
set(handles.Kpmax_text, 'String', round(handles.Kpmax,2));
set(handles.Timin_text, 'String', round(handles.Timin,2));
set(handles.Timax_text, 'String', round(handles.Timax,2));
set(handles.Tdmin_text, 'String', round(handles.Tdmin,2));
set(handles.Tdmax_text, 'String', round(handles.Tdmax,2));


hold(handles.outputAxes, 'off' )

check = [];


    
% Callback for updating the timer display
function updateTimerDisplay(~, ~, hObject)

persistent check

handles = guidata(hObject);

% Get the remaining time from the timer
timer = toc(handles.counter);

% Get the remaining time from the timer
elapsedSeconds = round(45 - timer);

if elapsedSeconds <= 0
    set(handles.countdownText, 'String', '0');
   
    handles.flag = 1;
        
    % Update handles structure
    guidata(hObject, handles);
    
    pause(1)
    
    %Stop timer
    stop(handles.timer);

   return

end

% Display the remaining time in the "Text" component
set(handles.countdownText, 'String', num2str(elapsedSeconds));



function closeEndTimer(~, ~, hObject)

    handles = guidata(hObject);
    
    if handles.flag == 1
        bestCost = handles.bestCost.String;
        try
        close_system('Level_2_sys',0)
        catch
        end
        %bdclose
        close(hObject)
        uiwait(Level_2_end(bestCost))
    end


function KpValue_edit_Callback(hObject, eventdata, handles)
% hObject    handle to KpValue_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of KpValue_edit as text
%        str2double(get(hObject,'String')) returns contents of KpValue_edit as a double

handles.KpVal_EditText = str2double(get(hObject,'String'));

% Convert the position of the slider in Kp value
KpVal = handles.KpVal_EditText;

if isnan(handles.KpVal_EditText)
    CreateStruct.Interpreter = 'tex';
    CreateStruct.WindowStyle = 'modal';
    msgbox('\fontsize{15} The parameter must be a number.',CreateStruct);
    % Keep the previous value
    handles.KpVal_EditText = handles.KpValue_edit;
    % Update handles structure
    guidata(hObject, handles);
    return
end


% Update limit values of the PID parameters
if KpVal == 0
    handles.Kpmax = KpVal+2; handles.Kpmin =  KpVal-2;
else
    handles.Kpmax = KpVal*1.5; handles.Kpmin =  KpVal*0.5;
end

if KpVal<0
    [handles.Kpmin, handles.Kpmax] = swap(handles.Kpmax,handles.Kpmin);
end

% Update Slider bar position from the actual value
set(handles.sliderKp, 'Value', 0.5);

% Update the text value of Kp
set(handles.KpValue_edit, 'String', num2str(KpVal));

% Display the maximum and minimum values
set(handles.Kpmin_text, 'String', round(handles.Kpmin,2));
set(handles.Kpmax_text, 'String', round(handles.Kpmax,2));

% Update handles structure
guidata(hObject, handles);

Simulation(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function KpValue_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to KpValue_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function TiValue_edit_Callback(hObject, eventdata, handles)
% hObject    handle to TiValue_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TiValue_edit as text
%        str2double(get(hObject,'String')) returns contents of TiValue_edit as a double
handles.TiVal_EditText = str2double(get(hObject,'String'));

if isnan(handles.TiVal_EditText)
    CreateStruct.Interpreter = 'tex';
    CreateStruct.WindowStyle = 'modal';
    msgbox('\fontsize{15} The parameter must be a number.',CreateStruct);
    % Keep the previous value
    handles.TiVal_EditText = handles.TiValue_edit;
    % Update handles structure
    guidata(hObject, handles);
    return
end


% Convert the position of the slider in Kp value
TiVal = handles.TiVal_EditText;

if TiVal <= 0
    TiVal = 0.00001;
    % Update limit values of the PID parameters
    handles.Timax = TiVal+2; handles.Timin =  TiVal-2;
else
    % Update limit values of the PID parameters
    handles.Timax = TiVal*1.5; handles.Timin =  TiVal*0.5;
end

if handles.Timin <= 0
    handles.Timin = 0.00001;
end

% Update Slider bar position from the actual value
set(handles.sliderTi, 'Value', 0.5);


% Update the text value of Kp
set(handles.TiValue_edit, 'String', num2str(TiVal));

% Display the maximum and minimum values
set(handles.Timin_text, 'String', round(handles.Timin,2));
set(handles.Timax_text, 'String', round(handles.Timax,2));

% Update handles structure
guidata(hObject, handles);

Simulation(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function TiValue_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TiValue_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function TdValue_edit_Callback(hObject, eventdata, handles)
% hObject    handle to TdValue_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TdValue_edit as text
%        str2double(get(hObject,'String')) returns contents of TdValue_edit as a double
handles.TdVal_EditText = str2double(get(hObject,'String'));

if isnan(handles.TdVal_EditText)
    CreateStruct.Interpreter = 'tex';
    CreateStruct.WindowStyle = 'modal';
    msgbox('\fontsize{15} The parameter must be a number.',CreateStruct);
    % Keep the previous value
    handles.TdVal_EditText = handles.TdValue_edit;
    % Update handles structure
    guidata(hObject, handles);
    return
end

% Convert the position of the slider in Kp value
TdVal = handles.TdVal_EditText;


if TdVal == 0
    % Update limit values of the PID parameters
    handles.Tdmax = TdVal+2; handles.Tdmin =  TdVal-2;
else
    % Update limit values of the PID parameters
    handles.Tdmax = TdVal*1.5; handles.Tdmin =  TdVal*0.5;
end

if TdVal<0
    [handles.Tdmin, handles.Tdmax] = swap(handles.Tdmax,handles.Tdmin);
end

% Update Slider bar position from the actual value
set(handles.sliderTd, 'Value', 0.5);

% Update the text value of Kp
set(handles.TdValue_edit, 'String', num2str(TdVal));

% Display the maximum and minimum values
set(handles.Tdmin_text, 'String', round(handles.Tdmin,2));
set(handles.Tdmax_text, 'String', round(handles.Tdmax,2));

% Update handles structure
guidata(hObject, handles);

Simulation(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function TdValue_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TdValue_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function [bi, ai] = swap(a, b)
    %nothing
   ai=b;
   bi=a;
