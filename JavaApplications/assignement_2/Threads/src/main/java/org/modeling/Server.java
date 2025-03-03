package org.modeling;

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.atomic.AtomicInteger;

public class Server implements Runnable{
    private BlockingQueue<Task> tasks;
    private AtomicInteger waitingPeriod;
    public Server(){
        waitingPeriod = new AtomicInteger(0);
        tasks = new LinkedBlockingQueue<>();
    }
    public BlockingQueue<Task> getTasks() {
        return tasks;
    }
    public void setTasks(BlockingQueue<Task> tasks) {
        this.tasks = tasks;
    }
    public AtomicInteger getWaitingPeriod() {
        return waitingPeriod;
    }

    public void setWaitingPeriod(AtomicInteger waitingPeriod) {
        this.waitingPeriod = waitingPeriod;
    }

    public void addTask(Task newTask){
        tasks.add(newTask);
        waitingPeriod.getAndIncrement();
    }



    public void run(){
        while(true){
            Task t = tasks.peek();
            if(t == null)
                break;
            tasks.remove();
            try {
                Thread.sleep(t.getServiceTime() * 1000L);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
            waitingPeriod.getAndDecrement();
        }
    }
}
