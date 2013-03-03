function varargout = Decoder(varargin)
% DECODER M-file for Decoder.fig
%      DECODER, by itself, creates a new DECODER or raises the existing
%      singleton*.
%
%      H = DECODER returns the handle to a new DECODER or the handle to
%      the existing singleton*.
%
%      DECODER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DECODER.M with the given input arguments.
%
%      DECODER('Property','Value',...) creates a new DECODER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Decoder_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Decoder_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Decoder

% Last Modified by GUIDE v2.5 10-Feb-2013 23:54:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Decoder_OpeningFcn, ...
                   'gui_OutputFcn',  @Decoder_OutputFcn, ...
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


% --- Executes just before Decoder is made visible.
function Decoder_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Decoder (see VARARGIN)

% Choose default command line output for Decoder
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Decoder wait for user response (see UIRESUME)
% uiwait(handles.figure1);
javaFrame = get(hObject,'JavaFrame');
javaFrame.setFigureIcon(javax.swing.ImageIcon('omulogo.jpg'));

% --- Outputs from this function are returned to the command line.
function varargout = Decoder_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in dec.
function dec_Callback(hObject, eventdata, handles)
    image = imageDecoding(handles.image, handles.lut);
    imwrite(image, [handles.way, handles.encname(1:find(handles.encname == '_') - 1), 'r.jpg']);
    
    set(handles.information, 'String', 'Decoding is succes pls check your encode_image folder for image!');
guidata(hObject, handles);


function select_Callback(hObject, eventdata, handles)
    [filename, pathname] = uigetfile('*', 'Select a MATLAB code file', 'MultiSelect', 'on');
    for i=1:length(filename)
        if( filename{i}(find( filename{i}=='.' )+1 : length(filename{i}) ) == 'LUT')
            handles.lutname = filename{i};
        elseif( filename{i}(find( filename{i}=='_' )+1 : find( filename{i}=='.' )-1 ) == 'ENC')
            handles.encname = filename{i};
        else
            set(handles.information, 'String', 'Wrong file selection!');
        end
    end
    handles.way = pathname;
    
    if isequal(filename,0)
        disp('User selected Cancel');
    else
        handles.image = imread([handles.way, handles.encname]);
        handles.lut = importdata([handles.way, handles.lutname]);
    end
guidata(hObject, handles);
