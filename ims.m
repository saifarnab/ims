 
daily_demand = [];
lead_time = [];
%{
daily_demand(1,1) = 1;
daily_demand(1,2) = 10;
daily_demand(1,3) = 0;

daily_demand(2,1) = 11;
daily_demand(2,2) = 35;
daily_demand(2,3) = 1;

daily_demand(3,1) = 36;
daily_demand(3,2) = 70;
daily_demand(3,3) = 2;

daily_demand(4,1) = 71;
daily_demand(4,2) = 91;
daily_demand(4,3) = 3;

daily_demand(5,1) = 92;
daily_demand(5,2) = 100;
daily_demand(5,3) = 4;

lead_time(1,1) = 1;
lead_time(1,2) = 6;
lead_time(1,3) = 1;

lead_time(2,1) = 7;
lead_time(2,2) = 9;
lead_time(2,3) = 2;

lead_time(3,1) = 0;
lead_time(3,2) = 0;
lead_time(3,3) = 3;
%}
days = input('for how many days u want to run the simulation?: '); 
daily_demand_range = input('how many slice u want to create for daily demand?: ');
for i=1:daily_demand_range
    for j=1:1
        if(i == 1)
            upper = input('Enter the upper value for first range: ');
        else
            upper = input('Enter the upper value for next range: ');
        end
        if upper == 0
            daily_demand(i,1) = 0;
            daily_demand(i,2) = 0;
            val = input('Enter the deamand: ');
            daily_demand(i,3) = val;
        elseif i == 1
            daily_demand(i,1) = 1;
            daily_demand(i,2) = upper;
            val = input('Enter the deamand: ');
            daily_demand(i,3) = val;
        else
            daily_demand(i,1) = daily_demand(i-1,2) + 1;
            daily_demand(i,2) = upper;
            val = input('Enter the deamand: ');
            daily_demand(i,3) = val;
        end
    end
end

disp(daily_demand);

lead_time_range = input('how many slice u want to create for lead time?: ');
for i=1:lead_time_range
    for j=1:1
        if(i == 1)
            upper = input('Enter the upper value for first range: ');
        else
            upper = input('Enter the upper value for next range: ');
        end
        if upper == 0
            lead_time(i,1) = 0;
            lead_time(i,2) = 0;
            val = input('Enter the deamand: ');
            lead_time(i,3) = val;
        elseif i == 1
            lead_time(i,1) = 1;
            lead_time(i,2) = upper;
            val = input('Enter the deamand: ');
            lead_time(i,3) = val;
        else
            lead_time(i,1) = lead_time(i-1,2) + 1;
            lead_time(i,2) = upper;
            val = input('Enter the deamand: ');
            lead_time(i,3) = val;
        end
    end
end

disp(lead_time);

maximum_ivn = 11;
reorder_point = 5;
beg_ivn = 3;
RD_demand_range = daily_demand(daily_demand_range,2);
RD_lead_range = lead_time(lead_time_range,2);
main = [];
demand = 0;
shortage = 0;
shortage_day = 0;
%ra = [24,35,65,81,54,03,87,27,73,70,47,45,48,17,09];
%la = [5,0,3];
count = 1;
lr = [1,2,3];
order_quantity = 8;
arival_day = 1;
cycle = 1;
disp('   Cycle Days Beg_Iv RD_D Demand End_Iv Short Order RD_L  Arrival_days');
for i=1:days
    if arival_day == -1
        beg_ivn = beg_ivn + order_quantity;
    end
    if count > 5
        count = 1;
    end
    main(i,2) = count;
    count = count + 1;
    main(i,1) = cycle;
    if mod(i,5) == 0
        cycle = cycle +1;
    end
    main(i,3) = beg_ivn;
    if beg_ivn >= shortage
        beg_ivn = beg_ivn - shortage;
    end    
    RD_demand = round(rand() * RD_demand_range);
    %RD_demand = ra(i);
    for k=1:daily_demand_range
        if RD_demand >= daily_demand(k,1) && RD_demand <= daily_demand(k,2)
            demand = daily_demand(k,3);
            break;
        end
    end
    main(i,4) = RD_demand;
    main(i,5) = demand;
    end_ivn = beg_ivn - demand;
    if end_ivn < 0
        shortage = shortage + abs(end_ivn);
        main(i,7) = shortage;
        shortage_day = shortage_day + 1;
        end_ivn = 0;
    else
        shortage = 0;
    end
    main(i,6) = end_ivn;
    
    if mod(i,5) == 0
        order_quantity = maximum_ivn - end_ivn;
        RD_lead_time = round(rand() * RD_lead_range);
        %RD_lead_time = la(count);
        count = count + 1;
        main(i,8) = order_quantity;
        main(i,9) = RD_lead_time;
        for k=1:lead_time_range
            if RD_lead_time >= lead_time(k,1) && RD_lead_time <= lead_time(k,2)
                arival_day = lead_time(k,3);
                break;
            end
        end
    else
        main(i,8) = 0;
        main(i,9) = 0;
    end
    if(arival_day > -1)
        main(i,10) = arival_day;
    else
        main(i,10) = 0;
    end
    arival_day = arival_day - 1;
    beg_ivn = end_ivn;

end
disp(main);
    
    
    
    
    
    
