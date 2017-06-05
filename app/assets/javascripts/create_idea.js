var newIdeaTitle, newIdeaBody;

$(document).ready(function () {
  newIdeaTitleInput = $('#new-idea-title')
  newIdeaBodyInput = $('#new-idea-body')
  errorMessageDiv = $('#new-idea-errors')
  ideaList = $('#ideas-list')
  var existingIdeas = []

  IdeaRepository.all()
  ideaList.delay(500).removeClass('hidden')
  $('#new-idea-submit').on('click', createIdea)
})

function createIdea(event) {
  event.preventDefault()
  clearErrorMessages()
  IdeaRepository.create(getNewIdeaInput())
}

function destroyIdea() {
  event.preventDefault()
  ideaId = this.id.split('-').pop()
  IdeaRepository.destroy(ideaId)
}

function getNewIdeaInput() {
  return {
    title: newIdeaTitleInput.val(),
    body: newIdeaBodyInput.val()
  }
}

function displayErrors(response) {
  errorStatus = response.status
  errorResponse = JSON.parse(response.responseText).errors
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
    messages = _.uniq(messages).join(', ') + '.'
    errorMessageDiv.append(messages).removeClass('hidden')
}

function assignAllClickFunctions() {
  $('.delete-button').on('click', destroyIdea)
}

function assignRowClickFunctions(id) {
  $('.idea-' + id + ' .delete-button').on('click', destroyIdea)
}

function clearErrorMessages() {
  errorMessageDiv.text('').addClass('hidden')
}

function clearNewIdeaInput() {
    newIdeaTitleInput.val('')
    newIdeaBodyInput.val('')
}

function prependIdea(idea) {
  ideaList.prepend(ideaTemplate(idea))
  assignRowClickFunctions(idea.id)
}

function appendIdea(idea) {
  ideaList.append(ideaTemplate(idea))
  assignRowClickFunctions(idea.id)
}

function removeIdea(id) {
  $('.idea-'+id).addClass('delete-fade').text('idea deleted')
  $('.idea-'+id).delay(500).fadeOut(500)
}

function ideaTemplate(idea) {
  var template = 
    // _.template(
    '<li class="idea idea-' + idea.id + '">' +
    '<span class="list-row-element idea-title-check"><i class="fa fa-square-o" aria-hidden="true"></i></span>' +
    '<span class="list-row-element idea-title">' + idea.title + '</span>' +
    '<span class="list-row-element idea-title-caret"><i class="fa fa-angle-double-right fa-lg" aria-hidden="true"></i></span>' +
    '<span class="list-row-element idea-body">' + idea.body + '</span>' +
    '<span class="list-row-element idea-delete"> <button class="delete-button" id="delete-' + idea.id + '"> DELETE </button></span>' +
    '</li>'
    // )

  //   '<p class="idea-quality"><%= idea.quality %></p>' +
  //   '<div class="idea-qualities idea-buttons">' +
  //     '<button class="idea-promote">Promote</button>' +
  //     '<button class="idea-demote">Demote</button>' +
  //     '<button class="idea-delete">Delete</button>' +
  //   '</div>' +
  // '</div>'
  return template
}


