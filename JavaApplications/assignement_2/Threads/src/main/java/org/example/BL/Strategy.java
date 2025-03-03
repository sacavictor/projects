package org.example.BL;
import org.modeling.Server;
import org.modeling.Task;

import java.util.List;

;

public interface Strategy {
    public void addTask(List<Server> servers, Task t);
}
