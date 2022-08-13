chemin = dir('C:\Users\tidus\Desktop\Programmation\Matlab\Thèse\Analyse données météo\Data') ;
lname = [];

for i=3:length(chemin)
    lname = [lname ; chemin(i).name];
end

mf_obj = MF_BS_tool_inter;
mf_obj.nwt = 3;
mf_obj.method_mrq = [1 2];    % 1: Wavelet coefficients, 2: wavelet leaders
mf_obj.j1      = 3;
mf_obj.j2      = 7;
mf_obj.p = inf;
q = build_q_log (0.01, 5, 10);
mf_obj.cum     = 3;
mf_obj.gamint = 0;
mf_obj.fig_num = 100;
mf_obj.verbosity = 1;
hmin = [];

for i=1:length(lname)
    load(lname(i,:))
    N = length (data);
    figure (11111); clf
    plot (data)
    TSTR = '';
    mf_obj.analyze (data);
    hmin = [hmin mf_obj.est.DWT.h_min];
end

mf_obj = MF_BS_tool_inter;
mf_obj.nwt = 3;
mf_obj.method_mrq = [1 2];    % 1: Wavelet coefficients, 2: wavelet leaders
mf_obj.j1      = 3;
mf_obj.j2      = 7;
mf_obj.p = inf;
q = build_q_log (0.01, 5, 10);
mf_obj.cum     = 3;
mf_obj.gamint = 1;
mf_obj.fig_num = 100;
mf_obj.verbosity = 1;
hminif=[];
c1 = [];

for i=1:length(lname)
    load(lname(i,:))
    N = length (data);
    figure (11111); clf
    plot (data)
    TSTR = '';
    mf_obj.analyze (data);
    hminif = [hminif mf_obj.est.LWT.h_min-1];
    l = mf_obj.est.LWT.t(mf_obj.get_hid ());
    c1 = [c1 l((round(mf_obj.est.LWT.t(mf_obj.get_Did ()),4)==1))];
end

figure(1)
plot(hminif,c1,'+b')
xlabel('hmin')
ylabel('c1')
grid on
for i=1:length(lname)
    text(hminif(i),c1(i)-0.001,lname(i,1:end-4))
end


