package fr.efaya.game.todorpg.service;

import fr.efaya.game.todorpg.Constants;
import fr.efaya.game.todorpg.domain.Task;
import fr.efaya.game.todorpg.domain.User;
import fr.efaya.game.todorpg.event.CompletedTaskEvent;
import fr.efaya.game.todorpg.event.CreatedTaskEvent;
import fr.efaya.game.todorpg.event.ValidatedTaskEvent;
import fr.efaya.game.todorpg.repository.TaskRepository;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * @author Sahbi Ktifa
 * created on 19/12/2017
 */
@Service
public class TaskServiceImpl implements TaskService {
    private TaskRepository repository;
    private ApplicationEventPublisher publisher;

    public TaskServiceImpl(TaskRepository repository, ApplicationEventPublisher publisher) {
        this.repository = repository;
        this.publisher = publisher;
    }

    @Override
    public List<Task> retrieveTasks(String dashboardId) {
        return repository.findAllByDashboardId(dashboardId);
    }

    @Override
    public Task createTask(Task task, User user) {
        task.setId(UUID.randomUUID().toString());
        task.setCreationDate(new Date());
        Integer exp = (Constants.complexity.get(task.getComplexity()) * Constants.levelsToExp.get(user.getLevel())) / 100;
        task.setExp(exp);
        task = repository.save(task);
        publisher.publishEvent(new CreatedTaskEvent(this, task, user));
        return task;
    }

    @Override
    public Task updateTask(Task task) {
        return repository.save(task);
    }

    @Override
    public Task completeTask(Task task, User user) {
        task = repository.findOne(task.getId());
        if (task.getStatus().equals(Task.State.todo)) {
            task.setStatus(Task.State.tovalidate);
            task.setAssignedTo(user.getId());
            task = repository.save(task);
            publisher.publishEvent(new CompletedTaskEvent(this, task, user));
        }
        return task;
    }

    @Override
    public Task validTask(Task task, User user) {
        task = repository.findOne(task.getId());
        if (task.getStatus().equals(Task.State.tovalidate)) {
            task.setStatus(Task.State.done);
            task = repository.save(task);
            publisher.publishEvent(new ValidatedTaskEvent(this, task, user));
        }
        return task;
    }
}