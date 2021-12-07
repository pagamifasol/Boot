%% loops settings
[loops,canceled] = loop_setting();
if canceled == 1
    error('Error. \nThe operation was cancelled by the user %s',[])
else
    dir = strcat('Simulation_results\',Settings.vInput,'_',Settings.cycle_name);
    mkdir(dir)
    %%%%%%% simulation loops %%%%%%%
    % preallocation
    par_var     = zeros(max(1,loops.loopsi)*max(1,loops.loopsj)*max(1,loops.loopsk)*max(1,loops.loopsm)*max(1,loops.loopsn),5);
    sim_name(max(1,loops.loopsi)*max(1,loops.loopsj)*max(1,loops.loopsk)*max(1,loops.loopsm)*max(1,loops.loopsn)) = {''};

    count                           = 1;
    for n = 1:max(1,loops.loopsn)
        if loops.loopsn > 0
            [VHCL,MTR,TRSM,BTR] = set_input(VHCL,MTR,TRSM,BTR,loops.parameter5,loops.Change5(n));
        end
        for m = 1:max(1,loops.loopsm)
            if loops.loopsm > 0
                [VHCL,MTR,TRSM,BTR] = set_input(VHCL,MTR,TRSM,BTR,loops.parameter4,loops.Change4(m));
            end
            for k = 1:max(1,loops.loopsk)
                if loops.loopsk > 0
                    [VHCL,MTR,TRSM,BTR] = set_input(VHCL,MTR,TRSM,BTR,loops.parameter3,loops.Change3(k));
                end
                for j = 1:max(1,loops.loopsj)
                    if loops.loopsj > 0
                        [VHCL,MTR,TRSM,BTR] = set_input(VHCL,MTR,TRSM,BTR,loops.parameter2,loops.Change2(j));
                    end
                    for i = 1:max(1,loops.loopsi)
                        if loops.loopsi > 0
                            [VHCL,MTR,TRSM,BTR] = set_input(VHCL,MTR,TRSM,BTR,loops.parameter1,loops.Change1(i));
                        end
                        % run simulink simulation
                        run('calc_parameters')
                        sim('PFX_Vehicle_Model.mdl')
                        % save output
                        if loops.loopsi > 0
                            par_var(count,1)    = loops.Change1(i);
                        end
                        if loops.loopsj > 0
                            par_var(count,2)    = loops.Change2(j);
                        end
                        if loops.loopsk > 0
                            par_var(count,3)    = loops.Change3(k);
                        end
                        if loops.loopsk > 0
                            par_var(count,4)    = loops.Change4(m);
                        end
                        if loops.loopsk > 0
                            par_var(count,5)    = loops.Change5(n);
                        end
                        sim_name(count)     = {strcat('var',num2str(count))};
                        save(strcat(dir,'\',sim_name{count}),'Settings','Sim_Results')

                        count = count + 1  % Output is not soppressed to show the state of the loop while running 
                    end     
                end
            end
        end
    end
    if loops.loopsi > 0
        if loops.loopsj > 0
            if loops.loopsk > 0
                if loops.loopsm > 0
                    if loops.loopsn > 0
                        par_var = array2table(par_var(:,:),'VariableNames',{loops.parameter1{1};loops.parameter2{1};loops.parameter3{1};loops.parameter4{1};loops.parameter5{1}});
                        writetable(par_var,strcat(dir,'\par_var.xlsx'))
                    else
                        par_var = array2table(par_var(:,:),'VariableNames',{loops.parameter1{1};loops.parameter2{1};loops.parameter3{1};loops.parameter4{1}});
                        writetable(par_var,strcat(dir,'\par_var.xlsx'))
                    end
                else
                    par_var = array2table(par_var(:,:),'VariableNames',{loops.parameter1{1};loops.parameter2{1};loops.parameter3{1}});
                    writetable(par_var,strcat(dir,'\par_var.xlsx'))
                end
            else
                par_var = array2table(par_var(:,1:2),'VariableNames',{loops.parameter1{1};loops.parameter2{1}});
                writetable(par_var,strcat(dir,'\par_var.xlsx'))
            end
        else
            par_var = array2table(par_var(:,1),'VariableNames',{loops.parameter1{1}});
            writetable(par_var,strcat(dir,'\par_var.xlsx'))
        end
    end

    clear par_var i j k m n loopsi loopsj loopsk loopsm loopsn count sim_name

end
