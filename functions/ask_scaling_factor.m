function [ scaling_factor ] = ask_scaling_factor()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
dlg=dialog('WindowStyle','normal',...
    'Position',[0 0 300 150],'Name','Choose a magnification');
movegui(dlg,'center'); %move the dialog to center of screen
handles=guihandles(dlg);
handles.txt=uicontrol(dlg,'Style','text',...
    'Position',[10 130 290 20],...
    'String','Select a magnification level for these pictures');
handles.pop=uicontrol(dlg,'Style','popup',...
    'Position',[10 110 100 20],...
    'String',{'2.5x','10x','50x','Custom scale factor'},...
    'Callback',{@pop_callback});
handles.push=uicontrol(dlg,'Style','pushbutton',...
    'String','OK',...
    'Position',[100 20 70 30],...
    'Callback',@push_button_callback)
handles.input=uicontrol(dlg,'Style','edit',...
    'Position',[10 90 280 20],...
    'Visible','off')
align([handles.txt handles.pop handles.input handles.push],'Center','Distribute')
guidata(dlg,handles);


    function pop_callback(hObject,eventdata)
        handles=guidata(gcbo);%retrieve handles structure.
        if handles.pop.Value==4
            handles.input.Visible='on';
            align([handles.txt handles.pop handles.push handles.input],'Center','Distribute')
        else
            handles.input.Visible='off'
            align([handles.txt handles.pop handles.push],'Center','Distribute')
        end
        guidata(gcbo,handles)%save handles structure
    end


    function push_button_callback(hObject,eventdata)
        handles=guidata(gcbo);     
        if handles.pop.Value==4
            factor=str2num(handles.input.String);
            if isempty(factor) || numel(factor)~=1
                msgbox('You need to enter a valid number')
                return
            end
            handles.scaling_factor=str2num(handles.input.String);
            else
            switch handles.pop.Value
                case 1
                    handles.scaling_factor=2.5;%need to replace with proper value
                    
                case 2
                  handles.scaling_factor=0.547619047619048;
                case 3
                    handles.scaling_factor=50;%need to replace with proper value
            end
            
        end
        guidata(gcbo,handles)%save handles structure
        uiresume(dlg)
    end


uiwait(dlg);
close(dlg)
scaling_factor=handles.scaling_factor;

end

