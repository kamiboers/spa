var IdeaRepository = {
  create: function (idea) {
    return $.post('/api/v1/ideas', {idea: idea})
    .fail(function(jqXHR) {
      displayErrors(jqXHR)
    })
    .done(function (data) {
      prependIdea(data)
      clearNewIdeaInput()    
    })
  },
  all: function () {
    $.get('/api/v1/ideas')
    .done(function(data){
      data.forEach(function(idea){
        appendIdea(idea)
      })
      assignAllClickFunctions()
    })
  },
  destroy: function(id) {
    $.ajax({ 
            url: '/api/v1/ideas/' + id,
            type: 'DELETE',
            success: removeIdea(id)
    })
    .fail(function(jqXHR) {
      debugger;
      console.log('idea deletion failed')
    })
    .done(function(data){
      console.log(data)
    })
  }
};



function deleteIdea() {
  $.ajax({
    method: 'DELETE',
    url: '/api/v1/ideas/' + this.id
  }).then(function () {
    this.element.remove();
  }.bind(this));
}

function updateIdea() {
  return $.ajax({
    method: 'PUT',
    url: '/api/v1/ideas/' + this.id,
    data: this.toJSON()
  });
}