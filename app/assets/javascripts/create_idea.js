var newIdeaTitle, newIdeaBody;

$(document).ready(function () {
  newIdeaTitleInput = $('#new-idea-title')
  newIdeaBodyInput = $('#new-idea-body')
  errorMessageDiv = $('#new-idea-errors')
  ideaList = $('#idea-list')

  $('.new-idea-submit').on('click', createIdea)
})

function createIdea(event) {
  event.preventDefault()
  clearErrorMessages()
  IdeaRepository.create(getNewIdeaInput())
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
    errorMessageDiv.append(messages).addClass('error-present')
}

function clearErrorMessages() {
  errorMessageDiv.text('').removeClass('error-present')
}

function appendNewIdea(idea) {
  ideaList.append(ideaTemplate(idea))
}

function ideaTemplate(idea) {
  var template = '<li class="idea idea-' + idea.id + '>' +
    '<span class="idea-title">' + idea.title + '</span>' +
    '<span class="idea-body">' + idea.body + '</span>' + '</li>'

  //   '<p class="idea-quality"><%= idea.quality %></p>' +
  //   '<div class="idea-qualities idea-buttons">' +
  //     '<button class="idea-promote">Promote</button>' +
  //     '<button class="idea-demote">Demote</button>' +
  //     '<button class="idea-delete">Delete</button>' +
  //   '</div>' +
  // '</div>'
  return template
}

