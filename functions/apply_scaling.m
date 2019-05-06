function [ data ] = apply_scaling( data )
    %apply_scaling Apply scaling factor to numeric data
    disp('Apllying sclaing factors on measurements...');
    %k=0.547619047619048; %scaling factor : 1px equivalent to k microns?
    k=ask_scaling_factor();
    
    for i=1:numel(data)
        data{i}.Area=data{i}.Area*k^2;
        data{i}.MajorAxisLength=data{i}.MajorAxisLength*k;
        data{i}.MinorAxisLength=data{i}.MinorAxisLength*k;
        data{i}.EquivDiameter=data{i}.EquivDiameter*k;
        data{i}.Perimeter=data{i}.Perimeter*k;
    end
    function [ scaling_factor ] = ask_scaling_factor()
        %ask_scaling_factor Will ask the user to specify the magnification
        %of his images, or enter a custom scaling factor (correlation
        %between pixel and real size.
        
        %% Create a dilaog window
        dlg=dialog('WindowStyle','normal',...
            'Position',[0 0 300 150],'Name','Choose a magnification');
        movegui(dlg,'center'); %move the dialog to center of screen
        handles=guihandles(dlg);
        handles.txt=uicontrol(dlg,'Style','text',...
            'Position',[10 130 290 20],...
            'String','Select a magnification level for these pictures');%set the text
        handles.pop=uicontrol(dlg,'Style','popup',...
            'Position',[10 110 100 20],...
            'String',{'2.5x','10x','50x','Custom scale factor'},...
            'Callback',{@pop_callback});%create a popup control with different options
        handles.push=uicontrol(dlg,'Style','pushbutton',...
            'String','OK',...
            'Position',[100 20 70 30],...
            'Callback',@push_button_callback);%create an OK push button
        handles.input=uicontrol(dlg,'Style','edit',...
            'Position',[10 90 280 20],...
            'Visible','off');%create a text input field for custom option, but set it invisible
        align([handles.txt handles.pop handles.input handles.push],'Center','Distribute');%align all elements
        guidata(dlg,handles);%save gui data
        uiwait(dlg);
        close(dlg)
        scaling_factor=handles.scaling_factor;%return value for function
        %% Callback function for the popoup selector
        function pop_callback(hObject,eventdata)
            handles=guidata(gcbo);%retrieve handles structure, and data
            if handles.pop.Value==4 %if custom selected
                handles.input.Visible='on';%set text input field visible
            else
                handles.input.Visible='off';%if not, set text input field invisible
            end
            align([handles.txt handles.pop handles.push handles.input],'Center','Distribute');%align gui elements
            guidata(gcbo,handles);%save guidata
        end
        
        %% Callback function for Ok button
        function push_button_callback(hObject,eventdata)
            handles=guidata(gcbo);%retrieve handles structure, and data
            switch handles.pop.Value
                case 1
                    handles.scaling_factor=2.19047619047619;
                    
                case 2
                    handles.scaling_factor=0.547619047619048;
                case 3
                    handles.scaling_factor=50;%need to replace with proper value
                case 4
                    if (handles.pop.Value==4 && ~isempty(handles.input.String) && numel(str2num(handles.input.String))==1)% if custom option selected
                        handles.scaling_factor=str2double(handles.input.String);%convert to num and save to gui data structure
                    else
                        msgbox('You need to enter a valid number');
                        return;
                        
                    end
                    
            end
            guidata(gcbo,handles);%save handles structure
            uiresume(dlg);
        end
        
        
    end
    
    
end
