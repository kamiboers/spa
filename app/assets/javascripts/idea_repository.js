var IdeaRepository = {
  create: function (idea) {
    return $.post('/api/v1/ideas', {idea: idea})
    .fail( function(jqXHR) {
      displayErrors(jqXHR)
    })
    .done(function (data) {
      appendNewIdea(data)
    })
  }
};