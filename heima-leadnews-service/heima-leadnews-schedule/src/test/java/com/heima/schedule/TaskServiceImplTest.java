package com.heima.schedule;

import com.heima.model.schedule.dto.Task;
import com.heima.schedule.service.TaskService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.Date;

@SpringBootTest(classes = ScheduleApplication.class)
@RunWith(SpringRunner.class)
public class TaskServiceImplTest {

    @Autowired
    private TaskService taskService;

    @Test
    public void addTask() {
        Task task = new Task();
        task.setTaskType(100);
        task.setPriority(50);
        task.setParameters("task test!!".getBytes());
        task.setExecuteTime(new Date().getTime());
        long id = taskService.addTask(task);
        System.out.println(id);
    }

    @Test
    public void cancelTask() {
        taskService.cancalTask(1723156589910806529L);
    }

    @Test
    public void testPoll() {
        Task task = taskService.poll(100, 50);
        System.out.println(task);
    }

}
