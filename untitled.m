subject = '111';
session = '2';
dir = ['C:\Users\Massoud\OneDrive - Ulster University\Naomi-data\S'...
    subject '\Session_' session '\'];
%%
%load([dir 'EEG_rec.mat']);
%EEG_rec(1,:)=[];
%save([dir 'EEG_rec_modified.mat'],"EEG_rec");
%%
%eeglab
[EEG, ALLEEG, command] = pop_read_gtec(ALLEEG, 'EEG_rec_modified.mat');
EEG.chanlocs = readlocs( 'C:\Users\Massoud\Downloads\Elecctode Montage\10-05_64_chan_montage1.xyz', 'filetype', 'xyz' );
EEG = pop_select(EEG,'rmchannel', 65);
eeglab redraw
%%
%reject channels?????
[EEG,HP,BUR] = clean_artifacts(EEG);
%filter
[EEG, com, b] = pop_eegfiltnew(EEG, 0.5, 40);
%epoching
categories = {[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16],[17,18,19,20],[21,22,23,24]};
names = {'actionText','combsText','actionImage','combsImage','actionAudio','combsAudio'};
dirSave = ['C:\Users\Massoud\OneDrive - Ulster University\Naomi-data\S'...
    subject '\Session_' session '\after\'];

total_data = ALLEEG(end);
EEG = total_data.data;
labels_struct = struct2cell(total_data.event);
labels = labels_struct(1,:);
labels = cell2mat(labels);

save([dirSave 'allEEG.mat'], 'EEG');
save([dirSave 'all_labels.mat'], 'labels');

total_data.data = total_data.data;
total_data.event = total_data.event;
 for i =1:length(categories)
     data_struct = pop_selectevent(total_data, 'type', categories{i}, 'deleteevents','on');
    OUTEEG = pop_epoch( data_struct, {  }, [-0.5 2.5], 'newname', 'gtec_import epochs', 'epochinfo', 'yes');
    OUTEEG = pop_rmbase( OUTEEG, [-500 0] ,[]);  
     
     EEG = data_struct.data;
     labels_struct = struct2cell(data_struct.event);
     labels = labels_struct(1,:);
     labels = cell2mat(labels);
     %ICA
     OUT_EEG = pop_runica(OUTEEG, 'icatype','runica');
     %ICA lavel - remove components 0.9-1
     EEG1 = pop_iclabel(OUT_EEG, 'default');
     EEG2 = pop_icflag(EEG1, [NaN NaN;0.9 1;0.9 1;0.3 1;0.3 1;0.3 1;NaN NaN]);
     EEG3 = pop_subcomp( EEG2, [], 0);
     EEG = EEG3.data;
     %save
     save([dirSave names{i} '.mat'], 'EEG');
     save([dirSave names{i} '_labels.mat'], 'labels');
 end

%%
%EEG = pop_clean_rawdata(EEG);
%pop_select(EEG);
%[EEG, com, b] = pop_eegfiltnew(EEG)
%OUT_EEG = pop_runica( EEG )
%%