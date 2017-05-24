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