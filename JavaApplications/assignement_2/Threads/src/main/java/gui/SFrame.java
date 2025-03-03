package gui;

import org.example.BL.SelectionPolicy;
import org.example.BL.SimulationManager;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class SFrame extends JFrame{
    private JTextField nrOfClients;
    private JTextField qNumber;
    private JTextField maxArrTime;
    private JTextField simTime;
    private JTextField maxServTime;
    private JTextField minServTime;
    private JTextField minArrTime;
    private JTextField strat;
    private JPanel mainPanel;
    private JButton startButton;
    private SelectionPolicy policy;

    public SFrame(){
        setContentPane(mainPanel);
        setTitle("Queue threads");
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setSize(1000, 1000);
        setVisible(true);

        startButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                int maxProcessingTime=0, minProcessingTime = 0, numberOfServers = 0, numberOfClients = 0, timeLimit = 0, maxArrivalTime = 0;
                SelectionPolicy policy;
                timeLimit = Integer.parseInt(simTime.getText());
                numberOfClients = Integer.parseInt(nrOfClients.getText());
                numberOfServers = Integer.parseInt(qNumber.getText());
                minProcessingTime = Integer.parseInt(minServTime.getText());
                maxProcessingTime = Integer.parseInt(maxServTime.getText());
                maxArrivalTime = Integer.parseInt(maxArrTime.getText());
                String st = strat.getText();

                if(st.compareTo("shortest time") == 0){
                    policy = SelectionPolicy.SHORTEST_TIME;
                }
                else if(st.compareTo("shortest queue") == 0){
                    policy = SelectionPolicy.SHORTEST_QUEUE;
                }else {System.out.println("Invalid strategy");
                    return;
                }
                SimulationWindow simWindow = new SimulationWindow();
                SimulationManager manager = new SimulationManager(policy, timeLimit, minProcessingTime, maxProcessingTime, numberOfServers, numberOfClients, maxArrivalTime, simWindow);
                Thread simulationThread = new Thread(manager);
                simulationThread.start();

            }
        });
    }

    public static void main(String[] args) {
        new SFrame();
    }
}
