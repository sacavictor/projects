package gui;

import javax.swing.*;

import org.modeling.Task;

import java.util.ArrayList;
import java.util.List;

public class SimulationWindow extends JFrame{
    private JPanel mainPanel;
    private JTextArea taskArea;
    private JTextArea servingArea;
    private JTextField time;
    private JTextArea hours;

    public SimulationWindow() {
        setTitle("Simulation Window");
        setContentPane(mainPanel);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setSize(800, 600);
        setVisible(true);
    }

    public void updateTasks(List<Task> tasks) {
        SwingUtilities.invokeLater(() -> {
            List<Task> tasksCopy = new ArrayList<>(tasks); // Create a copy of the tasks list
            StringBuilder sb = new StringBuilder();
            for (Task task : tasksCopy) {
                sb.append(task.toString()).append("\n");
            }
            taskArea.setText(sb.toString());
        });
    }
    public void updateServingTasks(List<Task> tasks) {
        SwingUtilities.invokeLater(() -> {
            List<Task> tasksCopy = new ArrayList<>(tasks); // Create a copy of the tasks list
            StringBuilder sb = new StringBuilder();
            for (Task task : tasksCopy) {
                sb.append(task.toString()).append("\n");
            }
            servingArea.setText(sb.toString());
        });
    }
    public void setTime(int time){
        this.time.setText(((Integer)time).toString());
    }
}
