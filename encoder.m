function varargout = encoder(varargin)
% ENCODER M-file for encoder.fig
%      ENCODER, by itself, creates a new ENCODER or raises the existing
%      singleton*.
%
%      H = ENCODER returns the handle to a new ENCODER or the handle to
%      the existing singleton*.
%
%      ENCODER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENCODER.M with the given input arguments.
%
%      ENCODER('Property','Value',...) creates a new ENCODER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before encoder_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to encoder_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help encoder

% Last Modified by GUIDE v2.5 10-Feb-2013 23:45:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @encoder_OpeningFcn, ...
                   'gui_OutputFcn',  @encoder_OutputFcn, ...
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


% --- Executes just before encoder is made visible.
function encoder_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to encoder (see VARARGIN)

% Choose default command line output for encoder
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes encoder wait for user response (see UIRESUME)
% uiwait(handles.figure1);

javaFrame = get(hObject,'JavaFrame');
javaFrame.setFigureIcon(javax.swing.ImageIcon('omulogo.jpg'));
% --- Outputs from this function are returned to the command line.
function varargout = encoder_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function enco_Callback(hObject, eventdata, handles)
    [enc_im, L] = imagEncoding(handles.image);
    
    imwrite(enc_im, [handles.way, handles.name(1:find(handles.name == '.') - 1), '_ENC.jpg']);
    
    savefile = [handles.way, handles.name(1:find(handles.name == '.') - 1), '.LUT'];
    save(savefile, 'L');
    
    set(handles.information, 'String', 'Crypto is succes pls check image folder for encode_image and Look up table');
guidata(hObject, handles);

function selectbutton_Callback(hObject, eventdata, handles)
    [filename, pathname] = uigetfile('*', 'Select a MATLAB code file');
    handles.fil = filename;
    handles.way = pathname;
    handles.name = filename;
    if isequal(filename,0)
        disp('User selected Cancel');
    
    else
        handles.image = imread([handles.way, handles.name]);
    end
guidata(hObject, handles);

