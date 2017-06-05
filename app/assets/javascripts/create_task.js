var newTaskTitle, newTaskBody;

$(document).ready(function () {
  newTaskTitleInput = $('#new-task-title')
  newTaskBodyInput = $('#new-task-body')
  errorMessageDiv = $('#new-task-errors')
  taskList = $('#tasks-list')

  TaskRepository.all()
  taskList.delay(500).removeClass('hidden')
  $('#new-task-submit').on('click', createTask)
})

function createTask(event) {
  event.preventDefault()
  clearErrorMessages()
  TaskRepository.create(getNewTaskInput())
}

function destroyTask() {
  event.preventDefault()
  taskId = this.id.split('-').pop()
  TaskRepository.destroy(taskId)
}

function getNewTaskInput() {
  return {
    title: newTaskTitleInput.val(),
    body: newTaskBodyInput.val()
  }
}

function displayErrors(response) {
  errorStatus = response.status
  errorResponse = JSON.parse(response.responseText).errors
  var messages = concatenateErrors(errorResponse)
  errorMessageDiv.append(messages).removeClass('hidden')
}

function concatenateErrors(errorResponse) {
  var messages = []
  first_message = true
  Object.keys(errorResponse).forEach(function(key){
    message = key + ' ' + errorResponse[key]
    if (first_message == true) {
      message = message.charAt(0).toUpperCase() + message.slice(1)
      first_message = false
    }
    messages.push(message)
  })
  return _.uniq(messages).join(', ') + '.'
}

function assignAllClickFunctions() {
  $('.delete-button').on('click', destroyTask)
}

function assignRowClickFunctions(id) {
  $('.task-' + id + ' .delete-button').on('click', destroyTask)
}

function clearErrorMessages() {
  errorMessageDiv.text('').addClass('hidden')
}

function clearNewTaskInput() {
    newTaskTitleInput.val('')
    newTaskBodyInput.val('')
}

function prependTask(task) {
  taskList.prepend(taskTemplate(task))
  assignRowClickFunctions(task.id)
}

function appendTask(task) {
  taskList.append(taskTemplate(task))
  assignRowClickFunctions(task.id)
}

function removeTask(id) {
  $('.task-'+id).addClass('delete-fade').text('task deleted')
  $('.task-'+id).delay(500).fadeOut(500)
}

function taskTemplate(task) {
  if (task.complete == 'true') {
    var template = '<li class="task complete task-' + task.id + '">'    
  } else {
    var template = '<li class="task incomplete task-' + task.id + '">'    
  }
  template += 
    // _.template(
    '<span class="list-row-element task-title-check"><i class="fa fa-square-o" aria-hidden="true"></i></span>' +
    '<span class="list-row-element task-title">' + task.title + '</span>' +
    '<span class="list-row-element task-title-caret"><i class="fa fa-angle-double-right fa-lg" aria-hidden="true"></i></span>' +
    '<span class="list-row-element task-body">' + task.body + '</span>' +
    '<span class="list-row-element task-delete"> <button class="delete-button" id="delete-' + task.id + '"> DELETE </button></span>' +
    '</li>'
    // )
  return template
}


