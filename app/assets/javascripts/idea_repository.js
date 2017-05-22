var IdeaRepository = {
  create: function (idea) {
    return $.post('/api/v1/ideas', {idea: idea})
    .fail( function(jqXHR) {
      displayErrors(jqXHR)
    })
    .done(function (data) {
      appendNewIdea(data)
    })
  },
  all: function () {
    $.get('/api/v1/ideas')
    .done(function(data){
      data.forEach(function(idea){
        appendNewIdea(idea)
      })
    })
  }
};