function varargout = Data_Analysis_Tool_DIANRacing_canoe(varargin)
% DATA_ANALYSIS_TOOL_DIANRACING MATLAB code for Data_Analysis_Tool_DIANRacing.fig
%      DATA_ANALYSIS_TOOL_DIANRACING, by itself, creates a new DATA_ANALYSIS_TOOL_DIANRACING or raises the existing
%      singleton*.
%
%      H = DATA_ANALYSIS_TOOL_DIANRACING returns the handle to a new DATA_ANALYSIS_TOOL_DIANRACING or the handle to
%      the existing singleton*.
%
%      DATA_ANALYSIS_TOOL_DIANRACING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DATA_ANALYSIS_TOOL_DIANRACING.M with the given input arguments.
%
%      DATA_ANALYSIS_TOOL_DIANRACING('Property','Value',...) creates a new DATA_ANALYSIS_TOOL_DIANRACING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Data_Analysis_Tool_DIANRacing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Data_Analysis_Tool_DIANRacing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Data_Analysis_Tool_DIANRacing

% Last Modified by GUIDE v2.5 05-Sep-2018 21:25:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Data_Analysis_Tool_DIANRacing_OpeningFcn, ...
                   'gui_OutputFcn',  @Data_Analysis_Tool_DIANRacing_OutputFcn, ...
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


% --- Executes just before Data_Analysis_Tool_DIANRacing is made visible.
function Data_Analysis_Tool_DIANRacing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Data_Analysis_Tool_DIANRacing (see VARARGIN)

% Choose default command line output for Data_Analysis_Tool_DIANRacing
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Data_Analysis_Tool_DIANRacing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Data_Analysis_Tool_DIANRacing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in FileSelection.
function FileSelection_Callback(hObject, eventdata, handles)
[filename,filepath]=uigetfile('*.mat','请选择试车数据');
file=fullfile(filepath,filename);
set(handles.FileDirectory,'String',file);
load(file);
vars=whos;

n=0;
for i=1:length(vars)
    try %看是否是CAN信号
        eval([vars(i).name,'.unit;'])
        n=n+1;
        List{n}=vars(i).name;
    catch
    end
end
set(handles.ParaList,'String',List);

% hObject    handle to FileSelection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in SelectedParaList.
function SelectedParaList_Callback(hObject, eventdata, handles)
% hObject    handle to SelectedParaList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns SelectedParaList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SelectedParaList


% --- Executes during object creation, after setting all properties.
function SelectedParaList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SelectedParaList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ParaList.
function ParaList_Callback(hObject, eventdata, handles)
% hObject    handle to ParaList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ParaList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ParaList


% --- Executes during object creation, after setting all properties.
function ParaList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ParaList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PlotButton.
function PlotButton_Callback(hObject, eventdata, handles)
%加载数据
file=get(handles.FileDirectory,'String');
load(file);
%从选择模块那里得到选择的变量
String=get(handles.ParaList,'String');
Index=get(handles.ParaList,'Value');
ParaName=String{Index};
%对SelectedParaList的数据进行处理
List=get(handles.SelectedParaList,'String');
List{length(List)+1}=ParaName;
set(handles.SelectedParaList,'String',List);

for i=1:length(List)
index=findstr(List{i},'_');
tmp=List{i};
Name{i}=tmp(index(end-1)+1:index(end)-1);
end
Name=strrep(Name,'_',' ');

axes(handles.Plot1)
x=eval([ParaName,'(:,1)']);
x_Unit={'s'};
y=eval([ParaName,'(:,2)']);
y_Unit=eval([ParaName,'.unit;']);
plot(x,y)
hold on
legend(Name,-1)

% hObject    handle to PlotButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ClearPlot.
function ClearPlot_Callback(hObject, eventdata, handles)
axes(handles.Plot1)
cla reset
set(handles.SelectedParaList,'String','')
% hObject    handle to ClearPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function Plot1_CreateFcn(hObject, eventdata, handles)
% set(hObject,'toolbar','figure') 
% hObject    handle to Plot1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate Plot1


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in SelectedParaList2.
function SelectedParaList2_Callback(hObject, eventdata, handles)
% hObject    handle to SelectedParaList2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns SelectedParaList2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SelectedParaList2


% --- Executes during object creation, after setting all properties.
function SelectedParaList2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SelectedParaList2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PlotButton2.
function PlotButton2_Callback(hObject, eventdata, handles)
%加载数据
file=get(handles.FileDirectory,'String');
load(file);
%从选择模块那里得到选择的变量
String=get(handles.ParaList,'String');
Index=get(handles.ParaList,'Value');
ParaName=String{Index};
%对SelectedParaList的数据进行处理
List=get(handles.SelectedParaList2,'String');
List{length(List)+1}=ParaName;
set(handles.SelectedParaList2,'String',List);

for i=1:length(List)
index=findstr(List{i},'_');
tmp=List{i};
Name{i}=tmp(index(end-1)+1:index(end)-1)
end
Name=strrep(Name,'_',' ')

axes(handles.Plot2)
x=eval([ParaName,'(:,1)']);
x_Unit={'s'};
y=eval([ParaName,'(:,1)']);
y_Unit=eval([ParaName,'.unit;']);
plot(x,y)
hold on
legend(Name,-1)
% hObject    handle to PlotButton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ClearPlot2.
function ClearPlot2_Callback(hObject, eventdata, handles)
axes(handles.Plot2)
cla reset
set(handles.SelectedParaList2,'String','')
% hObject    handle to ClearPlot2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function Start_Time_Callback(hObject, eventdata, handles)
% hObject    handle to Start_Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Start_Time as text
%        str2double(get(hObject,'String')) returns contents of Start_Time as a double


% --- Executes during object creation, after setting all properties.
function Start_Time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Start_Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function End_Time_Callback(hObject, eventdata, handles)
% hObject    handle to End_Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of End_Time as text
%        str2double(get(hObject,'String')) returns contents of End_Time as a double


% --- Executes during object creation, after setting all properties.
function End_Time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to End_Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
StartTime=str2num(get(handles.Start_Time,'String'));
EndTime=str2num(get(handles.End_Time,'String'));
axes(handles.Plot1)
xlim([StartTime,EndTime]);
axes(handles.Plot2)
xlim([StartTime,EndTime]);

% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
