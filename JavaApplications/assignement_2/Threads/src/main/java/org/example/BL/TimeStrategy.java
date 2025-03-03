package org.example.BL;

import org.modeling.Server;
import org.modeling.Task;

import java.util.List;

public class TimeStrategy implements Strategy{
    @Override
    public void addTask(List<Server> servers, Task t) {
        int minimumWaitingPeriod = servers.get(0).getWaitingPeriod().get();
        for(Server s : servers){
            minimumWaitingPeriod = Math.min(minimumWaitingPeriod, s.getWaitingPeriod().get());
        }
        for(Server s : servers){
            if(s.getWaitingPeriod().get() == minimumWaitingPeriod){
                t.setWaitingTime(minimumWaitingPeriod + t.getServiceTime());
                s.addTask(t);
                return;
            }
        }
    }
}
