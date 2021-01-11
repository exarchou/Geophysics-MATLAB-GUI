function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 28-Dec-2020 17:36:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no console_output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line console_output for GUI
handles.console_output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning console_output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line console_output from handles structure
varargout{1} = handles.console_output;



function L_Callback(hObject, eventdata, handles)
% hObject    handle to L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of L as text
%        str2double(get(hObject,'String')) returns contents of L as a double


% --- Executes during object creation, after setting all properties.
function L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a_Callback(hObject, eventdata, handles)
% hObject    handle to a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a as text
%        str2double(get(hObject,'String')) returns contents of a as a double


% --- Executes during object creation, after setting all properties.
function a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function f_Callback(hObject, eventdata, handles)
% hObject    handle to f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of f as text
%        str2double(get(hObject,'String')) returns contents of f as a double


% --- Executes during object creation, after setting all properties.
function f_CreateFcn(hObject, eventdata, handles)
% hObject    handle to f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in apply_button.
function apply_button_Callback(hObject, eventdata, handles)
% hObject    handle to apply_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    clc;
    console_string = '';
    
    L = str2double(get(handles.L, 'string'));
    a = str2double(get(handles.a, 'string'));
    f = str2double(get(handles.f, 'string'));
    
    %% Initializations
    Io = 1;
    w = 2*pi*f;
    t = linspace(0, 1, 1000);
    I = Io * exp(1i*w*t);
    k = @(R,z) ( R.^3 ./ (((R.^2 + (L/2 - z).^2).^(1.5)).*((R.^2 + (L/2 + z).^2).^(1.5))));
    k_int = integral2(k, 0, Inf, 0, Inf);


    %% Data Base with materials
    materials = cell(11,3);
    % Material                           Permeability m                       Conductivity sigma
    materials{1,1}  = "Silicon(Si)";     materials{1,2}  = 1;                 materials{1,3}  = 1.56*10^-3;
    materials{2,1}  = "Aluminium(Al)";   materials{2,2}  = 1.25*10^(-6);      materials{2,3}  = 3.5*10^7;
    materials{3,1}  = "Iron(Fe)";        materials{3,2}  = 6.3*10^(-3);       materials{3,3}  = 1*10^7;
    materials{4,1}  = "Calcium(Ca)";     materials{4,2}  = 1;                 materials{4,3}  = 2.9*10^7;
    materials{5,1}  = "Sodium(Na)";      materials{5,2}  = 1;                 materials{5,3}  = 2.1*10^7;
    materials{6,1}  = "Potassium(K)";    materials{6,2}  = 1;                 materials{6,3}  = 1.4*10^7;
    materials{7,1}  = "Magnesium(Mg)";   materials{7,2}  = 1;                 materials{7,3}  = 2.2727*10^7;  

    materials{8,1}  = "Titanium(Ti)";    materials{8,2}  = 1;                 materials{8,3}  = 2.38*10^6;
    materials{9,1}  = "Manganese(Mn)";   materials{9,2}  = 1;                 materials{9,3}  = 6.94*10^5;
    materials{10,1} = "Cooper(Cu)";      materials{10,2} = 1.25*10^(-6);      materials{10,3} = 5.96*10^7;

    materials{11,1} = "Air";             materials{11,2}  = 1;                materials{11,3}  = 1;



    %% x ground function
    x = zeros(1,1700);
    
    rand_int = randi(10);
    for i = 1:200
        
        if mod(i,200) <= 100
            x(i) = 11;
        else
            x(i) = rand_int;
        end
    end

    rand_int = randi(10);
    for i = 201:400
        if mod(i,200) <= 100
            x(i) = 11;
        else
            x(i) = rand_int;
        end
    end

    rand_int = randi(10);
    for i = 401:600
        if mod(i,200) <= 100
            x(i) = 11;
        else
            x(i) = rand_int;
        end
    end

    rand_int = randi(10);
    for i = 601:800
        if mod(i,200) <= 100
            x(i) = 11;
        else
            x(i) = rand_int;
        end
    end

    rand_int = randi(10);
    for i = 801:1000
        if mod(i,200) <= 100
            x(i) = 11;
        else
            x(i) = rand_int;
        end
    end

    rand_int = randi(10);
    for i = 1001:1200
        if mod(i,200) <= 100
            x(i) = 11;
        else
            x(i) = rand_int;
        end
    end

    rand_int = randi(10);
    for i = 1201:1400
        if mod(i,200) <= 100
            x(i) = 11;
        else
            x(i) = rand_int;
        end
    end

    rand_int = randi(10);
    for i = 1401:1700
        if mod(i,200) <= 100
            x(i) = 11;
        elseif mod(i,200) <= 200
            x(i) = rand_int;
        else
            x(i) = 11;
        end
    end



    %% Simulation
    resistivities = zeros(1,length(x));
    estimated_elements = zeros(1,length(x));
    errors = zeros(1,length(x));

    for i = 1:length(x)
        % Forward
        m = materials{x(i),2};
        s = materials{x(i),3};
        et = (1i*w*m*pi*a^4*I)/(2*(a^2+L^2)^(3/2))-(s*m^2*I*pi*a^4*w^2*(1/8))*k_int;

        % Backward
        s_hat = ((4/(m*w*(a^2+L^2)^(3/2)))-(8*mean(abs(et)))/(m^2*w^2*pi*a^4*mean(abs(I)))) / k_int;
        s_hat = abs(s_hat);


        % Search
        min = abs(s_hat - materials{1,3});
        min_index = 1;
        for j = 2:length(materials)
            distance = abs(s_hat - materials{j,3});
            if distance < min
                min = distance;
                min_index = j;
            end
        end

        estimated_elements(i) = min_index;
        errors(i) = min;
        resistivities(i) = 1/s_hat;

        if mod(i,100) == 1 && estimated_elements(i) ~= 11
            fprintf("Found " + materials(estimated_elements(i),1) + " between %d00 and %d00 cm.\n", fix(i/100), fix(i/100)+1);
            temp_string = sprintf("Found " + materials(estimated_elements(i),1) + " between %d00 and %d00 cm.\n", fix(i/100), fix(i/100)+1);
            console_string = console_string + temp_string;
        end

    end
    
    % set(handles.console_output, 'string', console_string);
    handles.x = x;
    handles.resistivities = resistivities;
    handles.materials = materials;
    
    handles.my_console.String = console_string;
    
    
    guidata(hObject, handles);


% --- Executes on button press in ground_function_button.
function ground_function_button_Callback(hObject, eventdata, handles)
% hObject    handle to ground_function_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    x = handles.x;
    materials = handles.materials;
    
    plot(x, 'LineStyle', '-.', 'LineWidth', 0.25, 'Marker', 'o')
    xlabel("Depth (cm)");
    yticklabels({materials{1,1},materials{2,1},materials{3,1},materials{4,1},materials{5,1},materials{6,1},materials{7,1},materials{8,1},materials{9,1},materials{10,1},materials{11,1}})
    ylim([0.5 11.5])
    ytickangle(45)
    view([90 90])
    title("Elements of Ground");


% --- Executes on button press in resistivities_button.
function resistivities_button_Callback(hObject, eventdata, handles)
% hObject    handle to resistivities_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    resistivities = handles.resistivities;
    
    plot(resistivities, 'LineStyle', '-.', 'LineWidth', 0.25, 'Marker', 'o');
    set(gca, 'YScale', 'log')
    xlabel("Depth (cm)");
    ylabel("Resistivity (Ohm m)");
    view([90 90])
    title("Calculated Resistivities");


% --- Executes during object creation, after setting all properties.
function console_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to console_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over console_output.
function console_output_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to console_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)