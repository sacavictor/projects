package org.example.BL;
import gui.SimulationWindow;
import org.modeling.Server;
import org.modeling.Task;
import gui.SFrame;

import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

public class SimulationManager implements Runnable {
    private Scheduler scheduler;
    private SFrame frame;
    private List<Task> tasks;
    List<Task> servingTasks;
    private SelectionPolicy selectionPolicy;
    public int timeLimit;
    public int minProcessingTime;
    public int maxProcessingTime;
    public int numberOfServers;
    public int numberOfClients;
    public int maxArrivalTime;
    private SimulationWindow window;
    private PrintWriter logWriter;

    public SimulationManager(SelectionPolicy policy, int timeLimit, int minProcessingTime, int maxProcessingTime, int numberOfServers, int numberOfClients, int maxArrivalTime, SimulationWindow window){
        this. timeLimit = timeLimit;
        this.minProcessingTime = minProcessingTime;
        this.maxProcessingTime = maxProcessingTime;
        this.numberOfServers = numberOfServers;
        this.numberOfClients = numberOfClients;
        this.maxArrivalTime = maxArrivalTime;
        this.window = window;
        scheduler = new Scheduler(numberOfServers, policy);
        this.selectionPolicy = policy;

        generateNRandomTasks(maxProcessingTime, minProcessingTime, timeLimit, numberOfClients);
        servingTasks = new ArrayList<>();
        try {
            logWriter = new PrintWriter(new FileWriter("log.txt"));
        } catch (IOException e) {
            e.printStackTrace(); // Handle file IO exception
        }
    }

    private void generateNRandomTasks(int maxProcessingTime, int minProcessingTime, int timeLimit, int numberOfClients) {
        tasks = new ArrayList<Task>();
        Random rand = new Random();

        for (int i = 0; i < numberOfClients; i++) {
            int processTime = rand.nextInt(maxProcessingTime - minProcessingTime) + minProcessingTime;
            int arrival = rand.nextInt(maxArrivalTime);
            Task t = new Task(i, arrival, 0, processTime);
            tasks.add(t);
        }
        tasks.sort(new Comparator<Task>() {
            @Override
            public int compare(Task o1, Task o2) {
                return Integer.compare(o1.getArrivaTime(), o2.getArrivaTime());
            }
        });
    }


    public void run() {
        int currentTime = 0;
        int[] arrivalCount = new int[timeLimit];
        int maxArrivals = 0;
        double totalWaitingTime = 0;
        int totalTasks = 0;

        servingTasks.clear();
        while (currentTime <= timeLimit) {
            Iterator<Task> iterator = tasks.iterator();
            window.updateTasks(tasks);
            while (iterator.hasNext()) {
                Task t = iterator.next();
                if (t.getArrivaTime() == currentTime) {
                    scheduler.dispatchTask(t);
                    servingTasks.add(t);
                    iterator.remove();
                    System.out.println(tasks);
                    logWriter.println(t);
                    logWriter.flush();

                    arrivalCount[currentTime]++;
                    if (arrivalCount[currentTime] > maxArrivals) {
                        maxArrivals = arrivalCount[currentTime];
                    }
                }
            }
            int c = 0;
            window.updateServingTasks(servingTasks);
            for(Task t : servingTasks){
                if(t.getServiceTime() > 0) {
                    t.getAndDecrementServiceTime();
                }
                else {
                    totalWaitingTime += currentTime - t.getArrivaTime(); // Update total waiting time
                    totalTasks++; // Increment total tasks
                }
            }
            window.setTime(currentTime);
            currentTime++;
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
        }
        double avgWaitingTime = totalTasks > 0 ? totalWaitingTime / (double)totalTasks : 0;
        double avgServiceTime = totalTasks > 0 ? (timeLimit - totalTasks) /(double) totalTasks : 0;

        // Output statistics
        logWriter.println("Peak hour: " + (maxArrivals > 0 ? List.of(arrivalCount).indexOf(maxArrivals) : "No arrivals"));
        logWriter.println("Average waiting time: " + avgWaitingTime);
        logWriter.println("Average service time: " + (-avgServiceTime));
        logWriter.close();
    }
}

