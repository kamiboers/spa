var TaskRepository = {
  create: function (task) {
    return $.post('/api/v1/tasks', {task: task})
    .fail(function(jqXHR) {
      displayErrors(jqXHR)
    })
    .done(function (data) {
      prependTask(data)
      clearNewTaskInput()    
    })
  },
  all: function () {
    $.get('/api/v1/tasks')
    .done(function(data){
      data.forEach(function(task){
        appendTask(task)
      })
      assignAllClickFunctions()
    })
  },
  destroy: function(id) {
    $.ajax({ 
            url: '/api/v1/tasks/' + id,
            type: 'DELETE',
            success: removeTask(id)
    })
    .fail(function(jqXHR) {
      // debugger;
      // console.log('task deletion failed')
    })
    .done(function(data){
      // console.log(data)
    })
  }
};



function deleteTask() {
  $.ajax({
    method: 'DELETE',
    url: '/api/v1/tasks/' + this.id
  }).then(function () {
    this.element.remove();
  }.bind(this));
}

function updateTask() {
  return $.ajax({
    method: 'PUT',
    url: '/api/v1/tasks/' + this.id,
    data: this.toJSON()
  });
}