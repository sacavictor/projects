package org.example.BL;

import org.modeling.Server;
import org.modeling.Task;

import java.util.List;

public class ShortestQueueStrategy implements Strategy{

    @Override
    public void addTask(List<Server> servers, Task t) {
        int minimum = servers.get(0).getTasks().size();
        for(Server s : servers){
            minimum = Math.min(minimum, s.getTasks().size());
        }
        for(Server s : servers){
            if(s.getTasks().size() == minimum) {
                s.addTask(t);
                return;
            }
        }
    }
}
