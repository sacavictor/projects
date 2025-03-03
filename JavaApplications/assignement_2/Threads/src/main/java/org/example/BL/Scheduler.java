package org.example.BL;
import org.modeling.Server;
import org.modeling.Task;

import java.util.ArrayList;
import java.util.List;


public class Scheduler {
    private List<Server> servers;
    private Strategy strategy;

    public Scheduler(int numberOfServers, SelectionPolicy policy){
        this.servers = new ArrayList<Server>();
        for(int i=0; i<numberOfServers; i++) {
            Server s = new Server();
            servers.add(s);
            Thread t = new Thread(s);
            t.start();
        }
    changeStrategy(policy);
    }

    public List<Server> getServers() {
        return servers;
    }

    public void setServers(List<Server> servers) {
        this.servers = servers;
    }

    public Strategy getStrategy() {
        return strategy;
    }

    public void setStrategy(Strategy strategy) {
        this.strategy = strategy;
    }
    public void changeStrategy(SelectionPolicy policy){
        if(policy == SelectionPolicy.SHORTEST_QUEUE){
            strategy = new ShortestQueueStrategy();
        }else if(policy == SelectionPolicy.SHORTEST_TIME)
            strategy = new TimeStrategy();
    }
    public void dispatchTask(Task t){
        t.setWaitingTime(t.getWaitingTime() + 1);
        strategy.addTask(servers, t);
    }
}
